import '../models/parental_guide_model.dart';
import '../config/app_config.dart';

class ParentalGuidesService {
  // Obtener todas las guías disponibles
  List<ParentalGuide> getAllGuides() {
    return [
      _getPlayStationEnableGuide(),
      _getPlayStationDisableGuide(), // NUEVA
      _getXboxGuide(),
      _getNintendoGuide(),
      _getSteamGuide(),
    ];
  }

  // Obtener guías por plataforma (ahora devuelve múltiples guías)
  List<ParentalGuide> getGuidesByPlatform(String platform) {
    final guides = getAllGuides();
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
      iconUrl: '${AppConfig.githubCdnBase}/icons/playstation.png',
      steps: [
        ParentalGuideStep(
          stepNumber: 1,
          instruction: 'Desde la pantalla principal, ve a "Configuración" (icono de caja de herramientas en la parte superior derecha).',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/playstation/enable/ps-paso1.webp',
        ),
        ParentalGuideStep(
          stepNumber: 2,
          instruction: 'Selecciona "Familia y control parental" → "Control parental/Gestión de familia".',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/playstation/enable/ps-paso2.webp',
        ),
        ParentalGuideStep(
          stepNumber: 3,
          instruction: 'Elige el perfil del niño que deseas configurar.',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/playstation/enable/ps-paso3.webp',
        ),
        ParentalGuideStep(
          stepNumber: 4,
          instruction: 'Configura las restricciones de edad para juegos, películas y navegador web según la edad de tu hijo.',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/playstation/enable/ps-paso4.webp',
        ),
        ParentalGuideStep(
          stepNumber: 5,
          instruction: 'Establece límites de gasto mensual y horarios de juego permitidos.',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/playstation/enable/ps-paso5.webp',
        ),
        ParentalGuideStep(
          stepNumber: 6,
          instruction: 'Guarda los cambios y el control parental quedará activado.',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/playstation/enable/ps-paso6.webp',
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
      iconUrl: '${AppConfig.githubCdnBase}/icons/playstation.png',
      steps: [
        ParentalGuideStep(
          stepNumber: 1,
          instruction: 'Ve a "Configuración" desde la pantalla principal.',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/playstation/disable/ps2-paso1.webp',
        ),
        ParentalGuideStep(
          stepNumber: 2,
          instruction: 'Accede a "Familia y control parental".',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/playstation/disable/ps2-paso2.webp',
        ),
        ParentalGuideStep(
          stepNumber: 3,
          instruction: 'Introduce el código PIN de control parental.',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/playstation/disable/ps2-paso3.webp',
        ),
        ParentalGuideStep(
          stepNumber: 4,
          instruction: 'Selecciona "Desactivar restricciones" o modifica las configuraciones.',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/playstation/disable/ps2-paso4.webp',
        ),
        ParentalGuideStep(
          stepNumber: 5,
          instruction: 'Confirma la desactivación y guarda los cambios.',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/playstation/disable/ps2-paso5.webp',
        ),
      ],
    );
  }


  // Guía de Xbox
  ParentalGuide _getXboxGuide() {
    return ParentalGuide(
      id: 'xbox-guide',
      platform: 'xbox',
      title: 'Control Parental en Xbox',
      description: 'Configura filtros de contenido, límites de tiempo y privacidad en Xbox Series X/S y Xbox One.',
      iconUrl: '${AppConfig.githubCdnBase}/icons/xbox.png',
      steps: [
        ParentalGuideStep(
          stepNumber: 1,
          instruction: 'Presiona el botón Xbox en el control y ve a "Perfil y sistema" → "Configuración".',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/xbox/xbox-paso1.webp',
        ),
        ParentalGuideStep(
          stepNumber: 2,
          instruction: 'Selecciona "Cuenta" → "Familia".',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/xbox/xbox-paso2.webp',
        ),
        ParentalGuideStep(
          stepNumber: 3,
          instruction: 'Elige la cuenta del niño y selecciona "Configuración de privacidad y seguridad en línea".',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/xbox/xbox-paso3.webp',
        ),
        ParentalGuideStep(
          stepNumber: 4,
          instruction: 'Configura restricciones de contenido, comunicación con otros jugadores y compras.',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/xbox/xbox-paso4.webp',
        ),
        ParentalGuideStep(
          stepNumber: 5,
          instruction: 'Activa "Límites de tiempo de pantalla" para controlar cuántas horas puede jugar por día.',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/xbox/xbox-paso5.webp',
        ),
      ],
    );
  }

  // Guía de Nintendo Switch
  ParentalGuide _getNintendoGuide() {
    return ParentalGuide(
      id: 'nintendo-guide',
      platform: 'nintendo',
      title: 'Control Parental en Nintendo Switch',
      description: 'Utiliza la app Nintendo Switch Parental Controls para gestionar el tiempo de juego y contenido apropiado.',
      iconUrl: '${AppConfig.githubCdnBase}/icons/nintendo.png',
      steps: [
        ParentalGuideStep(
          stepNumber: 1,
          instruction: 'Descarga la app "Nintendo Switch Parental Controls" en tu smartphone (Android/iOS).',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/nintendo/ns-paso1.webp',
        ),
        ParentalGuideStep(
          stepNumber: 2,
          instruction: 'En la consola Nintendo Switch, ve a "Configuración de la consola" → "Control parental".',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/nintendo/ns-paso2.webp',
        ),
        ParentalGuideStep(
          stepNumber: 3,
          instruction: 'Escanea el código QR que aparece en la pantalla con la app del smartphone.',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/nintendo/ns-paso3.webp',
        ),
        ParentalGuideStep(
          stepNumber: 4,
          instruction: 'Configura las restricciones de edad para los juegos y establece límites de tiempo diarios.',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/nintendo/ns-paso4.webp',
        ),
        ParentalGuideStep(
          stepNumber: 5,
          instruction: 'La app te enviará notificaciones cuando se alcance el límite de tiempo y podrás ver estadísticas de juego.',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/nintendo/ns-paso5.webp',
        ),
      ],
    );
  }

  // Guía de Steam (PC)
  ParentalGuide _getSteamGuide() {
    return ParentalGuide(
      id: 'steam-guide',
      platform: 'steam',
      title: 'Control Parental en Steam',
      description: 'Configura el Modo Familiar de Steam para controlar qué juegos pueden acceder tus hijos.',
      iconUrl: '${AppConfig.githubCdnBase}/icons/steam.png',
      steps: [
        ParentalGuideStep(
          stepNumber: 1,
          instruction: 'Abre Steam en el PC y haz clic en "Steam" (arriba izquierda) → "Configuración".',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/steam/steam-paso1.webp',
        ),
        ParentalGuideStep(
          stepNumber: 2,
          instruction: 'Selecciona "Familia" en el menú lateral.',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/steam/steam-paso2.webp',
        ),
        ParentalGuideStep(
          stepNumber: 3,
          instruction: 'Activa "Vista Familiar" y establece un PIN de seguridad.',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/steam/steam-paso3.webp',
        ),
        ParentalGuideStep(
          stepNumber: 4,
          instruction: 'Selecciona manualmente qué juegos de tu biblioteca serán visibles en el modo familiar.',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/steam/steam-paso4.webp',
        ),
        ParentalGuideStep(
          stepNumber: 5,
          instruction: 'Los niños solo podrán acceder a los juegos aprobados. Para salir del modo, necesitarán el PIN.',
          imageUrl: '${AppConfig.githubCdnBase}/control-parental/steam/steam-paso5.webp',
        ),
      ],
    );
  }
}