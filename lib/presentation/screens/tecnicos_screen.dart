import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodels/tecnicos_viewmodel.dart';
import 'ordenes_lista_screen.dart';

class TecnicosScreen extends ConsumerWidget {
  const TecnicosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carga = ref.watch(cargaTecnicosProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Técnicos')),
      body: carga.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (lista) => ListView(
          children: [
            for (final c in lista)
              ListTile(
                leading: CircleAvatar(child: Text(c.tecnico.nombre[0])),
                title: Text(c.tecnico.nombre),
                subtitle: Text(c.ordenesActivas == 1
                    ? '1 orden activa'
                    : '${c.ordenesActivas} órdenes activas'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => OrdenesListaScreen(
                    titulo: 'Órdenes de ${c.tecnico.nombre}',
                    provider: ordenesPorTecnicoProvider(c.tecnico.id),
                  ),
                )),
              ),
          ],
        ),
      ),
    );
  }
}
