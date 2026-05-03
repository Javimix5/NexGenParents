import '../l10n/app_localizations.dart';

class ParentalGuide {
  final String id;
  final String platform;
  final String title;
  final String description;
  final List<ParentalGuideStep> steps;
  final String iconUrl;
  final String type;

  ParentalGuide({
    required this.id,
    required this.platform,
    required this.title,
    required this.description,
    required this.steps,
    required this.iconUrl,
    this.type = 'enable',
  });

  // Convertir a Map para Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'platform': platform,
      'title': title,
      'description': description,
      'steps': steps.map((step) => step.toMap()).toList(),
      'iconUrl': iconUrl,
      'type': type,
    };
  }

  // Crear desde Map (Firestore)
  factory ParentalGuide.fromMap(Map<String, dynamic> map) {
    List<ParentalGuideStep> steps = [];
    if (map['steps'] != null && map['steps'] is List) {
      steps = (map['steps'] as List<dynamic>)
          .map((step) => ParentalGuideStep.fromMap(step as Map<String, dynamic>))
          .toList();
    }

    return ParentalGuide(
      id: map['id'] as String? ?? '',
      platform: map['platform'] as String? ?? 'unknown',
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      steps: steps,
      iconUrl: map['iconUrl'] as String? ?? '',
      type: map['type'] as String? ?? 'enable',
    );
  }

  String get platformDisplayName {
    switch (platform) {
      case 'playstation':
        return 'PlayStation (PS4/PS5)';
      case 'xbox':
        return 'Xbox (Series X/S)';
      case 'nintendo':
        return 'Nintendo Switch';
      case 'steam':
        return 'Steam (PC)';
      case 'android':
        return 'Android';
      case 'ios':
        return 'iOS';
      default:
        return platform;
    }
  }
  
  String typeDisplayName(AppLocalizations l10n) {
    switch (type) {
      case 'enable':
        return l10n.guideTypeEnable;
      case 'disable':
        return l10n.guideTypeDisable;
      case 'app':
        return l10n.guideTypeApp;
      case 'time':
        return l10n.guideTypeTime;
      default:
        return l10n.guideTypeDefault;
    }
  }
}

class ParentalGuideStep {
  final int stepNumber;
  final String instruction;
  final String imageUrl;

  ParentalGuideStep({
    required this.stepNumber,
    required this.instruction,
    required this.imageUrl,
  });

  // Convertir a Map para Firestore
  Map<String, dynamic> toMap() {
    return {
      'stepNumber': stepNumber,
      'instruction': instruction,
      'imageUrl': imageUrl,
    };
  }

  // Crear desde Map
  factory ParentalGuideStep.fromMap(Map<String, dynamic> map) {
    return ParentalGuideStep(
      stepNumber: map['stepNumber'] as int? ?? 0,
      instruction: map['instruction'] as String? ?? '',
      imageUrl: map['imageUrl'] as String? ?? '',
    );
  }
}