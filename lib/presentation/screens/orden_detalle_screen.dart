import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/app_database.dart';
import '../../domain/enums.dart';
import '../../domain/models.dart';
import '../utils.dart';
import '../viewmodels/ordenes_viewmodel.dart';
import '../widgets/dialogos.dart';
import '../widgets/orden_tile.dart' show EstadoChip;

class OrdenDetalleScreen extends ConsumerWidget {
  const OrdenDetalleScreen({super.key, required this.ordenId});
  final int ordenId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orden = ref.watch(ordenProvider(ordenId));
    return Scaffold(
      appBar: AppBar(title: Text('Orden #$ordenId')),
      body: orden.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (r) => r == null
            ? const Center(child: Text('Orden no encontrada'))
            : _Contenido(resumen: r),
      ),
    );
  }
}

class _Contenido extends ConsumerWidget {
  const _Contenido({required this.resumen});
  final OrdenResumen resumen;

  String _etiquetaAccion(EstadoOrden e) => switch (e) {
        EstadoOrden.lista => 'Marcar como lista',
        EstadoOrden.entregada => 'Entregar al cliente',
        EstadoOrden.enReparacion => 'Volver a reparación',
        EstadoOrden.cancelada => 'Cancelar orden',
        EstadoOrden.recibida => 'Recibida',
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(ordenesViewModelProvider);
    final o = resumen.orden;
    final e = resumen.equipo;
    final editable = o.estado == EstadoOrden.enReparacion;
    final trabajos = ref.watch(trabajosProvider(o.id)).valueOrNull ?? const <Trabajo>[];
    final usos = ref.watch(usosProvider(o.id)).valueOrNull ?? const <UsoDetalle>[];
    final costo = ref.watch(costoOrdenProvider(o.id));
    final titulo = Theme.of(context).textTheme.titleMedium;

    Future<void> tomar() async {
      final t = await elegirTecnico(context, ref);
      if (t == null || !context.mounted) return;
      await ejecutar(context, () => vm.tomarOrden(o.id, t.id), exito: 'Orden tomada por ${t.nombre}');
    }

    Future<void> cambiar(EstadoOrden nuevo) async {
      if (nuevo == EstadoOrden.cancelada || nuevo == EstadoOrden.entregada) {
        final ok = await confirmar(
          context,
          nuevo == EstadoOrden.cancelada
              ? '¿Cancelar la orden? Los repuestos usados volverán al almacén.'
              : '¿Marcar la orden como entregada?',
        );
        if (!ok || !context.mounted) return;
      }
      await ejecutar(context, () => vm.cambiarEstado(o.id, nuevo));
    }

    Future<void> agregarTrabajo() async {
      final v = await pedirCampos(context, titulo: 'Nuevo trabajo', campos: [
        const CampoForm('Descripción del trabajo', validar: validarDescripcion),
        const CampoForm('Costo de mano de obra', teclado: tecladoDecimal, validar: numeroNoNegativo),
      ]);
      if (v == null || !context.mounted) return;
      await ejecutar(context, () => vm.agregarTrabajo(o.id, v[0], parseDouble(v[1])));
    }

    Future<void> usarRepuesto() async {
      final sel = await elegirRepuesto(context, ref);
      if (sel == null || !context.mounted) return;
      await ejecutar(context, () async {
        final r = await vm.usarRepuesto(o.id, sel.$1.id, sel.$2);
        if (context.mounted && r.existencias <= r.stockMinimo) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('⚠ "${r.nombre}" está por agotarse (quedan ${r.existencias})'),
            backgroundColor: Colors.orange.shade800,
          ));
        }
      });
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(iconoTipo(e.tipo), size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text('${e.marca} ${e.modelo}',
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                  EstadoChip(o.estado),
                ]),
                const SizedBox(height: 8),
                Text('${e.tipo.etiqueta} · Serie: ${e.numeroSerie}'),
                Text('Dueño: ${resumen.cliente.nombre} (${resumen.cliente.telefono})'),
                Text('Falla: ${o.falla}'),
                Text('Recibida: ${formatoFecha(o.fechaRecepcion)}'),
                const SizedBox(height: 8),
                Row(children: [
                  const Icon(Icons.engineering, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    resumen.tecnico == null
                        ? 'Sin responsable'
                        : 'Responsable: ${resumen.tecnico!.nombre}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ]),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 8, children: [
          if (o.estado.esAbierta && o.tecnicoId == null)
            FilledButton.icon(
              onPressed: tomar,
              icon: const Icon(Icons.person_add),
              label: const Text('Tomar orden'),
            ),
          if (o.estado == EstadoOrden.enReparacion)
            OutlinedButton.icon(
              onPressed: () => ejecutar(context, () => vm.liberarOrden(o.id),
                  exito: 'Orden liberada'),
              icon: const Icon(Icons.person_remove),
              label: const Text('Liberar'),
            ),
          for (final s in o.estado.siguientes)
            s == EstadoOrden.cancelada
                ? OutlinedButton(
                    onPressed: () => cambiar(s),
                    style: OutlinedButton.styleFrom(foregroundColor: Colors.red.shade700),
                    child: Text(_etiquetaAccion(s)),
                  )
                : FilledButton.tonal(onPressed: () => cambiar(s), child: Text(_etiquetaAccion(s))),
        ]),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: Text('Trabajos realizados', style: titulo)),
          if (editable)
            IconButton(onPressed: agregarTrabajo, icon: const Icon(Icons.add_circle_outline)),
        ]),
        if (trabajos.isEmpty) const Text('Aún no hay trabajos registrados.'),
        for (final t in trabajos)
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.build_outlined),
            title: Text(t.descripcion),
            trailing: Text(dinero(t.costoManoObra)),
          ),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(child: Text('Repuestos utilizados', style: titulo)),
          if (editable)
            IconButton(onPressed: usarRepuesto, icon: const Icon(Icons.add_circle_outline)),
        ]),
        if (usos.isEmpty) const Text('No se han usado repuestos.'),
        for (final u in usos)
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.memory),
            title: Text('${u.uso.cantidad}× ${u.repuesto.nombre}'),
            subtitle: Text('${dinero(u.uso.precioUnitario)} c/u'),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              Text(dinero(u.subtotal)),
              if (editable)
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => ejecutar(context, () => vm.quitarRepuesto(u.uso.id),
                      exito: 'Repuesto devuelto al almacén'),
                ),
            ]),
          ),
        const SizedBox(height: 16),
        Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              _fila('Mano de obra', dinero(costo.manoObra)),
              _fila('Repuestos', dinero(costo.repuestos)),
              const Divider(),
              _fila('TOTAL', dinero(costo.total), negrita: true),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _fila(String a, String b, {bool negrita = false}) {
    final s = TextStyle(fontWeight: negrita ? FontWeight.bold : FontWeight.normal, fontSize: negrita ? 18 : 14);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(a, style: s), Text(b, style: s)]),
    );
  }
}
