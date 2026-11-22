import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/enums.dart';
import '../viewmodels/ordenes_viewmodel.dart';
import '../widgets/orden_tile.dart';
import 'nueva_orden_screen.dart';

class OrdenesScreen extends ConsumerWidget {
  const OrdenesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filtro = ref.watch(filtroOrdenesProvider);
    final notifier = ref.read(filtroOrdenesProvider.notifier);
    final ordenes = ref.watch(ordenesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Órdenes de reparación')),
      body: Column(
        children: [
          const AlertaStockBajo(),
          SizedBox(
            height: 56,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: const Text('Abiertas'),
                      selected: filtro == null,
                      onSelected: (_) => notifier.seleccionar(null),
                    ),
                  ),
                ),
                for (final e in EstadoOrden.values)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(e.etiqueta),
                        selected: filtro == e,
                        onSelected: (_) => notifier.seleccionar(e),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: ordenes.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (lista) => lista.isEmpty
                  ? const Center(child: Text('No hay órdenes en este estado'))
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 88),
                      itemCount: lista.length,
                      itemBuilder: (_, i) => OrdenTile(resumen: lista[i]),
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Recibir equipo'),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const NuevaOrdenScreen())),
      ),
    );
  }
}
