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
  
  String get typeDisplayName {
    return type == 'enable' ? 'Activar' : 'Desactivar';
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
}