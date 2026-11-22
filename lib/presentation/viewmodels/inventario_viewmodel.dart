import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/app_database.dart';
import '../../data/repositories/taller_repository.dart';
import '../providers.dart';

final repuestosProvider = StreamProvider<List<Repuesto>>(
  (ref) => ref.watch(tallerRepositoryProvider).watchRepuestos(),
);

/// Repuestos por agotarse (existencias <= stock mínimo).
final repuestosBajosProvider = StreamProvider<List<Repuesto>>(
  (ref) => ref.watch(tallerRepositoryProvider).watchRepuestosBajos(),
);

final inventarioViewModelProvider = Provider<InventarioViewModel>(
  (ref) => InventarioViewModel(ref.watch(tallerRepositoryProvider)),
);

class InventarioViewModel {
  InventarioViewModel(this._repo);
  final TallerRepository _repo;

  Future<void> crearRepuesto({
    required String nombre,
    required String codigo,
    required double precio,
    required int existencias,
    required int stockMinimo,
  }) =>
      _repo.crearRepuesto(
        nombre: nombre,
        codigo: codigo,
        precio: precio,
        existencias: existencias,
        stockMinimo: stockMinimo,
      );

  Future<void> reponer(int repuestoId, int cantidad) => _repo.reponerStock(repuestoId, cantidad);
}
