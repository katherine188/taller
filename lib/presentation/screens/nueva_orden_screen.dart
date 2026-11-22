import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/enums.dart';
import '../../domain/models.dart';
import '../utils.dart';
import '../viewmodels/ordenes_viewmodel.dart';

class NuevaOrdenScreen extends ConsumerStatefulWidget {
  const NuevaOrdenScreen({super.key});

  @override
  ConsumerState<NuevaOrdenScreen> createState() => _NuevaOrdenScreenState();
}

class _NuevaOrdenScreenState extends ConsumerState<NuevaOrdenScreen> {
  final _form = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  final _telefono = TextEditingController();
  final _marca = TextEditingController();
  final _modelo = TextEditingController();
  final _serie = TextEditingController();
  final _falla = TextEditingController();
  TipoEquipo _tipo = TipoEquipo.celular;
  bool _guardando = false;

  @override
  void dispose() {
    for (final c in [_nombre, _telefono, _marca, _modelo, _serie, _falla]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_form.currentState!.validate()) return;
    final vm = ref.read(ordenesViewModelProvider);
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _guardando = true);
    try {
      final id = await vm.recibirEquipo(
        nombreCliente: _nombre.text,
        telefono: _telefono.text,
        tipo: _tipo,
        marca: _marca.text,
        modelo: _modelo.text,
        numeroSerie: _serie.text,
        falla: _falla.text,
      );
      navigator.pop();
      messenger.showSnackBar(SnackBar(content: Text('Orden #$id registrada')));
    } on TallerException catch (e) {
      messenger.showSnackBar(
        SnackBar(
            content: Text(e.mensaje), backgroundColor: Colors.red.shade700),
      );
      if (mounted) setState(() => _guardando = false);
    }
  }

  Widget _campo(TextEditingController c, String etiqueta,
      {String? Function(String?)? validar = obligatorio,
      TextInputType teclado = TextInputType.text,
      int lineas = 1,
      TextCapitalization cap = TextCapitalization.sentences}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: c,
        keyboardType: teclado,
        maxLines: lineas,
        textCapitalization: cap,
        validator: validar,
        decoration: InputDecoration(
            labelText: etiqueta, border: const OutlineInputBorder()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final estilo = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      appBar: AppBar(title: const Text('Recibir equipo')),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Dueño', style: estilo),
            const SizedBox(height: 8),
            _campo(_nombre, 'Nombre',
                cap: TextCapitalization.words, validar: validarNombre),
            _campo(_telefono, 'Teléfono',
                validar: validarTelefono, teclado: TextInputType.phone),
            Text('Equipo', style: estilo),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: DropdownButtonFormField<TipoEquipo>(
                initialValue: _tipo,
                decoration: const InputDecoration(
                    labelText: 'Tipo', border: OutlineInputBorder()),
                items: [
                  for (final t in TipoEquipo.values)
                    DropdownMenuItem(value: t, child: Text(t.etiqueta)),
                ],
                onChanged: (v) => setState(() => _tipo = v ?? _tipo),
              ),
            ),
            _campo(_marca, 'Marca',
                cap: TextCapitalization.words, validar: validarMarca),
            _campo(_modelo, 'Modelo',
                cap: TextCapitalization.words, validar: validarModelo),
            _campo(_serie, 'Número de serie / IMEI',
                cap: TextCapitalization.characters,
                validar: validarNumeroSerie),
            Text('Falla reportada', style: estilo),
            const SizedBox(height: 8),
            _campo(_falla, 'Describe la falla',
                lineas: 3, validar: validarDescripcion),
            FilledButton.icon(
              onPressed: _guardando ? null : _guardar,
              icon: const Icon(Icons.save),
              label: const Text('Registrar orden'),
            ),
          ],
        ),
      ),
    );
  }
}
