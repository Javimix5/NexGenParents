# Configuración de Colección Firestore para Guías de Control Parental

## Arquitectura Implementada: Opción 3 (Híbrida)

Las guías de control parental funcionan con:
- **Guías base** (en código): PlayStat ion, Xbox, Nintendo, Steam (5 guías)
- **Guías extra** (desde Firestore): Nuevas guías pueden agregarse sin recompilación

---

## Pasos para Crear la Colección en Firebase

### 1. **Acceso a Firebase Console**

1. Ve a https://console.firebase.google.com
2. Selecciona tu proyecto **NexGenParents**
3. En el menú lateral, haz clic en **Build** → **Firestore Database**

### 2. **Crear la Colección `parental_guides_extra`**

**Si Firestore no existe aún:**
- Haz clic en **Crear base de datos**
- Selecciona modo: **Iniciar en modo prueba** (después configurar Rules)
- Ubicación: **Europe (eu-west-1)** o la más cercana
- Haz clic en **Crear**

**Una vez en Firestore:**
- Haz clic en **Crear colección**
- Nombre de la colección: `parental_guides_extra`
- Haz clic en **Siguiente**

### 3. **Crear Documento de Prueba (Opcional)**

Para verificar que la estructura funciona, crea un documento de prueba:

**ID del documento:** `ios-enable-guide` (o deja que Firestore genere uno automáticamente, pero recomiendo usar IDs descriptivos)

**Campos a agregar:**

```json
{
  "id": "ios-enable-guide",
  "platform": "ios",
  "title": "Activar Control Parental en iOS",
  "description": "Configura Screen Time y Restricciones en iPhone y iPad.",
  "type": "enable",
  "iconUrl": "https://raw.githubusercontent.com/tu-usuario/NexGenParents/main/assets/icons/ios.png",
  "steps": [
    {
      "stepNumber": 1,
      "instruction": "Ve a Ajustes > Tiempo de pantalla",
      "imageUrl": "https://raw.githubusercontent.com/tu-usuario/NexGenParents/main/assets/control-parental/ios/paso1.webp"
    },
    {
      "stepNumber": 2,
      "instruction": "Toca 'Usar Tiempo de Pantalla' si es la primera vez",
      "imageUrl": "https://raw.githubusercontent.com/tu-usuario/NexGenParents/main/assets/control-parental/ios/paso2.webp"
    },
    {
      "stepNumber": 3,
      "instruction": "Configura el código de acceso de Tiempo de Pantalla",
      "imageUrl": "https://raw.githubusercontent.com/tu-usuario/NexGenParents/main/assets/control-parental/ios/paso3.webp"
    }
  ]
}
```

**Cómo ingresar en Firebase Console:**

1. En la colección `parental_guides_extra`, haz clic en **Agregar documento**
2. ID del documento: `ios-enable-guide` (deja vacío para generar automático)
3. Agrega campos:

| Campo | Tipo | Valor |
|-------|------|-------|
| `id` | String | `ios-enable-guide` |
| `platform` | String | `ios` |
| `title` | String | `Activar Control Parental en iOS` |
| `description` | String | `Configura Screen Time y Restricciones en iPhone y iPad.` |
| `type` | String | `enable` |
| `iconUrl` | String | `https://raw.githubusercontent.com/...` |
| `steps` | Array of Maps | [Ver instrucciones abajo] |

**Para agregar el array `steps`:**
1. Haz clic en **Agregar campo**
2. Nombre: `steps`
3. Tipo: **Array** (selecciona en el dropdown)
4. Haz clic en **Agregar elemento**
5. Tipo: **Map**
6. Agrega dentro del map:
   - `stepNumber` (Number): `1`
   - `instruction` (String): `Ve a Ajustes > Tiempo de pantalla`
   - `imageUrl` (String): `https://...`
7. Repite para cada paso (2, 3, etc.)

---

## Reglas de Seguridad de Firestore

### Para Desarrollo (Modo Prueba - SOLO PARA TESTING)

En **Firestore Database** → **Rules**, reemplaza con:

```javascript
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    
    // Permitir lectura pública de guías de control parental
    match /parental_guides_extra/{guide} {
      allow read: if true;
      allow write: if request.auth != null && request.auth.token.admin == true;
    }
    
    // Diccionario (lectura pública de aprobadas)
    match /dictionary_terms/{term} {
      allow read: if resource.data.status == 'approved';
      allow create: if request.auth != null;
      allow update, delete: if request.auth != null && request.auth.token.admin == true;
    }
    
    // Usuarios (propios datos)
    match /users/{userId} {
      allow read: if request.auth.uid == userId || request.auth.token.admin == true;
      allow write: if request.auth.uid == userId || request.auth.token.admin == true;
    }

    // Reglas para el Foro/Comunidad
    match /forum_posts/{postId} {
      allow read: if true;
      allow create: if request.auth != null;
      allow update, delete: if request.auth.uid == resource.data.authorId || request.auth.token.admin == true;
    }

    match /forum_replies/{replyId} {
      allow read: if true;
      allow create: if request.auth != null;
      allow update, delete: if request.auth.uid == resource.data.authorId || request.auth.token.admin == true;
    }

  }
}
```

**Publicar Rules:**
- Haz clic en **Publicar** en la esquina inferior derecha

### Para Producción

Reemplaza con reglas más restrictivas (después de tribunal):

```javascript
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    
    // Guías de control parental - solo lectura pública
    match /parental_guides_extra/{guide} {
      allow read: if true;
      allow write: if false;  // Solo a través de Admin SDK
    }
    
    // Diccionario - lectura de aprobadas, moderadores crean/editan
    match /dictionary_terms/{term} {
      allow read: if resource.data.status == 'approved';
      allow create: if request.auth != null;
      allow update: if request.auth != null && (
        request.auth.uid == resource.data.proposedBy ||
        request.auth.token.moderator == true
      );
    }
    
    // Usuarios
    match /users/{userId} {
      allow read: if request.auth.uid == userId;
      allow write: if request.auth.uid == userId;
      allow update: if request.auth.uid == userId && 
        request.resource.data.role == resource.data.role;  // Prevenir escalada de permisos
    }
  }
}
```

---

## Estructura de Datos Esperada

Cada documento en `parental_guides_extra` debe seguir este esquema:

```dart
ParentalGuide(
  id: "ios-enable-guide",
  platform: "ios",
  title: "Activar Control Parental en iOS",
  description: "Configura Screen Time y Restricciones...",
  steps: [
    ParentalGuideStep(
      stepNumber: 1,
      instruction: "Ve a Ajustes > Tiempo de pantalla",
      imageUrl: "https://..."
    ),
    // ... más pasos
  ],
  iconUrl: "https://...",
  type: "enable"  // "enable" o "disable"
)
```

---

## Cómo Funciona la Integración en la App

### Flujo de Datos

1. **Usuario abre pantalla "Control Parental"**
   ↓
2. `ParentalGuidesListScreen` llama a `ParentalGuidesService.getAllGuides()`
   ↓
3. El servicio devuelve un `Future<List<ParentalGuide>>`
   ↓
4. **FutureBuilder** muestra:
   - **Loading**: CircularProgressIndicator mientras se cargan
   - **Success**: Guías base + extra de Firestore
   - **Error**: Mensaje de error (pero la app sigue funcionando con guías base)

### Código Clave

```dart
// En ParentalGuidesService.getAllGuides()
Future<List<ParentalGuide>> getAllGuides() async {
  List<ParentalGuide> baseGuides = [
    _getPlayStationEnableGuide(),
    _getPlayStationDisableGuide(),
    _getXboxGuide(),
    _getNintendoGuide(),
    _getSteamGuide(),
  ];

  // Intentar cargar extras de Firestore
  try {
    final extraGuides = await _firestoreService.getExtraGuides();
    baseGuides.addAll(extraGuides);
  } catch (e) {
    print('No se pudieron cargar guías extras: $e');
    // La app continúa solo con guías base
  }

  return baseGuides;
}
```

---

## Prueba en Desarrollo

### Verificar que Funciona

1. **Agrega el documento de prueba iOS** en Firestore (ver sección 3)
2. **Ejecuta la app**: `flutter run`
3. **Abre pantalla "Control Parental"**
4. Verifica que veas:
   - 5 guías base (PlayStation, Xbox, Nintendo, Steam, + PlayStation Disable)
   - 1 guía extra (iOS) que cargó desde Firestore

### Si No Aparece la Guía iOS

**Checklist de debug:**
- ✅ ¿Firestore tiene la colección `parental_guides_extra`?
- ✅ ¿El documento iOS existe en la colección?
- ✅ ¿Todos los campos están presentes (id, platform, title, description, steps, iconUrl, type)?
- ✅ ¿El campo `steps` es un Array de Maps (no String)?
- ✅ ✅ ¿Las Rules de Firestore permiten `allow read: if true` para la colección?
- ✅ ¿La app está conectada a Firebase (firebase_options.dart configurado)?

**Ver logs:**
```bash
flutter run -v  # Modo verbose
# Busca mensajes "No se pudieron cargar guías extras:" o errores de Firestore
```

---

## Agregar Más Guías

Para agregar una nueva guía (p.ej., Android):

1. En Firebase Console, **Firestore Database**
2. Colección `parental_guides_extra`
3. Haz clic en **Agregar documento**
4. Copia la estructura del documento iOS, modifica:
   - `id`: `android-enable-guide`
   - `platform`: `android`
   - `title`: `Activar Control Parental en Android`
   - `description`: `Usa Google Family Link para controlar dispositivos...`
   - `steps`: Agrega los 5-6 pasos con imágenes

**Resultado:** La próxima vez que abra la app, verá automáticamente la guía Android + todas las demás.

---

## Mencionable en Defensa

**Para el tribunal:**
> "Las guías de control parental están divididas en dos niveles:
> 1. **Guías base** (hardcodeadas en código): PlayStation, Xbox, Nintendo, Steam → rápidas, sin latencia
> 2. **Guías extra** (desde Firestore): Permite agregar nuevas plataformas (iOS, Android, etc.) sin recompilación
> 
> Esto demuestra escalabilidad y aprovecha la BD de forma estratégica. Si la conexión a Firestore falla, la app sigue funcionando con guías base."

---

## Resumen Checklist

- ✅ Firestore Database creada
- ✅ Colección `parental_guides_extra` creada
- ✅ Documento de prueba (iOS) agregado
- ✅ Rules de seguridad configuradas
- ✅ App compilada sin errores
- ✅ App carga guías base + extra
- ✅ FutureBuilder muestra loading/error correctamente
