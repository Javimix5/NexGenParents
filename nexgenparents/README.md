# NexGen Parents
<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Version-1.0.0-green?style=for-the-badge" alt="Version">
</p>

Una aplicación móvil diseñada para ayudar a padres y madres a tomar decisiones informadas sobre videojuegos. Combina un diccionario colaborativo de términos gaming, guías paso a paso de controles parentales y recomendaciones de juegos según edad y plataforma.

## ¿Por qué NexGen Parents?

El consumo de videojuegos crece cada año, pero muchas familias se sienten perdidas ante términos técnicos, clasificaciones de edad y controles parentales dispersos en múltiples plataformas. Esta aplicación nace para cerrar esa brecha informativa.

## Características principales

- **Diccionario colaborativo**: Términos gaming explicados de forma clara y moderada
- **Guías de control parental**: Pasos detallados para configurar controles en PlayStation, Xbox, Nintendo, Steam y más
- **Filtrado de juegos**: Busca y filtra títulos según edad recomendada, plataforma y género
- **Autenticación segura**: Login con Firebase Authentication
- **Contenido actualizado**: Integración con RAWG API para información de videojuegos actual

## Requisitos previos

- Flutter 3.0.0 o superior
- SDK de Dart 3.0.0 o superior
- Xcode (para desarrollo en iOS)
- Android Studio o similar (para desarrollo en Android)
- Una cuenta de Firebase configurada

## Soporte multiplataforma

Este proyecto esta preparado para Android, Linux, macOS y Windows.

- Guia de setup por plataforma: [Setup Multiplataforma](docs/SETUP_MULTIPLATFORM.md)
- Validacion de entorno: `flutter doctor -v`

Nota importante:

- Para compilar/ejecutar en nativo, Flutter necesita toolchains del sistema destino.
- No es posible compilar para Android/Linux/macOS/Windows solo con el IDE sin instalar dependencias del target.
- Si quieres evitar instalaciones locales, usa artefactos precompilados (Releases/CI) o desarrollo remoto.

## Instalación y configuración

### 1. Clonar el repositorio

```bash
git clone https://github.com/tu-usuario/nexgenparents.git
cd nexgenparents
```

### 2. Instalar dependencias

```bash
flutter pub get
```

### 3. Configurar Firebase

Sigue la [documentación de configuración de Firebase Parental Guides](docs/FIREBASE_PARENTAL_GUIDES_SETUP.md) para:
- Crear un proyecto en Firebase Console
- Descargar archivos de configuración (`google-services.json` para Android, `GoogleService-Info.plist` para iOS)
- Configurar autenticación y Firestore
- Habilitar las APIs necesarias

### 4. Ejecutar la aplicación

**En desarrollo:**
```bash
flutter run
```

**En modo release:**
```bash
flutter run --release
```

## Stack tecnológico

- **Frontend**: Flutter
- **State Management**: Provider
- **Backend**: Firebase (Authentication, Firestore, Cloud Storage)
- **API Externa**: RAWG Video Games Database API
- **Almacenamiento local**: SharedPreferences y SQLite
- **Networking**: HTTP y Dio

## Estructura del proyecto

```
lib/
├── config/              # Configuración global (tema, constantes)
├── models/              # Modelos de datos
├── providers/           # Gestión de estado con Provider
├── screens/             # Pantallas de la aplicación
├── services/            # Servicios (API, Firebase, etc.)
├── utils/               # Utilidades y helpers
└── widgets/             # Componentes reutilizables

firebase_options.dart    # Configuración automática de Firebase
main.dart               # Punto de entrada de la app
```

## Uso

1. **Registrarse o iniciar sesión**: Crea una cuenta con correo electrónico
2. **Explorar el diccionario**: Busca definiciones de términos gaming
3. **Consultar guías**: Accede a pasos específicos para cada plataforma
4. **Buscar juegos**: Filtra títulos por edad, plataforma y género

## Documentación adicional

- [Resumen de arquitectura híbrida](docs/HYBRID_ARCHITECTURE_SUMMARY.md)
- [Guía de configuración Firebase](docs/FIREBASE_PARENTAL_GUIDES_SETUP.md)
- [Plan de negocio (EIE)](docs/EIE.md)
- [Abstract en inglés](docs/ABSTRACT_EN.md)

## Contributing

Las contribuciones son bienvenidas. Para cambios importantes:

1. Haz fork del repositorio
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request
   
## Contacto

Para preguntas o sugerencias sobre NexGen Parents, puedes abrir un issue en este repositorio.

---

