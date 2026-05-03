# Setup Multiplataforma (Android, Linux, macOS, Windows)

Este proyecto ya incluye carpetas para Android, Linux, macOS y Windows, por lo que puede compilarse para esos targets.

## Resumen rapido

- Si solo quieres abrir el codigo: VS Code + extensiones Flutter/Dart.
- Si quieres ejecutar o compilar en nativo: necesitas toolchain del sistema operativo destino.
- Si no quieres instalar toolchains locales: usa artefactos precompilados (CI/Releases) o desarrollo remoto.

## Requisitos por plataforma

### Android

- Flutter SDK
- JDK 17
- Android SDK (platform-tools, build-tools, platform API)

Comandos:

```bash
flutter config --enable-android
flutter doctor -v
flutter run -d android
```

### Linux desktop

- Flutter SDK
- `clang`, `cmake`, `ninja-build`, `pkg-config`, `libgtk-3-dev`

Comandos:

```bash
flutter config --enable-linux-desktop
flutter doctor -v
flutter run -d linux
```

### Windows desktop

- Flutter SDK
- Visual Studio 2022 con workload "Desktop development with C++"

Comandos (PowerShell):

```powershell
flutter config --enable-windows-desktop
flutter doctor -v
flutter run -d windows
```

### macOS desktop

- Flutter SDK
- Xcode + Command Line Tools

Comandos:

```bash
flutter config --enable-macos-desktop
flutter doctor -v
flutter run -d macos
```

## Se puede clonar y ejecutar sin instalar nada extra?

Para compilacion nativa, no. Flutter usa compilacion nativa por plataforma, asi que el toolchain es obligatorio.

Opciones para evitar instalaciones locales pesadas:

1. Descargar builds ya generadas (APK/EXE/app) desde Releases de GitHub.
2. Usar CI/CD para generar artefactos en cada commit/tag.
3. Usar desarrollo remoto (Codespaces, VM, servidor) con toolchains preinstalados.
4. Usar `flutter run -d web-server` para validar logica/UI sin toolchains nativos.

## Flujo recomendado en equipo nuevo

1. Instalar Flutter SDK.
2. Ejecutar `flutter doctor -v`.
3. Corregir solo el target que necesites (por ejemplo Android o Linux).
4. En el proyecto:

```bash
flutter clean
flutter pub get
flutter run -d <device>
```

## Nota sobre configuraciones locales

Las rutas locales de Java/SDK no deben versionarse en el repositorio.
Cada desarrollador configura su entorno localmente para evitar errores al clonar en otro equipo.
