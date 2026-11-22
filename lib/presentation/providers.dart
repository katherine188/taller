import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database/app_database.dart';
import '../data/repositories/taller_repository.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final tallerRepositoryProvider = Provider<TallerRepository>(
  (ref) => TallerRepository(ref.watch(databaseProvider)),
);
