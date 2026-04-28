import '../models/parental_guide_model.dart';
import '../config/app_config.dart';
import '../l10n/app_localizations.dart';
import 'firestore_service.dart';
import 'package:flutter/foundation.dart';

class ParentalGuidesService {
  final FirestoreService _firestoreService;
  static const String _assetsVersion = '20260311';

  ParentalGuidesService({FirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? FirestoreService();

  String _asset(String path) {
    return '${AppConfig.githubRawBase}/$path?v=$_assetsVersion';
  }

  // Obtener todas las guías disponibles (base + extra de Firestore)
  Future<List<ParentalGuide>> getAllGuides(AppLocalizations l10n) async {
    // Guías base (siempre disponibles, rápidas)
    final List<ParentalGuide> baseGuides = [
      _getPlayStationEnableGuide(l10n),
      _getPlayStationDisableGuide(l10n),
      _getXboxGuide(l10n),
      _getXboxTimeGuide(l10n),
      _getNintendoGuide(l10n),
      _getNintendoAppGuide(l10n),
      _getSteamGuide(l10n),
      _getIosGuide(l10n),
    ];

    // Guías opcionales desde Firestore (disponibles para todos los usuarios)
    try {
      final extraGuides = await _firestoreService.getExtraGuides();
      baseGuides.addAll(extraGuides);
    } catch (e) {
      // Si falla la BD, solo devuelve las base (resiliente)
      debugPrint('No se pudieron cargar guías extras desde Firestore: $e');
    }

    return baseGuides;
  }

  // Obtener guías por plataforma (ahora devuelve múltiples guías)
  // NOTA: Método sincrónico pero que llama a getAllGuides async
  // Para usar, actualizar en la pantalla con FutureBuilder
  Future<List<ParentalGuide>> getGuidesByPlatform(String platform, AppLocalizations l10n) async {
    final guides = await getAllGuides(l10n);
    return guides.where((guide) => guide.platform == platform).toList();
  }

  // Guía de PlayStation - ACTIVAR (actualizada con tu ruta)
  ParentalGuide _getPlayStationEnableGuide(AppLocalizations l10n) {
    return ParentalGuide(
      id: 'ps-enable-guide',
      platform: 'playstation',
      type: 'enable',
      title: l10n.psEnableGuideTitle,
      description: l10n.psEnableGuideDescription,
      iconUrl: _asset('icons/PlayStation.png'),
      steps: [
        ParentalGuideStep(
          stepNumber: 1,
          instruction: l10n.psEnableGuideStep1,
          imageUrl: _asset('control-parental/playstation/enable/ps-paso1.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 2,
          instruction: l10n.psEnableGuideStep2,
          imageUrl: _asset('control-parental/playstation/enable/ps-paso2.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 3,
          instruction: l10n.psEnableGuideStep3,
          imageUrl: _asset('control-parental/playstation/enable/ps-paso3.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 4,
          instruction: l10n.psEnableGuideStep4,
          imageUrl: _asset('control-parental/playstation/enable/ps-paso4.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 5,
          instruction: l10n.psEnableGuideStep5,
          imageUrl: _asset('control-parental/playstation/enable/ps-paso5.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 6,
          instruction: l10n.psEnableGuideStep6,
          imageUrl: _asset('control-parental/playstation/enable/ps-paso6.webp'),
        ),
      ],
    );
  }

  // Guía de PlayStation - DESACTIVAR (NUEVA)
  ParentalGuide _getPlayStationDisableGuide(AppLocalizations l10n) {
    return ParentalGuide(
      id: 'ps-disable-guide',
      platform: 'playstation',
      type: 'disable',
      title: l10n.psDisableGuideTitle,
      description: l10n.psDisableGuideDescription,
      iconUrl: _asset('icons/PlayStation.png'),
      steps: [
        ParentalGuideStep(
          stepNumber: 1,
          instruction: l10n.psDisableGuideStep1,
          imageUrl: _asset('control-parental/playstation/disable/ps2-paso1.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 2,
          instruction: l10n.psDisableGuideStep2,
          imageUrl: _asset('control-parental/playstation/disable/ps2-paso2.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 3,
          instruction: l10n.psDisableGuideStep3,
          imageUrl: _asset('control-parental/playstation/disable/ps2-paso3.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 4,
          instruction: l10n.psDisableGuideStep4,
          imageUrl: _asset('control-parental/playstation/disable/ps2-paso4.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 5,
          instruction: l10n.psDisableGuideStep5,
          imageUrl: _asset('control-parental/playstation/disable/ps2-paso5.webp'),
        ),
      ],
    );
  }


  // Guía de Xbox - Control parental general
  ParentalGuide _getXboxGuide(AppLocalizations l10n) {
    return ParentalGuide(
      id: 'xbox-guide',
      platform: 'xbox',
      type: 'enable',
      title: l10n.xboxGuideTitle,
      description: l10n.xboxGuideDescription,
      iconUrl: _asset('icons/xbox.png'),
      steps: [
        ParentalGuideStep(
          stepNumber: 1,
          instruction: l10n.xboxGuideStep1,
          imageUrl: _asset('control-parental/xbox/xbox-paso1.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 2,
          instruction: l10n.xboxGuideStep2,
          imageUrl: _asset('control-parental/xbox/xbox-paso2.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 3,
          instruction: l10n.xboxGuideStep3,
          imageUrl: _asset('control-parental/xbox/xbox-paso3.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 4,
          instruction: l10n.xboxGuideStep4,
          imageUrl: _asset('control-parental/xbox/xbox-paso4.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 5,
          instruction: l10n.xboxGuideStep5,
          imageUrl: _asset('control-parental/xbox/xbox-paso5.webp'),
        ),
      ],
    );
  }

  // Guía de Xbox - Tiempo de uso
  ParentalGuide _getXboxTimeGuide(AppLocalizations l10n) {
    return ParentalGuide(
      id: 'xbox-time-guide',
      platform: 'xbox',
      type: 'time',
      title: l10n.xboxTimeGuideTitle,
      description: l10n.xboxTimeGuideDescription,
      iconUrl: _asset('icons/xbox.png'),
      steps: [
        ParentalGuideStep(
          stepNumber: 1,
          instruction: l10n.xboxTimeGuideStep1,
          imageUrl: _asset('control-parental/xbox/time/xbox-Time-paso1.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 2,
          instruction: l10n.xboxTimeGuideStep2,
          imageUrl: _asset('control-parental/xbox/time/xbox-Time-paso2.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 3,
          instruction: l10n.xboxTimeGuideStep3,
          imageUrl: _asset('control-parental/xbox/time/xbox-Time-paso3.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 4,
          instruction: l10n.xboxTimeGuideStep4,
          imageUrl: _asset('control-parental/xbox/time/xbox-Time-paso4.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 5,
          instruction: l10n.xboxTimeGuideStep5,
          imageUrl: _asset('control-parental/xbox/time/xbox-Time-paso5.webp'),
        ),
      ],
    );
  }

  // Guía de Nintendo Switch - Configuración inicial en consola
  ParentalGuide _getNintendoGuide(AppLocalizations l10n) {
    return ParentalGuide(
      id: 'nintendo-guide',
      platform: 'nintendo',
      type: 'enable',
      title: l10n.nintendoGuideTitle,
      description: l10n.nintendoGuideDescription,
      iconUrl: _asset('icons/nintendo.png'),
      steps: [
        ParentalGuideStep(
          stepNumber: 1,
          instruction: l10n.nintendoGuideStep1,
          imageUrl: _asset('control-parental/nintendo/ns-paso1.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 2,
          instruction: l10n.nintendoGuideStep2,
          imageUrl: _asset('control-parental/nintendo/ns-paso2.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 3,
          instruction: l10n.nintendoGuideStep3,
          imageUrl: _asset('control-parental/nintendo/ns-paso3.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 4,
          instruction: l10n.nintendoGuideStep4,
          imageUrl: _asset('control-parental/nintendo/ns-paso4.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 5,
          instruction: l10n.nintendoGuideStep5,
          imageUrl: _asset('control-parental/nintendo/ns-paso5.webp'),
        ),
      ],
    );
  }

  // Guía de Nintendo Switch - Configurar la App de control parental
  ParentalGuide _getNintendoAppGuide(AppLocalizations l10n) {
    return ParentalGuide(
      id: 'nintendo-app-guide',
      platform: 'nintendo',
      type: 'app',
      title: l10n.nintendoAppGuideTitle,
      description: l10n.nintendoAppGuideDescription,
      iconUrl: _asset('icons/nintendo.png'),
      steps: [
        ParentalGuideStep(
          stepNumber: 1,
          instruction: l10n.nintendoAppGuideStep1,
          imageUrl: _asset('control-parental/nintendo/app/ns-App-paso1.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 2,
          instruction: l10n.nintendoAppGuideStep2,
          imageUrl: _asset('control-parental/nintendo/app/ns-App-paso2.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 3,
          instruction: l10n.nintendoAppGuideStep3,
          imageUrl: _asset('control-parental/nintendo/app/ns-App-paso3.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 4,
          instruction: l10n.nintendoAppGuideStep4,
          imageUrl: _asset('control-parental/nintendo/app/ns-App-paso4.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 5,
          instruction: l10n.nintendoAppGuideStep5,
          imageUrl: _asset('control-parental/nintendo/app/ns-App-paso5.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 6,
          instruction: l10n.nintendoAppGuideStep6,
          imageUrl: _asset('control-parental/nintendo/app/ns-App-paso6.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 7,
          instruction: l10n.nintendoAppGuideStep7,
          imageUrl: _asset('control-parental/nintendo/app/ns-App-paso7.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 8,
          instruction: l10n.nintendoAppGuideStep8,
          imageUrl: _asset('control-parental/nintendo/app/ns-App-paso8.webp'),
        ),
      ],
    );
  }

  // Guía de Steam (PC)
  ParentalGuide _getSteamGuide(AppLocalizations l10n) {
    return ParentalGuide(
      id: 'steam-guide',
      platform: 'steam',
      type: 'enable',
      title: l10n.steamGuideTitle,
      description: l10n.steamGuideDescription,
      iconUrl: _asset('icons/steam.png'),
      steps: [
        ParentalGuideStep(
          stepNumber: 1,
          instruction: l10n.steamGuideStep1,
          imageUrl: _asset('control-parental/steam/steam-paso1.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 2,
          instruction: l10n.steamGuideStep2,
          imageUrl: _asset('control-parental/steam/steam-paso2.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 3,
          instruction: l10n.steamGuideStep3,
          imageUrl: _asset('control-parental/steam/steam-paso3.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 4,
          instruction: l10n.steamGuideStep4,
          imageUrl: _asset('control-parental/steam/steam-paso4.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 5,
          instruction: l10n.steamGuideStep5,
          imageUrl: _asset('control-parental/steam/steam-paso5.webp'),
        ),
      ],
    );
  }

  // Guía de iOS - Tiempo de pantalla y restricciones
  ParentalGuide _getIosGuide(AppLocalizations l10n) {
    return ParentalGuide(
      id: 'ios-guide',
      platform: 'ios',
      type: 'enable',
      title: l10n.iosGuideTitle,
      description: l10n.iosGuideDescription,
      iconUrl: _asset('icons/ios.png'),
      steps: [
        ParentalGuideStep(
          stepNumber: 1,
          instruction: l10n.iosGuideStep1,
          imageUrl: _asset('control-parental/ios/enable/ios-paso1.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 2,
          instruction: l10n.iosGuideStep2,
          imageUrl: _asset('control-parental/ios/enable/ios-paso2.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 3,
          instruction: l10n.iosGuideStep3,
          imageUrl: _asset('control-parental/ios/enable/ios-paso3.webp'),
        ),
        ParentalGuideStep(
          stepNumber: 4,
          instruction: l10n.iosGuideStep4,
          imageUrl: _asset('control-parental/ios/enable/ios-paso4.webp'),
        ),
      ],
    );
  }
}