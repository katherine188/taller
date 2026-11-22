import '../data/database/app_database.dart';

/// Error de regla de negocio con un mensaje apto para mostrar al usuario.
class TallerException implements Exception {
  TallerException(this.mensaje);
  final String mensaje;

  @override
  String toString() => mensaje;
}

/// Una orden junto con su equipo, dueño y técnico responsable.
class OrdenResumen {
  const OrdenResumen({
    required this.orden,
    required this.equipo,
    required this.cliente,
    this.tecnico,
  });

  final Orden orden;
  final Equipo equipo;
  final Cliente cliente;
  final Tecnico? tecnico;
}

/// Repuesto utilizado en una orden (con los datos del repuesto).
class UsoDetalle {
  const UsoDetalle(this.uso, this.repuesto);
  final UsoRepuesto uso;
  final Repuesto repuesto;

  double get subtotal => uso.cantidad * uso.precioUnitario;
}

class CargaTecnico {
  const CargaTecnico(this.tecnico, this.ordenesActivas);
  final Tecnico tecnico;
  final int ordenesActivas;
}

/// Costo total = mano de obra + repuestos.
class CostoOrden {
  const CostoOrden({required this.manoObra, required this.repuestos});
  final double manoObra;
  final double repuestos;

  double get total => manoObra + repuestos;

  factory CostoOrden.calcular(List<Trabajo> trabajos, List<UsoDetalle> usos) {
    return CostoOrden(
      manoObra: trabajos.fold(0.0, (s, t) => s + t.costoManoObra),
      repuestos: usos.fold(0.0, (s, u) => s + u.subtotal),
    );
  }
}
