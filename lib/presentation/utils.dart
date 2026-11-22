import 'package:flutter/material.dart';

import '../domain/enums.dart';
import '../domain/models.dart';

String formatoFecha(DateTime f) {
  String d(int n) => n.toString().padLeft(2, '0');
  return '${d(f.day)}/${d(f.month)}/${f.year} ${d(f.hour)}:${d(f.minute)}';
}

String dinero(double v) => '\$${v.toStringAsFixed(2)}';

double parseDouble(String s) => double.parse(s.replaceAll(',', '.'));

Color colorEstado(EstadoOrden e) => switch (e) {
      EstadoOrden.recibida => Colors.blueGrey,
      EstadoOrden.enReparacion => Colors.orange.shade800,
      EstadoOrden.lista => Colors.green.shade700,
      EstadoOrden.entregada => Colors.indigo,
      EstadoOrden.cancelada => Colors.red.shade700,
    };

IconData iconoTipo(TipoEquipo t) => switch (t) {
      TipoEquipo.celular => Icons.smartphone,
      TipoEquipo.tablet => Icons.tablet_mac,
      TipoEquipo.laptop => Icons.laptop,
    };

// ── Validadores de formularios ──

const _maxTexto = 100;
const _maxDescripcion = 300;
const _maxPrecio = 1000000.0;
const _maxEntero = 1000000;

String? obligatorio(String? v) =>
    (v == null || v.trim().isEmpty) ? 'Campo obligatorio' : null;

/// Nombre de una persona: solo letras, espacios, apóstrofos, puntos y guiones.
String? validarNombre(String? v) {
  final s = (v ?? '').trim();
  if (s.isEmpty) return 'Campo obligatorio';
  if (s.length < 2) return 'Escribe al menos 2 caracteres';
  if (s.length > _maxTexto) return 'Máximo $_maxTexto caracteres';
  if (RegExp(r'\d').hasMatch(s)) return 'El nombre no puede contener números';
  if (!RegExp(r"^[a-zA-ZÁÉÍÓÚÜÑáéíóúüñ' .-]+$").hasMatch(s)) {
    return 'Solo se permiten letras, espacios, puntos, apóstrofos y guiones';
  }
  if (RegExp(r'[a-zA-ZÁÉÍÓÚÜÑáéíóúüñ]').allMatches(s).length < 2) {
    return 'El nombre debe tener al menos 2 letras';
  }
  return null;
}

/// Teléfono local: exactamente 8 números. Se permiten espacios, + y guiones
/// como separadores, pero no cuentan como dígitos.
String? validarTelefono(String? v) {
  final s = (v ?? '').trim();
  if (s.isEmpty) return 'Campo obligatorio';
  if (!RegExp(r'^\+?[0-9\s-]+$').hasMatch(s)) {
    return 'Solo números, espacios, + y -';
  }
  final digitos = s.replaceAll(RegExp(r'\D'), '');
  if (digitos.length != 8) {
    return 'El teléfono debe tener 8 números (${digitos.length}/8)';
  }
  return null;
}

/// Marca del equipo: letras y espacios (sin números).
String? validarMarca(String? v) {
  final s = (v ?? '').trim();
  if (s.isEmpty) return 'Campo obligatorio';
  if (s.length < 2) return 'Escribe al menos 2 caracteres';
  if (s.length > 50) return 'Máximo 50 caracteres';
  if (RegExp(r'\d').hasMatch(s)) return 'La marca no puede contener números';
  if (!RegExp(r"^[a-zA-ZÁÉÍÓÚÜÑáéíóúüñ' .&-]+$").hasMatch(s)) {
    return 'Solo se permiten letras, espacios y &';
  }
  return null;
}

/// Modelo del equipo: admite letras, números y separadores comunes.
String? validarModelo(String? v) {
  final s = (v ?? '').trim();
  if (s.isEmpty) return 'Campo obligatorio';
  if (s.length < 2) return 'Escribe al menos 2 caracteres';
  if (s.length > 50) return 'Máximo 50 caracteres';
  if (!RegExp(r"^[a-zA-Z0-9ÁÉÍÓÚÜÑáéíóúüñ' ._/+&-]+$").hasMatch(s)) {
    return 'Solo letras, números, espacios y - _ / + &';
  }
  if (!RegExp(r'[a-zA-ZÁÉÍÓÚÜÑáéíóúüñ]').hasMatch(s)) {
    return 'El modelo debe incluir al menos una letra';
  }
  return null;
}

/// Número de serie / IMEI: alfanumérico, sin espacios.
String? validarNumeroSerie(String? v) {
  final s = (v ?? '').trim();
  if (s.isEmpty) return 'Campo obligatorio';
  if (s.length < 4) return 'Mínimo 4 caracteres';
  if (s.length > 30) return 'Máximo 30 caracteres';
  if (RegExp(r'\s').hasMatch(s)) return 'No puede contener espacios';
  if (!RegExp(r'^[A-Za-z0-9_-]+$').hasMatch(s)) {
    return 'Solo letras, números, guiones y guiones bajos';
  }
  return null;
}

/// Descripción de una falla o trabajo: texto real, no solo números o símbolos.
String? validarDescripcion(String? v) {
  final s = (v ?? '').trim();
  if (s.isEmpty) return 'Campo obligatorio';
  if (s.length < 5) return 'Escribe al menos 5 caracteres';
  if (s.length > _maxDescripcion) return 'Máximo $_maxDescripcion caracteres';
  if (RegExp(r'[a-zA-ZÁÉÍÓÚÜÑáéíóúüñ]').allMatches(s).length < 3) {
    return 'Escribe una descripción con al menos 3 letras';
  }
  return null;
}

/// Nombre de un repuesto: puede llevar números y símbolos, pero debe tener letras.
String? validarNombreRepuesto(String? v) {
  final s = (v ?? '').trim();
  if (s.isEmpty) return 'Campo obligatorio';
  if (s.length < 3) return 'Escribe al menos 3 caracteres';
  if (s.length > 80) return 'Máximo 80 caracteres';
  if (RegExp(r'[a-zA-ZÁÉÍÓÚÜÑáéíóúüñ]').allMatches(s).length < 2) {
    return 'Debe incluir al menos 2 letras';
  }
  return null;
}

/// Código de repuesto: alfanumérico, sin espacios.
String? validarCodigo(String? v) {
  final s = (v ?? '').trim();
  if (s.isEmpty) return 'Campo obligatorio';
  if (s.length < 2) return 'Mínimo 2 caracteres';
  if (s.length > 20) return 'Máximo 20 caracteres';
  if (RegExp(r'\s').hasMatch(s)) return 'No puede contener espacios';
  if (!RegExp(r'^[A-Za-z0-9_-]+$').hasMatch(s)) {
    return 'Solo letras, números, guiones y guiones bajos';
  }
  return null;
}

/// Precio: número mayor que 0.
String? precioPositivo(String? v) {
  final n = double.tryParse((v ?? '').trim().replaceAll(',', '.'));
  if (n == null) return 'Ingresa un precio válido';
  if (n <= 0) return 'El precio debe ser mayor que 0';
  if (n > _maxPrecio) return 'Precio demasiado alto';
  return null;
}

/// Costo o monto: número mayor o igual que 0.
String? numeroNoNegativo(String? v) {
  final n = double.tryParse((v ?? '').trim().replaceAll(',', '.'));
  if (n == null) return 'Ingresa un número válido';
  if (n < 0) return 'No puede ser negativo';
  if (n > _maxPrecio) return 'Valor demasiado alto';
  return null;
}

String? enteroPositivo(String? v) {
  final n = int.tryParse((v ?? '').trim());
  if (n == null) return 'Ingresa un número entero';
  if (n <= 0) return 'Debe ser mayor que 0';
  if (n > _maxEntero) return 'Cantidad demasiado alta';
  return null;
}

String? enteroNoNegativo(String? v) {
  final n = int.tryParse((v ?? '').trim());
  if (n == null) return 'Ingresa un número entero';
  if (n < 0) return 'No puede ser negativo';
  if (n > _maxEntero) return 'Cantidad demasiado alta';
  return null;
}

/// Ejecuta una acción mostrando en un SnackBar los errores de regla de negocio.
Future<void> ejecutar(
  BuildContext context,
  Future<void> Function() accion, {
  String? exito,
}) async {
  final messenger = ScaffoldMessenger.of(context);
  try {
    await accion();
    if (exito != null) messenger.showSnackBar(SnackBar(content: Text(exito)));
  } on TallerException catch (e) {
    messenger.showSnackBar(
      SnackBar(content: Text(e.mensaje), backgroundColor: Colors.red.shade700),
    );
  }
}
