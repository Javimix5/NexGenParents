# Configuración Firestore para Comunidad (6 secciones)

Esta guía está pensada para mantener arquitectura limpia y reutilizar lo que ya tienes.

## 1. Decisión recomendada (profesional)

No crear 6 tablas/colecciones separadas para posts.

Reutiliza:
- `forum_posts`
- `forum_replies`

Añadiendo campo obligatorio en posts:
- `sectionId` (string)

Valores permitidos:
- `welcome`
- `general`
- `news`
- `qna`
- `guides`
- `offtopic`

Ventajas:
- Menos reglas duplicadas
- Menos consultas repetidas
- Escalable para añadir secciones nuevas
- Fácil de mantener en MVVM

## 2. Estructura de datos objetivo

### `forum_posts/{postId}`

Campos mínimos:
- `title`: string
- `content`: string
- `authorId`: string
- `authorName`: string
- `sectionId`: string (uno de los 6 valores)
- `topic`: string (legacy/compatibilidad temporal)
- `replyCount`: number
- `createdAt`: timestamp
- `updatedAt`: timestamp
- `lastReplyAt`: timestamp opcional

### `forum_replies/{replyId}`

Campos mínimos:
- `postId`: string
- `authorId`: string
- `authorName`: string
- `content`: string
- `createdAt`: timestamp

No necesitas `sectionId` en replies porque se deriva de `postId`.

## 3. Colección opcional de catálogo

Puedes crear `forum_sections/{sectionId}` para gestionar metadatos y orden visual.

Ejemplo de documento (`forum_sections/general`):
- `nameEs`: "General"
- `nameGl`: "Xeral"
- `descriptionEs`: "Debates generales sobre crianza digital y videojuegos."
- `descriptionGl`: "Debates xerais sobre crianza dixital e videoxogos."
- `order`: 2
- `active`: true

Si no quieres complejidad extra, puedes mantener catálogo estático en app (ahora mismo ya está implementado así).

## 4. Índices recomendados

En Firestore Console > Indexes > Composite:

1. Colección: `forum_posts`
- Campos:
  - `sectionId` Ascending
  - `updatedAt` Descending

2. Colección: `forum_replies`
- Campos:
  - `postId` Ascending
  - `createdAt` Ascending

## 5. Migración de datos existentes

### Paso 1
Haz backup de `forum_posts` y `forum_replies` antes de migrar.

### Paso 2
Para cada documento existente en `forum_posts` sin `sectionId`:
- Si `topic == "General"` -> `sectionId = "general"`
- Si `topic == "Noticias"` -> `sectionId = "news"`
- Si `topic == "Preguntas y respuestas"` -> `sectionId = "qna"`
- Si falta `topic` o no coincide -> `sectionId = "general"`

### Paso 3
Verifica con consulta de control:
- documentos con `sectionId == null`
- documentos con `sectionId` fuera del catálogo

### Paso 4
Despliega reglas nuevas (ya preparadas en `firestore.rules`) que validan `sectionId`.

## 6. Cambios de aplicación ya preparados

Se han dejado implementados:
- Modelo de secciones centralizado: `lib/models/forum_section.dart`
- `ForumPost` con `sectionId` y compatibilidad legacy: `lib/models/forum_post_model.dart`
- Creación de post por `sectionId`: `lib/providers/forum_provider.dart`, `lib/screens/forum/create_post_screen.dart`
- Filtros visuales por 6 secciones en comunidad: `lib/screens/forum/forum_list_screen.dart`
- Home adaptada a `sectionId`: `lib/screens/home/home_screen.dart`
- Reglas Firestore para validar secciones: `firestore.rules`

## 7. Estrategia de transición recomendada

1. Migrar datos históricos (`sectionId`).
2. Publicar reglas nuevas.
3. Verificar creación de hilos en 6 secciones.
4. Verificar filtros y conteo de respuestas.
5. Eliminar `topic` en una fase futura (cuando no lo use ninguna pantalla/regla).

## 8. Nota MVVM

Mantén esta separación:
- Model: `forum_post_model.dart`, `forum_section.dart`
- ViewModel/Provider: `forum_provider.dart`
- View: `forum_list_screen.dart`, `create_post_screen.dart`
- Data source: `firestore_service.dart`

Así podrás evolucionar la comunidad sin acoplar UI y datos.
