import 'package:drift/drift.dart';

import '../../domain/enums.dart';

@DataClassName('Cliente')
class Clientes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 100)();
  TextColumn get telefono => text().unique()();
}

@DataClassName('Equipo')
class Equipos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clienteId => integer().references(Clientes, #id)();
  TextColumn get tipo => textEnum<TipoEquipo>()();
  TextColumn get marca => text()();
  TextColumn get modelo => text()();
  TextColumn get numeroSerie => text().unique()();
}

@DataClassName('Tecnico')
class Tecnicos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
}

@DataClassName('Repuesto')
class Repuestos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
  TextColumn get codigo => text().unique()();
  RealColumn get precio => real()();
  IntColumn get existencias => integer()();
  IntColumn get stockMinimo => integer().withDefault(const Constant(3))();
}

@DataClassName('Orden')
class Ordenes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get equipoId => integer().references(Equipos, #id)();

  /// Técnico responsable. Null = nadie la ha tomado.
  IntColumn get tecnicoId => integer().nullable().references(Tecnicos, #id)();
  TextColumn get estado => textEnum<EstadoOrden>()();
  TextColumn get falla => text()();
  DateTimeColumn get fechaRecepcion => dateTime()();
  DateTimeColumn get fechaActualizacion => dateTime()();
}

@DataClassName('Trabajo')
class Trabajos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ordenId => integer().references(Ordenes, #id)();
  TextColumn get descripcion => text()();
  RealColumn get costoManoObra => real()();
  DateTimeColumn get fecha => dateTime()();
}

@DataClassName('UsoRepuesto')
class UsosRepuesto extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ordenId => integer().references(Ordenes, #id)();
  IntColumn get repuestoId => integer().references(Repuestos, #id)();
  IntColumn get cantidad => integer()();

  /// Precio al momento de usarlo (si el precio cambia, el historial no).
  RealColumn get precioUnitario => real()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {ordenId, repuestoId},
      ];
}
