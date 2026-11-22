import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/app_database.dart';
import '../viewmodels/inventario_viewmodel.dart';
import '../viewmodels/tecnicos_viewmodel.dart';

class CampoForm {
  const CampoForm(this.etiqueta,
      {this.teclado = TextInputType.text, this.validar});
  final String etiqueta;
  final TextInputType teclado;
  final String? Function(String?)? validar;
}

const tecladoDecimal = TextInputType.numberWithOptions(decimal: true);

/// Diálogo genérico con N campos de texto validados. Devuelve los valores.
Future<List<String>?> pedirCampos(
  BuildContext context, {
  required String titulo,
  required List<CampoForm> campos,
  String confirmar = 'Guardar',
}) =>
    showDialog<List<String>>(
      context: context,
      builder: (_) =>
          _DialogoCampos(titulo: titulo, campos: campos, confirmar: confirmar),
    );

class _DialogoCampos extends StatefulWidget {
  const _DialogoCampos(
      {required this.titulo, required this.campos, required this.confirmar});
  final String titulo;
  final List<CampoForm> campos;
  final String confirmar;

  @override
  State<_DialogoCampos> createState() => _DialogoCamposState();
}

class _DialogoCamposState extends State<_DialogoCampos> {
  final _form = GlobalKey<FormState>();
  late final List<TextEditingController> _ctrls =
      widget.campos.map((_) => TextEditingController()).toList();

  @override
  void dispose() {
    for (final c in _ctrls) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.titulo),
      content: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < widget.campos.length; i++)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                    controller: _ctrls[i],
                    keyboardType: widget.campos[i].teclado,
                    validator: widget.campos[i].validar,
                    decoration: InputDecoration(
                      labelText: widget.campos[i].etiqueta,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar')),
        FilledButton(
          onPressed: () {
            if (_form.currentState!.validate()) {
              Navigator.pop(context, _ctrls.map((c) => c.text.trim()).toList());
            }
          },
          child: Text(widget.confirmar),
        ),
      ],
    );
  }
}

Future<bool> confirmar(BuildContext context, String mensaje) async {
  final r = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      content: Text(mensaje),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('No')),
        FilledButton(
            onPressed: () => Navigator.pop(ctx, true), child: const Text('Sí')),
      ],
    ),
  );
  return r ?? false;
}

Future<Tecnico?> elegirTecnico(BuildContext context, WidgetRef ref) async {
  final tecnicos = await ref.read(tecnicosProvider.future);
  if (!context.mounted) return null;
  return showDialog<Tecnico>(
    context: context,
    builder: (ctx) => SimpleDialog(
      title: const Text('¿Quién toma la orden?'),
      children: [
        for (final t in tecnicos)
          SimpleDialogOption(
              onPressed: () => Navigator.pop(ctx, t), child: Text(t.nombre)),
      ],
    ),
  );
}

/// Elige un repuesto con existencias y una cantidad.
Future<(Repuesto, int)?> elegirRepuesto(
    BuildContext context, WidgetRef ref) async {
  final todos = await ref.read(repuestosProvider.future);
  if (!context.mounted) return null;
  final disponibles = todos.where((r) => r.existencias > 0).toList();
  return showDialog<(Repuesto, int)>(
    context: context,
    builder: (_) => _DialogoUso(disponibles: disponibles),
  );
}

class _DialogoUso extends StatefulWidget {
  const _DialogoUso({required this.disponibles});
  final List<Repuesto> disponibles;

  @override
  State<_DialogoUso> createState() => _DialogoUsoState();
}

class _DialogoUsoState extends State<_DialogoUso> {
  final _form = GlobalKey<FormState>();
  final _cantidad = TextEditingController(text: '1');
  Repuesto? _seleccion;

  @override
  void dispose() {
    _cantidad.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.disponibles.isEmpty) {
      return AlertDialog(
        content: const Text('No hay repuestos con existencias en el almacén.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'))
        ],
      );
    }
    return AlertDialog(
      title: const Text('Usar repuesto'),
      content: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<Repuesto>(
              isExpanded: true,
              initialValue: _seleccion,
              decoration: const InputDecoration(
                  labelText: 'Repuesto', border: OutlineInputBorder()),
              items: [
                for (final r in widget.disponibles)
                  DropdownMenuItem(
                      value: r, child: Text('${r.nombre} (${r.existencias})')),
              ],
              validator: (v) => v == null ? 'Elige un repuesto' : null,
              onChanged: (v) => setState(() => _seleccion = v),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _cantidad,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Cantidad', border: OutlineInputBorder()),
              validator: (v) {
                final n = int.tryParse((v ?? '').trim());
                if (n == null) return 'Ingresa un número entero';
                if (n <= 0) return 'La cantidad debe ser mayor que 0';
                if (_seleccion != null && n > _seleccion!.existencias) {
                  return 'Solo hay ${_seleccion!.existencias} disponibles';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar')),
        FilledButton(
          onPressed: () {
            if (_form.currentState!.validate()) {
              Navigator.pop(context, (_seleccion!, int.parse(_cantidad.text)));
            }
          },
          child: const Text('Usar'),
        ),
      ],
    );
  }
}
