# Tu Solution — Gestión de reparaciones

App Flutter (Android) para un taller de reparación de celulares, tablets y laptops.
Funciona **sin conexión** y guarda todo en SQLite (Drift). Estado con Riverpod y arquitectura MVVM.

Examen Parcial 2 — Programación para Dispositivos Móviles.

## Funcionalidades
- Recibir equipos (dueño, equipo, falla) y crear la orden de reparación.
- Flujo de estados: Recibida → En reparación → Lista → Entregada (o Cancelada).
- Un técnico **toma** la orden y queda como único responsable (nadie más puede tomarla).
- Registro de trabajos (mano de obra) y repuestos usados; las existencias bajan solas.
- Alertas de repuestos por agotarse (banner, insignia en el menú y filtro en Inventario).
- Carga de trabajo por técnico, e historial por equipo y por cliente (qué se reparó y qué piezas se cambiaron).
- Costo total = mano de obra + repuestos.

## Requisitos
- Flutter 3.27 o superior (Dart 3.6+) 
- Android Studio (o VS Code) con un emulador Android o un teléfono con depuración USB
- Git

## Cómo abrir y ejecutar (paso a paso)
1. Clona el repositorio:
   ```bash
   git clone https://github.com/katherine188/taller
   cd tu_solution
   ```
2. Descarga las dependencias:
   ```bash
   flutter pub get
   ```
3. Inicia un emulador (o conecta un teléfono) y verifica que aparezca:
   ```bash
   flutter devices
   ```
4. Ejecuta la app:
   ```bash
   flutter run
   ```

> El repositorio ya incluye la carpeta `android/` y el código generado de Drift
> (`lib/data/database/app_database.g.dart`). Si por algún motivo falta, ejecuta
> `setup.bat` (Windows) o `./setup.sh` (Linux/Mac), que lo vuelven a crear.

La primera vez la base de datos se crea con 3 técnicos y 6 repuestos de ejemplo.

## Estructura
```
lib/
  domain/        enums, modelos y errores de negocio
  data/          tablas Drift, base de datos y TallerRepository (reglas + transacciones)
  presentation/  providers y viewmodels (Riverpod), pantallas y widgets
```

## Capturas
Están en la carpeta [`screenshots/`](screenshots/).
