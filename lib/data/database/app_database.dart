import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../domain/enums.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Clientes, Equipos, Tecnicos, Repuestos, Ordenes, Trabajos, UsosRepuesto],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'tu_solution'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _sembrarDatos();
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  /// Datos iniciales: los 3 técnicos del taller y un pequeño almacén.
  Future<void> _sembrarDatos() async {
    await batch((b) {
      b.insertAll(tecnicos, [
        TecnicosCompanion.insert(nombre: 'Carlos Méndez'),
        TecnicosCompanion.insert(nombre: 'Laura Pérez'),
        TecnicosCompanion.insert(nombre: 'Yosvani Díaz'),
      ]);
      b.insertAll(repuestos, [
        RepuestosCompanion.insert(
            nombre: 'Pantalla celular 6.1"', codigo: 'PAN-001', precio: 45, existencias: 5, stockMinimo: const Value(2)),
        RepuestosCompanion.insert(
            nombre: 'Batería celular estándar', codigo: 'BAT-001', precio: 18, existencias: 8, stockMinimo: const Value(3)),
        RepuestosCompanion.insert(
            nombre: 'Conector de carga USB-C', codigo: 'CON-001', precio: 6.5, existencias: 4, stockMinimo: const Value(3)),
        RepuestosCompanion.insert(
            nombre: 'Módulo de cámara trasera', codigo: 'CAM-001', precio: 22, existencias: 2, stockMinimo: const Value(3)),
        RepuestosCompanion.insert(
            nombre: 'Pantalla tablet 10"', codigo: 'PAN-002', precio: 60, existencias: 3, stockMinimo: const Value(2)),
        RepuestosCompanion.insert(
            nombre: 'Teclado laptop', codigo: 'TEC-001', precio: 28, existencias: 1, stockMinimo: const Value(2)),
      ]);
    });
  }
}
