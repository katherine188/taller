import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/app_database.dart';
import '../../data/repositories/taller_repository.dart';
import '../../domain/enums.dart';
import '../../domain/models.dart';
import '../providers.dart';

/// Filtro de la lista de órdenes. null = abiertas.
class FiltroOrdenesNotifier extends Notifier<EstadoOrden?> {
  @override
  EstadoOrden? build() => null;

  void seleccionar(EstadoOrden? estado) => state = estado;
}

final filtroOrdenesProvider =
    NotifierProvider<FiltroOrdenesNotifier, EstadoOrden?>(FiltroOrdenesNotifier.new);

final ordenesProvider = StreamProvider.autoDispose<List<OrdenResumen>>((ref) {
  final filtro = ref.watch(filtroOrdenesProvider);
  return ref.watch(tallerRepositoryProvider).watchOrdenes(filtro);
});

final ordenProvider = StreamProvider.autoDispose.family<OrdenResumen?, int>(
  (ref, id) => ref.watch(tallerRepositoryProvider).watchOrden(id),
);

final trabajosProvider = StreamProvider.autoDispose.family<List<Trabajo>, int>(
  (ref, id) => ref.watch(tallerRepositoryProvider).watchTrabajos(id),
);

final usosProvider = StreamProvider.autoDispose.family<List<UsoDetalle>, int>(
  (ref, id) => ref.watch(tallerRepositoryProvider).watchUsos(id),
);

/// Costo total derivado: mano de obra + repuestos.
final costoOrdenProvider = Provider.autoDispose.family<CostoOrden, int>((ref, id) {
  final trabajos = ref.watch(trabajosProvider(id)).valueOrNull ?? const <Trabajo>[];
  final usos = ref.watch(usosProvider(id)).valueOrNull ?? const <UsoDetalle>[];
  return CostoOrden.calcular(trabajos, usos);
});

final ordenesViewModelProvider = Provider<OrdenesViewModel>(
  (ref) => OrdenesViewModel(ref.watch(tallerRepositoryProvider)),
);

/// Comandos que la vista puede lanzar sobre las órdenes.
class OrdenesViewModel {
  OrdenesViewModel(this._repo);
  final TallerRepository _repo;

  Future<int> recibirEquipo({
    required String nombreCliente,
    required String telefono,
    required TipoEquipo tipo,
    required String marca,
    required String modelo,
    required String numeroSerie,
    required String falla,
  }) =>
      _repo.recibirEquipo(
        nombreCliente: nombreCliente,
        telefono: telefono,
        tipo: tipo,
        marca: marca,
        modelo: modelo,
        numeroSerie: numeroSerie,
        falla: falla,
      );

  Future<void> tomarOrden(int ordenId, int tecnicoId) => _repo.tomarOrden(ordenId, tecnicoId);
  Future<void> liberarOrden(int ordenId) => _repo.liberarOrden(ordenId);
  Future<void> cambiarEstado(int ordenId, EstadoOrden nuevo) =>
      _repo.cambiarEstado(ordenId, nuevo);
  Future<void> agregarTrabajo(int ordenId, String desc, double costo) =>
      _repo.agregarTrabajo(ordenId, desc, costo);
  Future<Repuesto> usarRepuesto(int ordenId, int repuestoId, int cantidad) =>
      _repo.usarRepuesto(ordenId, repuestoId, cantidad);
  Future<void> quitarRepuesto(int usoId) => _repo.quitarRepuesto(usoId);
}
