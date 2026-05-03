# NexGen Parents
<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=white" alt="Firebase">
  <img src="https://img.shields.io/badge/Version-1.0.0-green?style=for-the-badge" alt="Version">
</p>

**NexGen Parents** es una aplicación multiplataforma desarrollada como Trabajo de Fin de Ciclo (TFC). Su objetivo principal es capacitar a madres, padres y tutores para tomar decisiones informadas sobre el consumo de videojuegos, cerrando la brecha digital intergeneracional mediante información estructurada, guías y una comunidad activa.

## ¿Por qué NexGen Parents?

El consumo de videojuegos crece cada año, pero muchas familias se sienten perdidas ante términos técnicos, clasificaciones de edad y controles parentales dispersos en múltiples plataformas. Esta aplicación nace para cerrar esa brecha informativa.

## ✨ Características Principales

- **Diccionario Colaborativo**: Términos técnicos explicados de forma sencilla con un sistema jerárquico de moderación (Roles: Usuario, Moderador, Admin).
- **Comunidad y Foro en Tiempo Real**: Espacio de debate seguro, reactivo y gestionado mediante Cloud Firestore.
- **Guías de Control Parental**: Arquitectura híbrida (datos locales + remotos) con instrucciones paso a paso para PlayStation, Xbox, Nintendo, iOS y Steam.
- **Explorador de Videojuegos**: Integración integral con la API REST de RAWG, ofreciendo búsquedas avanzadas y filtrado algorítmico por sistema PEGI/ESRB, género y plataforma.
- **Internacionalización (i18n)**: Soporte nativo multilingüe completo (Español, Inglés, Gallego).

## 🚀 Hitos Técnicos y Arquitectura

El proyecto ha sido diseñado siguiendo estándares de calidad de la industria y principios SOLID:

- **Rendimiento de UI (60fps)**: Prevención del antipatrón `shrinkWrap: true` mediante el uso de `Slivers` (`CustomScrollView`), `LayoutBuilder` y cálculos espaciales (`Wrap`) para garantizar un renderizado y *Lazy Loading* óptimo. Reducción drástica de reconstrucciones del árbol de widgets mediante el uso granular de `Consumer`.
- **UX Premium**: Implementación de filtros de desenfoque (*Glassmorphism*), transiciones inmersivas de continuidad espacial (*Hero Animations*), y estados de carga estructurales (*Skeleton/Shimmer Loading*) para evitar bloqueos perceptivos y spinners estáticos.
- **Eficiencia de Red**: Implementación de temporizadores (*Debouncing*) en las entradas de búsqueda para proteger los Rate Limits de la API de RAWG, así como *Rolling Windows* (ventanas deslizantes de 7 y 30 días) para consultas cronológicas exactas.
- **Escalabilidad de Base de Datos**: Uso de *Chunking* (segmentación) en transacciones masivas de Firestore para sobrepasar los límites técnicos de escrituras en lote (máx. 500 operaciones) durante el borrado en cascada de hilos virales.
- **Testing Robusto**: Batería de pruebas unitarias y de widgets aislando las capas de datos mediante inyección de dependencias y *mocking* de servicios de red (`mocktail`) y almacenamiento local (`SharedPreferences`).

## 🛠️ Stack Tecnológico

- **Frontend**: Flutter 3.x, Dart 3.x
- **State Management**: Provider Pattern
- **Backend (BaaS)**: Firebase (Authentication, Cloud Firestore)
- **API Externa**: RAWG Video Games Database API
- **Networking**: Paquete nativo `http`
- **Almacenamiento local**: `shared_preferences` (caché y persistencia de sesión)
- **Librerías UI**: `shimmer`, `cached_network_image`, `intl`
- **Testing**: `flutter_test`, `mocktail`

## ⚙️ Instalación y Configuración

### 1. Requisitos Previos
- SDK de Flutter 3.10.0 o superior.
- Cuenta de Firebase configurada (necesario configurar `firebase_options.dart`).

### 2. Clonar el repositorio e instalar

```bash
git clone <url-del-repositorio>
cd nexgenparents
flutter pub get
```

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

- Guia de setup por plataforma: [Setup Multiplataforma](nexgenparents/docs/SETUP_MULTIPLATFORM.md)
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
