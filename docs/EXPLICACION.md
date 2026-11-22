# Explicación del proyecto (para la demo en vivo)

## 1. Arquitectura MVVM
- **View** (`presentation/screens`, `widgets`): solo dibuja y captura toques. No sabe de SQL.
- **ViewModel** (`presentation/viewmodels`): providers de Riverpod que exponen los datos (streams) y
  los comandos (tomar orden, usar repuesto…).
- **Model / Repository** (`data/repositories/taller_repository.dart`): reglas del taller y acceso a Drift.
- **Drift** (`data/database`): tablas SQLite, consultas tipadas y streams que se actualizan solos.

Flujo: pantalla → `ref.watch(provider)` → repositorio → `watch()` de Drift. Cuando cambia la BD,
la pantalla se redibuja sin recargar nada manualmente.

## 2. Base de datos (7 tablas)
| Tabla | Para qué |
|---|---|
| Clientes | Dueños (teléfono único). Un dueño puede tener varios equipos. |
| Equipos | Tipo, marca, modelo, número de serie único. Un equipo puede tener muchas órdenes. |
| Tecnicos | Los 3 técnicos. |
| Repuestos | Inventario: código, precio, existencias, stock mínimo. |
| Ordenes | Una visita = una orden. Tiene `estado` y `tecnicoId` (null = nadie la tomó). |
| Trabajos | Trabajos hechos con su costo de mano de obra. |
| UsosRepuesto | Repuestos usados por orden + cantidad + precio del momento. |

## 3. Cómo se resuelve cada problema del enunciado
| Problema | Solución |
|---|---|
| Dos técnicos reparan el mismo equipo | `tomarOrden` en una transacción: si ya tiene responsable, lanza error. Además no se puede abrir otra orden para un equipo con orden abierta. |
| No saber el estado de cada equipo | Pantalla Órdenes con filtros por estado y responsable visible. |
| Stock desordenado | `usarRepuesto` descuenta existencias dentro de la misma transacción; no deja usar más de lo que hay. |
| Enterarse a tiempo de lo que se agota | Banner en Órdenes, insignia en el menú, filtro "Por agotarse" y aviso al usar un repuesto. |
| Nadie recuerda reparaciones pasadas | Historial por cliente y por equipo mostrando trabajos y piezas. |
| Sin internet / persistencia | SQLite local con Drift: todo queda guardado al cerrar la app. |

## 4. Decisiones propias (el enunciado deja puntos abiertos)
- Sin login: al tomar una orden se elige qué técnico eres en un diálogo.
- Trabajos y repuestos solo se registran con la orden **En reparación**.
- "Liberar" devuelve la orden a *Recibida* sin responsable.
- Cancelar una orden devuelve sus repuestos al almacén.
- Se guarda el precio del repuesto al usarlo: si luego cambia, el historial no se altera.
- "Carga" de un técnico = órdenes En reparación + Listas que tiene asignadas.
- Un repuesto está "por agotarse" cuando existencias ≤ stock mínimo.
