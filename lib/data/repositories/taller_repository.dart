import 'package:drift/drift.dart';

import '../../domain/enums.dart';
import '../../domain/models.dart';
import '../database/app_database.dart';

/// Único punto de acceso a los datos. Aquí viven las reglas del taller:
/// cada operación que toca varias tablas se ejecuta en una transacción.
class TallerRepository {
  TallerRepository(this._db);
  final AppDatabase _db;

  // ───────────────────────── Consultas (streams reactivos) ─────────────────

  Stream<List<OrdenResumen>> _watchResumen(Expression<bool> condicion) {
    final q = _db.select(_db.ordenes).join([
      innerJoin(_db.equipos, _db.equipos.id.equalsExp(_db.ordenes.equipoId)),
      innerJoin(_db.clientes, _db.clientes.id.equalsExp(_db.equipos.clienteId)),
      leftOuterJoin(_db.tecnicos, _db.tecnicos.id.equalsExp(_db.ordenes.tecnicoId)),
    ])
      ..where(condicion)
      ..orderBy([OrderingTerm.desc(_db.ordenes.fechaActualizacion)]);

    return q.watch().map((filas) => filas
        .map((r) => OrdenResumen(
              orden: r.readTable(_db.ordenes),
              equipo: r.readTable(_db.equipos),
              cliente: r.readTable(_db.clientes),
              tecnico: r.readTableOrNull(_db.tecnicos),
            ))
        .toList());
  }

  /// [estado] null = todas las órdenes abiertas.
  Stream<List<OrdenResumen>> watchOrdenes(EstadoOrden? estado) => _watchResumen(
        estado == null
            ? _db.ordenes.estado.isInValues(EstadoOrden.abiertas)
            : _db.ordenes.estado.equalsValue(estado),
      );

  Stream<OrdenResumen?> watchOrden(int id) => _watchResumen(_db.ordenes.id.equals(id))
      .map((l) => l.isEmpty ? null : l.first);

  Stream<List<OrdenResumen>> watchOrdenesPorTecnico(int tecnicoId) => _watchResumen(
      _db.ordenes.tecnicoId.equals(tecnicoId) &
          _db.ordenes.estado.isInValues(EstadoOrden.abiertas));

  Stream<List<OrdenResumen>> watchOrdenesPorEquipo(int equipoId) =>
      _watchResumen(_db.ordenes.equipoId.equals(equipoId));

  Stream<List<OrdenResumen>> watchOrdenesPorCliente(int clienteId) =>
      _watchResumen(_db.equipos.clienteId.equals(clienteId));

  Stream<List<Trabajo>> watchTrabajos(int ordenId) => (_db.select(_db.trabajos)
        ..where((t) => t.ordenId.equals(ordenId))
        ..orderBy([(t) => OrderingTerm.asc(t.fecha)]))
      .watch();

  Stream<List<UsoDetalle>> watchUsos(int ordenId) {
    final q = _db.select(_db.usosRepuesto).join([
      innerJoin(_db.repuestos, _db.repuestos.id.equalsExp(_db.usosRepuesto.repuestoId)),
    ])
      ..where(_db.usosRepuesto.ordenId.equals(ordenId));
    return q.watch().map((filas) => filas
        .map((r) => UsoDetalle(r.readTable(_db.usosRepuesto), r.readTable(_db.repuestos)))
        .toList());
  }

  Stream<List<Tecnico>> watchTecnicos() =>
      (_db.select(_db.tecnicos)..orderBy([(t) => OrderingTerm.asc(t.nombre)])).watch();

  /// Órdenes "en reparación" o "listas" que tiene cada técnico.
  Stream<List<CargaTecnico>> watchCargaTecnicos() {
    final cuenta = _db.ordenes.id.count();
    final q = _db.select(_db.tecnicos).join([
      leftOuterJoin(
        _db.ordenes,
        _db.ordenes.tecnicoId.equalsExp(_db.tecnicos.id) &
            _db.ordenes.estado.isInValues(
                const [EstadoOrden.enReparacion, EstadoOrden.lista]),
      ),
    ]);
    q.addColumns([cuenta]);
    q.groupBy([_db.tecnicos.id]);
    q.orderBy([OrderingTerm.asc(_db.tecnicos.nombre)]);
    return q.watch().map((filas) => filas
        .map((r) => CargaTecnico(r.readTable(_db.tecnicos), r.read(cuenta) ?? 0))
        .toList());
  }

  Stream<List<Repuesto>> watchRepuestos() =>
      (_db.select(_db.repuestos)..orderBy([(r) => OrderingTerm.asc(r.nombre)])).watch();

  /// Repuestos con existencias <= stock mínimo.
  Stream<List<Repuesto>> watchRepuestosBajos() => (_db.select(_db.repuestos)
        ..where((r) => r.existencias.isSmallerOrEqual(r.stockMinimo))
        ..orderBy([(r) => OrderingTerm.asc(r.existencias)]))
      .watch();

  Stream<List<Cliente>> watchClientes() =>
      (_db.select(_db.clientes)..orderBy([(c) => OrderingTerm.asc(c.nombre)])).watch();

  Stream<List<Equipo>> watchEquiposDeCliente(int clienteId) =>
      (_db.select(_db.equipos)..where((e) => e.clienteId.equals(clienteId))).watch();

  // ───────────────────────── Comandos (reglas de negocio) ──────────────────

  Future<Orden> _obtenerOrden(int id) =>
      (_db.select(_db.ordenes)..where((o) => o.id.equals(id))).getSingle();

  Future<void> _tocarOrden(int id) =>
      (_db.update(_db.ordenes)..where((o) => o.id.equals(id)))
          .write(OrdenesCompanion(fechaActualizacion: Value(DateTime.now())));

  void _exigirEditable(Orden o) {
    if (o.estado != EstadoOrden.enReparacion) {
      throw TallerException(
          'Solo se pueden registrar trabajos y repuestos en órdenes "En reparación".');
    }
  }

  /// Registra la llegada de un equipo: reutiliza cliente (por teléfono) y
  /// equipo (por número de serie) si ya existen, y crea la orden.
  Future<int> recibirEquipo({
    required String nombreCliente,
    required String telefono,
    required TipoEquipo tipo,
    required String marca,
    required String modelo,
    required String numeroSerie,
    required String falla,
  }) {
    return _db.transaction(() async {
      final tel = telefono.trim();
      final nombre = nombreCliente.trim();

      final cliente = await (_db.select(_db.clientes)..where((c) => c.telefono.equals(tel)))
          .getSingleOrNull();
      final int clienteId;
      if (cliente == null) {
        clienteId = await _db
            .into(_db.clientes)
            .insert(ClientesCompanion.insert(nombre: nombre, telefono: tel));
      } else {
        clienteId = cliente.id;
        if (cliente.nombre != nombre) {
          await (_db.update(_db.clientes)..where((c) => c.id.equals(clienteId)))
              .write(ClientesCompanion(nombre: Value(nombre)));
        }
      }

      final serie = numeroSerie.trim().toUpperCase();
      final equipo = await (_db.select(_db.equipos)..where((e) => e.numeroSerie.equals(serie)))
          .getSingleOrNull();
      final int equipoId;
      if (equipo == null) {
        equipoId = await _db.into(_db.equipos).insert(EquiposCompanion.insert(
              clienteId: clienteId,
              tipo: tipo,
              marca: marca.trim(),
              modelo: modelo.trim(),
              numeroSerie: serie,
            ));
      } else {
        equipoId = equipo.id;
        // Si cambió de dueño, queda asociado al dueño actual.
        if (equipo.clienteId != clienteId) {
          await (_db.update(_db.equipos)..where((e) => e.id.equals(equipoId)))
              .write(EquiposCompanion(clienteId: Value(clienteId)));
        }
      }

      final abiertas = await (_db.select(_db.ordenes)
            ..where((o) =>
                o.equipoId.equals(equipoId) & o.estado.isInValues(EstadoOrden.abiertas)))
          .get();
      if (abiertas.isNotEmpty) {
        throw TallerException(
            'Este equipo ya tiene una orden abierta (#${abiertas.first.id}).');
      }

      final ahora = DateTime.now();
      return _db.into(_db.ordenes).insert(OrdenesCompanion.insert(
            equipoId: equipoId,
            estado: EstadoOrden.recibida,
            falla: falla.trim(),
            fechaRecepcion: ahora,
            fechaActualizacion: ahora,
          ));
    });
  }

  /// Un técnico toma la orden. Al ser transacción, si dos técnicos intentan
  /// tomarla a la vez, el segundo recibe el error.
  Future<void> tomarOrden(int ordenId, int tecnicoId) {
    return _db.transaction(() async {
      final orden = await _obtenerOrden(ordenId);
      if (!orden.estado.esAbierta) {
        throw TallerException('La orden ya está ${orden.estado.etiqueta.toLowerCase()}.');
      }
      if (orden.tecnicoId != null && orden.tecnicoId != tecnicoId) {
        final otro = await (_db.select(_db.tecnicos)..where((t) => t.id.equals(orden.tecnicoId!)))
            .getSingle();
        throw TallerException('La orden ya fue tomada por ${otro.nombre}.');
      }
      await (_db.update(_db.ordenes)..where((o) => o.id.equals(ordenId))).write(
        OrdenesCompanion(
          tecnicoId: Value(tecnicoId),
          estado: Value(orden.estado == EstadoOrden.recibida
              ? EstadoOrden.enReparacion
              : orden.estado),
          fechaActualizacion: Value(DateTime.now()),
        ),
      );
    });
  }

  /// El técnico suelta la orden para que otro pueda tomarla.
  Future<void> liberarOrden(int ordenId) {
    return _db.transaction(() async {
      final orden = await _obtenerOrden(ordenId);
      if (orden.estado != EstadoOrden.enReparacion) {
        throw TallerException('Solo se puede liberar una orden "En reparación".');
      }
      await (_db.update(_db.ordenes)..where((o) => o.id.equals(ordenId))).write(
        OrdenesCompanion(
          tecnicoId: const Value(null),
          estado: const Value(EstadoOrden.recibida),
          fechaActualizacion: Value(DateTime.now()),
        ),
      );
    });
  }

  Future<void> cambiarEstado(int ordenId, EstadoOrden nuevo) {
    return _db.transaction(() async {
      final orden = await _obtenerOrden(ordenId);
      if (!orden.estado.siguientes.contains(nuevo)) {
        throw TallerException(
            'No se puede pasar de ${orden.estado.etiqueta} a ${nuevo.etiqueta}.');
      }
      // Si se cancela, las piezas vuelven al almacén.
      if (nuevo == EstadoOrden.cancelada) {
        final usos = await (_db.select(_db.usosRepuesto)..where((u) => u.ordenId.equals(ordenId)))
            .get();
        for (final u in usos) {
          await _sumarExistencias(u.repuestoId, u.cantidad);
        }
        await (_db.delete(_db.usosRepuesto)..where((u) => u.ordenId.equals(ordenId))).go();
      }
      await (_db.update(_db.ordenes)..where((o) => o.id.equals(ordenId))).write(
        OrdenesCompanion(estado: Value(nuevo), fechaActualizacion: Value(DateTime.now())),
      );
    });
  }

  Future<void> _sumarExistencias(int repuestoId, int cantidad) async {
    final rep =
        await (_db.select(_db.repuestos)..where((r) => r.id.equals(repuestoId))).getSingle();
    await (_db.update(_db.repuestos)..where((r) => r.id.equals(repuestoId)))
        .write(RepuestosCompanion(existencias: Value(rep.existencias + cantidad)));
  }

  Future<void> agregarTrabajo(int ordenId, String descripcion, double costo) {
    return _db.transaction(() async {
      _exigirEditable(await _obtenerOrden(ordenId));
      await _db.into(_db.trabajos).insert(TrabajosCompanion.insert(
            ordenId: ordenId,
            descripcion: descripcion.trim(),
            costoManoObra: costo,
            fecha: DateTime.now(),
          ));
      await _tocarOrden(ordenId);
    });
  }

  /// Usa un repuesto en la orden y descuenta existencias.
  /// Devuelve el repuesto actualizado para poder avisar si queda poco stock.
  Future<Repuesto> usarRepuesto(int ordenId, int repuestoId, int cantidad) {
    return _db.transaction(() async {
      _exigirEditable(await _obtenerOrden(ordenId));
      if (cantidad <= 0) throw TallerException('La cantidad debe ser mayor que 0.');

      final rep =
          await (_db.select(_db.repuestos)..where((r) => r.id.equals(repuestoId))).getSingle();
      if (rep.existencias < cantidad) {
        throw TallerException(
            'No hay suficientes "${rep.nombre}" (existencias: ${rep.existencias}).');
      }
      await (_db.update(_db.repuestos)..where((r) => r.id.equals(repuestoId)))
          .write(RepuestosCompanion(existencias: Value(rep.existencias - cantidad)));

      final uso = await (_db.select(_db.usosRepuesto)
            ..where((u) => u.ordenId.equals(ordenId) & u.repuestoId.equals(repuestoId)))
          .getSingleOrNull();
      if (uso == null) {
        await _db.into(_db.usosRepuesto).insert(UsosRepuestoCompanion.insert(
              ordenId: ordenId,
              repuestoId: repuestoId,
              cantidad: cantidad,
              precioUnitario: rep.precio,
            ));
      } else {
        await (_db.update(_db.usosRepuesto)..where((u) => u.id.equals(uso.id)))
            .write(UsosRepuestoCompanion(cantidad: Value(uso.cantidad + cantidad)));
      }
      await _tocarOrden(ordenId);
      return rep.copyWith(existencias: rep.existencias - cantidad);
    });
  }

  /// Quita un repuesto de la orden (por error) y lo devuelve al almacén.
  Future<void> quitarRepuesto(int usoId) {
    return _db.transaction(() async {
      final uso =
          await (_db.select(_db.usosRepuesto)..where((u) => u.id.equals(usoId))).getSingle();
      _exigirEditable(await _obtenerOrden(uso.ordenId));
      await _sumarExistencias(uso.repuestoId, uso.cantidad);
      await (_db.delete(_db.usosRepuesto)..where((u) => u.id.equals(usoId))).go();
      await _tocarOrden(uso.ordenId);
    });
  }

  Future<void> crearRepuesto({
    required String nombre,
    required String codigo,
    required double precio,
    required int existencias,
    required int stockMinimo,
  }) async {
    final cod = codigo.trim().toUpperCase();
    final existe = await (_db.select(_db.repuestos)..where((r) => r.codigo.equals(cod)))
        .getSingleOrNull();
    if (existe != null) throw TallerException('Ya existe un repuesto con el código $cod.');
    await _db.into(_db.repuestos).insert(RepuestosCompanion.insert(
          nombre: nombre.trim(),
          codigo: cod,
          precio: precio,
          existencias: existencias,
          stockMinimo: Value(stockMinimo),
        ));
  }

  Future<void> reponerStock(int repuestoId, int cantidad) {
    if (cantidad <= 0) throw TallerException('La cantidad debe ser mayor que 0.');
    return _db.transaction(() => _sumarExistencias(repuestoId, cantidad));
  }
}
