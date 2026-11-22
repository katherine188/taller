import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/app_database.dart';
import '../../domain/models.dart';
import '../providers.dart';

final clientesProvider = StreamProvider.autoDispose<List<Cliente>>(
  (ref) => ref.watch(tallerRepositoryProvider).watchClientes(),
);

final equiposDeClienteProvider = StreamProvider.autoDispose.family<List<Equipo>, int>(
  (ref, clienteId) => ref.watch(tallerRepositoryProvider).watchEquiposDeCliente(clienteId),
);

/// Historial de reparaciones de un equipo.
final ordenesPorEquipoProvider =
    StreamProvider.autoDispose.family<List<OrdenResumen>, int>(
  (ref, id) => ref.watch(tallerRepositoryProvider).watchOrdenesPorEquipo(id),
);

/// Historial de reparaciones de un cliente (todos sus equipos).
final ordenesPorClienteProvider =
    StreamProvider.autoDispose.family<List<OrdenResumen>, int>(
  (ref, id) => ref.watch(tallerRepositoryProvider).watchOrdenesPorCliente(id),
);
