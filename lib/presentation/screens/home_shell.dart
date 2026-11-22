import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/app_database.dart';
import '../viewmodels/inventario_viewmodel.dart';
import 'clientes_screen.dart';
import 'inventario_screen.dart';
import 'ordenes_screen.dart';
import 'tecnicos_screen.dart';

class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key});

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  int _indice = 0;

  static const _paginas = <Widget>[
    OrdenesScreen(),
    TecnicosScreen(),
    InventarioScreen(),
    ClientesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final bajos = ref.watch(repuestosBajosProvider).valueOrNull ?? const <Repuesto>[];
    return Scaffold(
      body: IndexedStack(index: _indice, children: _paginas),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indice,
        onDestinationSelected: (i) => setState(() => _indice = i),
        destinations: [
          const NavigationDestination(icon: Icon(Icons.assignment_outlined), label: 'Órdenes'),
          const NavigationDestination(icon: Icon(Icons.engineering_outlined), label: 'Técnicos'),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: bajos.isNotEmpty,
              label: Text('${bajos.length}'),
              child: const Icon(Icons.inventory_2_outlined),
            ),
            label: 'Inventario',
          ),
          const NavigationDestination(icon: Icon(Icons.history), label: 'Historial'),
        ],
      ),
    );
  }
}
