import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/app_database.dart';
import '../../domain/enums.dart';
import '../../domain/models.dart';
import '../screens/orden_detalle_screen.dart';
import '../utils.dart';
import '../viewmodels/inventario_viewmodel.dart';
import '../viewmodels/ordenes_viewmodel.dart';

class EstadoChip extends StatelessWidget {
  const EstadoChip(this.estado, {super.key});
  final EstadoOrden estado;

  @override
  Widget build(BuildContext context) {
    final c = colorEstado(estado);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: c),
      ),
      child: Text(estado.etiqueta,
          style: TextStyle(color: c, fontWeight: FontWeight.w600, fontSize: 12)),
    );
  }
}

/// Tarjeta de una orden. Con [conReparacion] muestra qué se hizo y qué piezas se usaron.
class OrdenTile extends StatelessWidget {
  const OrdenTile({super.key, required this.resumen, this.conReparacion = false});
  final OrdenResumen resumen;
  final bool conReparacion;

  @override
  Widget build(BuildContext context) {
    final o = resumen.orden;
    final e = resumen.equipo;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => OrdenDetalleScreen(ordenId: o.id)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Icon(iconoTipo(e.tipo)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text('#${o.id} · ${e.marca} ${e.modelo}',
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                EstadoChip(o.estado),
              ]),
              const SizedBox(height: 6),
              Text('${resumen.cliente.nombre} · ${resumen.cliente.telefono}'),
              Text('Falla: ${o.falla}', maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4),
              Row(children: [
                Icon(Icons.engineering, size: 16, color: Theme.of(context).hintColor),
                const SizedBox(width: 4),
                Text(
                  resumen.tecnico == null
                      ? 'Sin responsable'
                      : 'Responsable: ${resumen.tecnico!.nombre}',
                ),
                const Spacer(),
                Text(formatoFecha(o.fechaRecepcion), style: Theme.of(context).textTheme.bodySmall),
              ]),
              if (conReparacion) ResumenReparacion(ordenId: o.id),
            ],
          ),
        ),
      ),
    );
  }
}

class ResumenReparacion extends ConsumerWidget {
  const ResumenReparacion({super.key, required this.ordenId});
  final int ordenId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trabajos = ref.watch(trabajosProvider(ordenId)).valueOrNull ?? const <Trabajo>[];
    final usos = ref.watch(usosProvider(ordenId)).valueOrNull ?? const <UsoDetalle>[];
    final estilo = Theme.of(context).textTheme.bodySmall;
    if (trabajos.isEmpty && usos.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text('Sin trabajos registrados', style: estilo),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 1),
          const SizedBox(height: 6),
          if (trabajos.isNotEmpty)
            Text('Trabajos: ${trabajos.map((t) => t.descripcion).join(' • ')}', style: estilo),
          if (usos.isNotEmpty)
            Text(
              'Piezas: ${usos.map((u) => '${u.uso.cantidad}× ${u.repuesto.nombre}').join(' • ')}',
              style: estilo,
            ),
        ],
      ),
    );
  }
}

/// Banner que avisa de los repuestos que están por agotarse.
class AlertaStockBajo extends ConsumerWidget {
  const AlertaStockBajo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bajos = ref.watch(repuestosBajosProvider).valueOrNull ?? const <Repuesto>[];
    if (bajos.isEmpty) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      color: Colors.amber.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(children: [
        Icon(Icons.warning_amber_rounded, color: Colors.orange.shade800),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Por agotarse: ${bajos.map((r) => '${r.nombre} (${r.existencias})').join(', ')}',
            style: const TextStyle(color: Colors.black87),
          ),
        ),
      ]),
    );
  }
}
