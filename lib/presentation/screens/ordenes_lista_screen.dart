import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models.dart';
import '../widgets/orden_tile.dart';

/// Lista genérica de órdenes (por técnico, por equipo, por cliente...).
class OrdenesListaScreen extends ConsumerWidget {
  const OrdenesListaScreen({
    super.key,
    required this.titulo,
    required this.provider,
    this.conReparacion = false,
  });

  final String titulo;
  final ProviderListenable<AsyncValue<List<OrdenResumen>>> provider;
  final bool conReparacion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordenes = ref.watch(provider);
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: ordenes.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (lista) => lista.isEmpty
            ? const Center(child: Text('No hay órdenes'))
            : ListView.builder(
                itemCount: lista.length,
                itemBuilder: (_, i) => OrdenTile(resumen: lista[i], conReparacion: conReparacion),
              ),
      ),
    );
  }
}
