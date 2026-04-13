# Configuracion Firebase para Google Sign-In (Android y Web)

Este documento contiene los pasos pendientes en Firebase Console para que el login/registro con Google funcione correctamente en Android y Web.

## Estado actual ya aplicado en el proyecto

- Android `applicationId` y `namespace` alineados a `com.company.nexgenparents`.
- Plugin `com.google.gms.google-services` activado en Gradle Android.
- `firebase_options.dart` configurado para Web y Android con valores reales.
- `AppConfig.googleSignInWebClientId` guarda el OAuth client id web usado por `google_sign_in`.
- `web/index.html` limpiado para evitar inicializaciones manuales duplicadas de Firebase.

## 1) Activar proveedor Google en Firebase Auth

1. Abre Firebase Console.
2. Entra al proyecto `nexgen-parents`.
3. Ve a Authentication > Sign-in method.
4. Activa `Google`.
5. Define un correo de soporte del proyecto.
6. Guarda los cambios.

## 2) Revisar app Android correcta en Firebase

1. Ve a Project settings > General > Your apps.
2. Verifica que exista una app Android con package name `com.company.nexgenparents`.
3. Si NO existe:
   - Crea una nueva app Android con ese package.
   - Descarga el nuevo `google-services.json`.
   - Sustituye el archivo local en `android/app/google-services.json`.

## 3) Configurar huellas SHA para Android

Google Sign-In en Android requiere SHA-1 (y recomendable SHA-256).

1. En Firebase, entra en la app Android `com.company.nexgenparents`.
2. En `SHA certificate fingerprints`, añade:
   - SHA-1 de debug
   - SHA-256 de debug
   - SHA-1 de release (cuando exista)
   - SHA-256 de release (cuando exista)
3. Guarda y espera propagacion (puede tardar unos minutos).
4. Descarga de nuevo `google-services.json` y reemplaza el local tras cualquier cambio de SHA.

### Comando rapido para obtener SHA de debug (Linux)

Desde la carpeta `android/` del proyecto:

1. Usa Java 17 o 21 (Java 25 puede fallar con este Gradle/AGP).
2. Define `JAVA_HOME` apuntando a ese JDK.

```bash
export JAVA_HOME=/ruta/a/jdk-17-o-21
export PATH="$JAVA_HOME/bin:$PATH"
./gradlew signingReport
```

Busca la variante `debug` y copia `SHA1` y `SHA-256`.

Alternativa rapida (sin Gradle), usando el keystore debug local:

```bash
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android | sed -n '/SHA1:/p;/SHA256:/p'
```

Este comando devuelve directamente las huellas `SHA1` y `SHA256` para pegarlas en Firebase.

Si no tienes JDK 17/21 instalado, en Ubuntu/Debian:

```bash
sudo apt update
sudo apt install -y openjdk-17-jdk
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH="$JAVA_HOME/bin:$PATH"
./gradlew signingReport
```

### Dejar JAVA_HOME permanente en tu usuario

Si quieres evitar exportarlo cada vez, anade estas dos lineas en `~/.bashrc`:

```bash
# Solo agrega la linea si no existe ya
grep -qxF 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64' ~/.bashrc || echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64' >> ~/.bashrc
grep -qxF 'export PATH="$JAVA_HOME/bin:$PATH"' ~/.bashrc || echo 'export PATH="$JAVA_HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

Despues, verifica que quedo bien:

```bash
echo $JAVA_HOME
java -version
```

### Si el error sigue saliendo en NetBeans

Este proyecto ya fija Gradle a Java 17 en `android/gradle.properties`, pero NetBeans puede seguir importando el proyecto con Java 25 si su plataforma Java para Gradle sigue apuntando a ese JDK. Si el stack trace muestra `org.netbeans.modules.gradle...`, el ajuste correcto es en el IDE, no en el wrapper.

1. Abre las plataformas Java de NetBeans y asegúrate de tener JDK 17 o 21 registrado.
2. En las propiedades del proyecto Android, cambia la plataforma de Gradle a ese JDK.
3. Cierra y vuelve a abrir el proyecto, o fuerza una nueva sincronizacion/importacion.
4. Vuelve a comprobar con `./gradlew -version` desde `android/` que el launcher JVM sea 17.

## 4) Revisar OAuth y APIs en Google Cloud (si hiciera falta)

Normalmente Firebase lo crea automaticamente al activar Google Auth.

1. En Google Cloud Console del mismo proyecto, verifica pantalla de consentimiento OAuth.
2. Verifica que no haya restricciones que bloqueen el acceso de usuarios de prueba.
3. Si usas cuenta corporativa (Workspace), revisa politicas de dominio.

## 5) Configuracion Web en Firebase Auth

1. En Authentication > Settings > Authorized domains.
2. Asegura que esten permitidos:
   - `localhost`
   - Tu dominio de despliegue (si aplica)
3. Si pruebas en entorno remoto temporal, agrega ese host tambien.

## 6) Configuracion Google Sign-In en Web

1. El client id web del proyecto ya esta en Firebase Console y corresponde al OAuth client de tipo 3.
2. La app lo usa desde `AppConfig.googleSignInWebClientId` al inicializar `GoogleSignIn`.
3. Si cambias o regeneras la app web en Google Cloud/Firebase, actualiza ese valor y vuelve a compilar.

## 7) Verificacion funcional recomendada

1. Ejecuta en Android:

```bash
flutter run -d android
```

2. Prueba `Continuar con Google` en login y registro.
3. Verifica en Firestore que se cree/actualice `users/{uid}`.
4. Ejecuta en Web:

```bash
flutter run -d chrome
```

5. Prueba popup de Google y confirma que redirige a la app autenticada.

## 8) Problemas comunes y solucion

- Error `12500` en Android:
  - Falta SHA o no coincide package/SHA con el `google-services.json`.
- Error `account-exists-with-different-credential`:
  - El correo ya existe con password; usar el metodo original y luego vincular si se desea.
- Popup bloqueado en Web:
  - Permitir popups del navegador para el dominio.
- No aparece usuario en Firestore:
  - Revisar reglas de Firestore y logs de `AuthService._ensureUserDocument`.
- Error `checksums.lock (Permiso denegado)` en Android:
  - Suele pasar por haber ejecutado Gradle con `sudo`.
  - Corregir permisos y volver a intentar:

```bash
sudo chown -R $USER:$USER /home/javier.gonzalez/Documentos/TFC/NexGenParents/nexgenparents/android/.gradle
```

- Error emulador `Cannot find AVD system path` / `define ANDROID_SDK_ROOT` / code 1:
  - Falta instalar `cmdline-tools` y/o `system-images` del AVD.
  - Comprobado en este entorno: no existe la carpeta `~/Android/Sdk/system-images`.
  - Solucion recomendada:

```bash
# 1) Instalar cmdline-tools y system image desde Android Studio:
#    Settings > Android SDK > SDK Tools:
#      - Android SDK Command-line Tools (latest)
#    Settings > Android SDK > SDK Platforms:
#      - instala una imagen (ejemplo Android 35, Google APIs x86_64)

# 2) Variables de entorno permanentes
grep -qxF 'export ANDROID_SDK_ROOT=$HOME/Android/Sdk' ~/.bashrc || echo 'export ANDROID_SDK_ROOT=$HOME/Android/Sdk' >> ~/.bashrc
grep -qxF 'export ANDROID_HOME=$ANDROID_SDK_ROOT' ~/.bashrc || echo 'export ANDROID_HOME=$ANDROID_SDK_ROOT' >> ~/.bashrc
grep -qxF 'export PATH=$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator:$PATH' ~/.bashrc || echo 'export PATH=$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator:$PATH' >> ~/.bashrc
source ~/.bashrc

# 3) (Linux) habilitar aceleracion KVM (si no estas en grupo kvm)
sudo usermod -aG kvm $USER
# cerrar sesion y volver a entrar

# 4) recrear AVD y probar
flutter emulators --create --name Pixel_API_35
flutter emulators --launch Pixel_API_35
flutter run -d android
```

## Nota

La configuracion de iOS/macOS se deja fuera a proposito en esta fase.
