import '../models/parental_guide_model.dart';
import '../config/app_config.dart';
import 'firestore_service.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ParentalGuidesService {
  final FirestoreService _firestoreService;
  static const String _assetsVersion = '20260311';

  ParentalGuidesService({FirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? FirestoreService();

  String _asset(String path) {
    return '${AppConfig.githubRawBase}/$path?v=$_assetsVersion';
  }

  // Obtener todas las guías disponibles (base + extra de Firestore)
  Future<List<ParentalGuide>> getAllGuides() async {
    // Guías base (siempre disponibles, rápidas)
    final List<ParentalGuide> baseGuides = [
      _getPlayStationEnableGuide(),
      _getPlayStationDisableGuide(),
      _getXboxGuide(),
      _getXboxTimeGuide(),
      _getNintendoGuide(),
      _getNintendoAppGuide(),
      _getSteamGuide(),
      _getIosGuide(),
    ];

    // Guías opcionales desde Firestore (solo si el usuario está autenticado)
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final extraGuides = await _firestoreService.getExtraGuides();
        baseGuides.addAll(extraGuides);
      }
    } catch (e) {
      // Si falla la BD, solo devuelve las base (resiliente)
      // Evitamos ruido de consola para errores de permisos esperables.
      final errorText = e.toString();
      if (!errorText.contains('permission-denied')) {
        debugPrint('No se pudieron cargar guías extras desde Firestore: $e');
      }
    }

    return baseGuides;
  }

  // Obtener guías por plataforma (ahora devuelve múltiples guías)
  // NOTA: Método sincrónico pero que llama a getAllGuides async
  // Para usar, actualizar en la pantalla con FutureBuilder
  Future<List<ParentalGuide>> getGuidesByPlatform(String platform) async {
    final guides = await getAllGuides();
    return guides.where((guide) => guide.platform == platform).toList();
  }

  // Guía de PlayStation - ACTIVAR (actualizada con tu ruta)
  ParentalGuide _getPlayStationEnableGuide() {
    return ParentalGuide(
      id: 'ps-enable-guide',
      platform: 'playstation',
      type: 'enable',
      title: 'Activar Control Parental en PlayStation',
      description: 'Aprende a activar y configurar restricciones de edad, límites de gasto y horarios de juego en PlayStation 4 y PlayStation 5.',
      iconUrl: _asset('icons/PlayStation.png'),
      steps: [
        ParentalGuideStep(
          stepNumber: 1,
          instruction: 'Desde la pantalla principal, ve a "Configuración" (icono de caja de herramientas en la parte superior derecha).',
          imageUrl: _asset('control-parental/playstation/enable/ps-paso1.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 2,
          instruction: 'Selecciona "Familia y control parental" → "Control parental/Gestión de familia".',
          imageUrl: _asset('control-parental/playstation/enable/ps-paso2.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 3,
          instruction: 'Elige el perfil del niño que deseas configurar.',
          imageUrl: _asset('control-parental/playstation/enable/ps-paso3.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 4,
          instruction: 'Configura las restricciones de edad para juegos, películas y navegador web según la edad de tu hijo.',
          imageUrl: _asset('control-parental/playstation/enable/ps-paso4.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 5,
          instruction: 'Establece límites de gasto mensual y horarios de juego permitidos.',
          imageUrl: _asset('control-parental/playstation/enable/ps-paso5.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 6,
          instruction: 'Guarda los cambios y el control parental quedará activado.',
          imageUrl: _asset('control-parental/playstation/enable/ps-paso6.webp'),
        ),
      ],
    );
  }

  // Guía de PlayStation - DESACTIVAR (NUEVA)
  ParentalGuide _getPlayStationDisableGuide() {
    return ParentalGuide(
      id: 'ps-disable-guide',
      platform: 'playstation',
      type: 'disable',
      title: 'Desactivar Control Parental en PlayStation',
      description: 'Aprende a desactivar o modificar las restricciones de control parental en PlayStation 4 y PlayStation 5.',
      iconUrl: _asset('icons/PlayStation.png'),
      steps: [
        ParentalGuideStep(
          stepNumber: 1,
          instruction: 'Ve a "Configuración" desde la pantalla principal.',
          imageUrl: _asset('control-parental/playstation/disable/ps2-paso1.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 2,
          instruction: 'Accede a "Familia y control parental".',
          imageUrl: _asset('control-parental/playstation/disable/ps2-paso2.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 3,
          instruction: 'Introduce el código PIN de control parental.',
          imageUrl: _asset('control-parental/playstation/disable/ps2-paso3.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 4,
          instruction: 'Selecciona "Desactivar restricciones" o modifica las configuraciones.',
          imageUrl: _asset('control-parental/playstation/disable/ps2-paso4.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 5,
          instruction: 'Confirma la desactivación y guarda los cambios.',
          imageUrl: _asset('control-parental/playstation/disable/ps2-paso5.webp'),
        ),
      ],
    );
  }


  // Guía de Xbox - Control parental general
  ParentalGuide _getXboxGuide() {
    return ParentalGuide(
      id: 'xbox-guide',
      platform: 'xbox',
      type: 'enable',
      title: 'Control Parental en Xbox',
      description: 'Configura filtros de contenido, restricciones de compra y privacidad en Xbox Series X/S y Xbox One mediante la cuenta familiar de Microsoft.',
      iconUrl: _asset('icons/xbox.png'),
      steps: [
        ParentalGuideStep(
          stepNumber: 1,
          instruction: 'Presiona el botón Xbox en el control y ve a "Perfil y sistema" → "Configuración".',
          imageUrl: _asset('control-parental/xbox/xbox-paso1.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 2,
          instruction: 'Selecciona "Cuenta" → "Familia".',
          imageUrl: _asset('control-parental/xbox/xbox-paso2.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 3,
          instruction: 'Elige la cuenta del niño y selecciona "Configuración de privacidad y seguridad en línea".',
          imageUrl: _asset('control-parental/xbox/xbox-paso3.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 4,
          instruction: 'Configura restricciones de contenido, comunicación con otros jugadores y compras.',
          imageUrl: _asset('control-parental/xbox/xbox-paso4.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 5,
          instruction: 'Confirma los cambios. La configuración se aplica automáticamente al perfil del niño.',
          imageUrl: _asset('control-parental/xbox/xbox-paso5.webp'),
        ),
      ],
    );
  }

  // Guía de Xbox - Tiempo de uso
  ParentalGuide _getXboxTimeGuide() {
    return ParentalGuide(
      id: 'xbox-time-guide',
      platform: 'xbox',
      type: 'time',
      title: 'Límites de Tiempo de Uso en Xbox',
      description: 'Establece horarios y límites de tiempo de juego diario en Xbox para cada miembro de la familia desde la app Microsoft Family Safety.',
      iconUrl: _asset('icons/xbox.png'),
      steps: [
        ParentalGuideStep(
          stepNumber: 1,
          instruction: 'Descarga e instala la app "Microsoft Family Safety" en tu smartphone. Inicia sesión con tu cuenta Microsoft.',
          imageUrl: _asset('control-parental/xbox/time/xbox-Time-paso1.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 2,
          instruction: 'Selecciona el perfil del niño en la app y accede a "Tiempo de pantalla".',
          imageUrl: _asset('control-parental/xbox/time/xbox-Time-paso2.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 3,
          instruction: 'Activa los límites de tiempo y configura cuántas horas puede usar Xbox cada día de la semana.',
          imageUrl: _asset('control-parental/xbox/time/xbox-Time-paso3.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 4,
          instruction: 'Establece las franjas horarias en las que la consola está disponible (por ejemplo, solo de 17:00 a 20:00).',
          imageUrl: _asset('control-parental/xbox/time/xbox-Time-paso4.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 5,
          instruction: 'Guarda la configuración. El niño recibirá avisos antes de que se acabe su tiempo y necesitará tu aprobación para pedir más tiempo.',
          imageUrl: _asset('control-parental/xbox/time/xbox-Time-paso5.webp'),
        ),
      ],
    );
  }

  // Guía de Nintendo Switch - Configuración inicial en consola
  ParentalGuide _getNintendoGuide() {
    return ParentalGuide(
      id: 'nintendo-guide',
      platform: 'nintendo',
      type: 'enable',
      title: 'Control Parental en Nintendo Switch',
      description: 'Configura el control parental directamente en la consola Nintendo Switch para restringir contenido y establecer límites de edad.',
      iconUrl: _asset('icons/nintendo.png'),
      steps: [
        ParentalGuideStep(
          stepNumber: 1,
          instruction: 'Accede a "Configuración de la consola" desde el menú principal de Nintendo Switch.',
          imageUrl: _asset('control-parental/nintendo/ns-paso1.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 2,
          instruction: 'Desplázate hacia abajo y selecciona "Control parental".',
          imageUrl: _asset('control-parental/nintendo/ns-paso2.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 3,
          instruction: 'Elige "Usar smartphone" para vincular la app, o "Configurar ahora" si prefieres hacerlo desde la consola.',
          imageUrl: _asset('control-parental/nintendo/ns-paso3.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 4,
          instruction: 'Selecciona el nivel de restricción de contenido según la edad del niño.',
          imageUrl: _asset('control-parental/nintendo/ns-paso4.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 5,
          instruction: 'Establece un PIN de 4 dígitos para proteger la configuración. Guarda y confirma.',
          imageUrl: _asset('control-parental/nintendo/ns-paso5.webp'),
        ),
      ],
    );
  }

  // Guía de Nintendo Switch - Configurar la App de control parental
  ParentalGuide _getNintendoAppGuide() {
    return ParentalGuide(
      id: 'nintendo-app-guide',
      platform: 'nintendo',
      type: 'app',
      title: 'Configurar la App de Control Parental (Nintendo)',
      description: 'Aprende a vincular y configurar la app "Nintendo Switch Parental Controls" en tu smartphone para gestionar remotamente los límites de juego.',
      iconUrl: _asset('icons/nintendo.png'),
      steps: [
        ParentalGuideStep(
          stepNumber: 1,
          instruction: 'Descarga la app "Nintendo Switch Parental Controls" en tu smartphone (disponible en Android e iOS).',
          imageUrl: _asset('control-parental/nintendo/app/ns-App-paso1.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 2,
          instruction: 'Abre la app y acepta los términos de uso. Inicia sesión con tu cuenta Nintendo o crea una nueva.',
          imageUrl: _asset('control-parental/nintendo/app/ns-App-paso2.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 3,
          instruction: 'En la consola, ve a "Configuración" → "Control parental" → "Usar smartphone" y escanea el código QR con la app.',
          imageUrl: _asset('control-parental/nintendo/app/ns-App-paso3.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 4,
          instruction: 'Asigna un nombre al niño y selecciona su grupo de edad para aplicar restricciones automáticas.',
          imageUrl: _asset('control-parental/nintendo/app/ns-App-paso4.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 5,
          instruction: 'Configura el límite de tiempo de juego diario. Puedes establecer límites distintos para días de semana y fin de semana.',
          imageUrl: _asset('control-parental/nintendo/app/ns-App-paso5.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 6,
          instruction: 'Activa la restricción de juego después de la hora límite y personaliza el mensaje que verá el niño al alcanzarlo.',
          imageUrl: _asset('control-parental/nintendo/app/ns-App-paso6.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 7,
          instruction: 'Revisa el resumen mensual de actividad: juegos usados, tiempo total y tendencias por día.',
          imageUrl: _asset('control-parental/nintendo/app/ns-App-paso7.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 8,
          instruction: 'Desde la app puedes añadir tiempo extra puntualmente o suspender los límites temporalmente sin tocar la consola.',
          imageUrl: _asset('control-parental/nintendo/app/ns-App-paso8.webp'),
        ),
      ],
    );
  }

  // Guía de Steam (PC)
  ParentalGuide _getSteamGuide() {
    return ParentalGuide(
      id: 'steam-guide',
      platform: 'steam',
      type: 'enable',
      title: 'Control Parental en Steam',
      description: 'Configura el Modo Familiar de Steam para controlar qué juegos pueden acceder tus hijos.',
      iconUrl: _asset('icons/steam.png'),
      steps: [
        ParentalGuideStep(
          stepNumber: 1,
          instruction: 'Abre Steam en el PC y haz clic en "Steam" (arriba izquierda) → "Configuración".',
          imageUrl: _asset('control-parental/steam/steam-paso1.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 2,
          instruction: 'Selecciona "Familia" en el menú lateral.',
          imageUrl: _asset('control-parental/steam/steam-paso2.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 3,
          instruction: 'Activa "Vista Familiar" y establece un PIN de seguridad.',
          imageUrl: _asset('control-parental/steam/steam-paso3.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 4,
          instruction: 'Selecciona manualmente qué juegos de tu biblioteca serán visibles en el modo familiar.',
          imageUrl: _asset('control-parental/steam/steam-paso4.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 5,
          instruction: 'Los niños solo podrán acceder a los juegos aprobados. Para salir del modo, necesitarán el PIN.',
          imageUrl: _asset('control-parental/steam/steam-paso5.webp'),
        ),
      ],
    );
  }

  // Guía de iOS - Tiempo de pantalla y restricciones
  ParentalGuide _getIosGuide() {
    return ParentalGuide(
      id: 'ios-guide',
      platform: 'ios',
      type: 'enable',
      title: 'Activar Control Parental en iOS (iPhone/iPad)',
      description: 'Configura Tiempo de uso, contenido y privacidad en iPhone/iPad para proteger a menores.',
      iconUrl: _asset('icons/ios.png'),
      steps: [
        ParentalGuideStep(
          stepNumber: 1,
          instruction: 'Abre Ajustes en el iPhone/iPad y entra en "Tiempo de uso".',
          imageUrl: _asset('icons/ios.png'),
        ),
        ParentalGuideStep(
          stepNumber: 2,
          instruction: 'Pulsa "Activar Tiempo de uso" y selecciona "Este es el iPhone de mi hijo".',
          imageUrl: _asset('icons/ios.png'),
        ),
        ParentalGuideStep(
          stepNumber: 3,
          instruction: 'Define un código de Tiempo de uso distinto al desbloqueo del móvil.',
          imageUrl: _asset('icons/ios.png'),
        ),
        ParentalGuideStep(
          stepNumber: 4,
          instruction: 'Configura "Tiempo de inactividad", "Límites de apps" y "Restricciones de contenido y privacidad".',
          imageUrl: _asset('icons/ios.png'),
        ),
      ],
    );
  }
}