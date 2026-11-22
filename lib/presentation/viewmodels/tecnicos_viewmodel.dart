import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/app_database.dart';
import '../../domain/models.dart';
import '../providers.dart';

final tecnicosProvider = StreamProvider<List<Tecnico>>(
  (ref) => ref.watch(tallerRepositoryProvider).watchTecnicos(),
);

final cargaTecnicosProvider = StreamProvider.autoDispose<List<CargaTecnico>>(
  (ref) => ref.watch(tallerRepositoryProvider).watchCargaTecnicos(),
);

final ordenesPorTecnicoProvider =
    StreamProvider.autoDispose.family<List<OrdenResumen>, int>(
  (ref, id) => ref.watch(tallerRepositoryProvider).watchOrdenesPorTecnico(id),
);
