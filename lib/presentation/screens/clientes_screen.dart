import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/app_database.dart';
import '../utils.dart';
import '../viewmodels/historial_viewmodel.dart';
import '../widgets/orden_tile.dart';
import 'ordenes_lista_screen.dart';

class ClientesScreen extends ConsumerStatefulWidget {
  const ClientesScreen({super.key});

  @override
  ConsumerState<ClientesScreen> createState() => _ClientesScreenState();
}

class _ClientesScreenState extends ConsumerState<ClientesScreen> {
  String _busqueda = '';

  @override
  Widget build(BuildContext context) {
    final clientes = ref.watch(clientesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Clientes e historial')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Buscar por nombre o teléfono',
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => setState(() => _busqueda = v.trim().toLowerCase()),
            ),
          ),
          Expanded(
            child: clientes.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (lista) {
                final filtrada = lista
                    .where((c) =>
                        c.nombre.toLowerCase().contains(_busqueda) ||
                        c.telefono.contains(_busqueda))
                    .toList();
                if (filtrada.isEmpty) return const Center(child: Text('Sin clientes'));
                return ListView.builder(
                  itemCount: filtrada.length,
                  itemBuilder: (_, i) {
                    final c = filtrada[i];
                    return ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(c.nombre),
                      subtitle: Text(c.telefono),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => ClienteDetalleScreen(cliente: c)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ClienteDetalleScreen extends ConsumerWidget {
  const ClienteDetalleScreen({super.key, required this.cliente});
  final Cliente cliente;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final equipos = ref.watch(equiposDeClienteProvider(cliente.id)).valueOrNull ?? const <Equipo>[];
    final ordenes = ref.watch(ordenesPorClienteProvider(cliente.id));
    final titulo = Theme.of(context).textTheme.titleMedium;

    return Scaffold(
      appBar: AppBar(title: Text(cliente.nombre)),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          ListTile(leading: const Icon(Icons.phone), title: Text(cliente.telefono)),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Text('Equipos (toca uno para ver su historial)', style: titulo),
          ),
          for (final e in equipos)
            ListTile(
              leading: Icon(iconoTipo(e.tipo)),
              title: Text('${e.marca} ${e.modelo}'),
              subtitle: Text('Serie: ${e.numeroSerie}'),
              trailing: const Icon(Icons.history),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => OrdenesListaScreen(
                  titulo: 'Historial: ${e.marca} ${e.modelo}',
                  provider: ordenesPorEquipoProvider(e.id),
                  conReparacion: true,
                ),
              )),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text('Historial de reparaciones', style: titulo),
          ),
          ...ordenes.when(
            loading: () => [const Center(child: CircularProgressIndicator())],
            error: (e, _) => [Text('Error: $e')],
            data: (lista) => lista.isEmpty
                ? [const Padding(padding: EdgeInsets.all(16), child: Text('Sin reparaciones'))]
                : [for (final r in lista) OrdenTile(resumen: r, conReparacion: true)],
          ),
        ],
      ),
    );
  }
}
