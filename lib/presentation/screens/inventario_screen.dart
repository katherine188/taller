import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils.dart';
import '../viewmodels/inventario_viewmodel.dart';
import '../widgets/dialogos.dart';

class InventarioScreen extends ConsumerStatefulWidget {
  const InventarioScreen({super.key});

  @override
  ConsumerState<InventarioScreen> createState() => _InventarioScreenState();
}

class _InventarioScreenState extends ConsumerState<InventarioScreen> {
  bool _soloBajos = false;

  @override
  Widget build(BuildContext context) {
    final vm = ref.read(inventarioViewModelProvider);
    final repuestos = ref.watch(_soloBajos ? repuestosBajosProvider : repuestosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: const Text('Por agotarse'),
              selected: _soloBajos,
              onSelected: (v) => setState(() => _soloBajos = v),
            ),
          ),
        ],
      ),
      body: repuestos.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (lista) => lista.isEmpty
            ? const Center(child: Text('No hay repuestos'))
            : ListView.builder(
                padding: const EdgeInsets.only(bottom: 88),
                itemCount: lista.length,
                itemBuilder: (_, i) {
                  final r = lista[i];
                  final bajo = r.existencias <= r.stockMinimo;
                  final color = bajo ? Colors.red.shade700 : null;
                  return ListTile(
                    leading: Icon(bajo ? Icons.warning_amber_rounded : Icons.inventory_2_outlined,
                        color: bajo ? Colors.orange.shade800 : null),
                    title: Text(r.nombre),
                    subtitle: Text('${r.codigo} · ${dinero(r.precio)} · mín. ${r.stockMinimo}'),
                    trailing: Text('${r.existencias}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
                    onTap: () async {
                      final v = await pedirCampos(context,
                          titulo: 'Reponer ${r.nombre}',
                          confirmar: 'Reponer',
                          campos: const [
                            CampoForm('Cantidad a agregar',
                                teclado: TextInputType.number, validar: enteroPositivo),
                          ]);
                      if (v == null || !context.mounted) return;
                      await ejecutar(context, () => vm.reponer(r.id, int.parse(v[0])),
                          exito: 'Existencias actualizadas');
                    },
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Nuevo repuesto'),
        onPressed: () async {
          final v = await pedirCampos(context, titulo: 'Nuevo repuesto', campos: const [
            CampoForm('Nombre', validar: validarNombreRepuesto),
            CampoForm('Código', validar: validarCodigo),
            CampoForm('Precio', teclado: tecladoDecimal, validar: precioPositivo),
            CampoForm('Existencias iniciales', teclado: TextInputType.number, validar: enteroNoNegativo),
            CampoForm('Stock mínimo (alerta)', teclado: TextInputType.number, validar: enteroNoNegativo),
          ]);
          if (v == null || !context.mounted) return;
          await ejecutar(
            context,
            () => vm.crearRepuesto(
              nombre: v[0],
              codigo: v[1],
              precio: parseDouble(v[2]),
              existencias: int.parse(v[3]),
              stockMinimo: int.parse(v[4]),
            ),
            exito: 'Repuesto creado',
          );
        },
      ),
    );
  }
}
