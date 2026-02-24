class ParentalGuide {
  final String id;
  final String platform; // 'playstation', 'xbox', 'nintendo', 'steam', etc.
  final String title;
  final String description;
  final List<ParentalGuideStep> steps;
  final String iconUrl;

  ParentalGuide({
    required this.id,
    required this.platform,
    required this.title,
    required this.description,
    required this.steps,
    required this.iconUrl,
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
}

class ParentalGuideStep {
  final int stepNumber;
  final String instruction;
  final String imageUrl; // URL de jsDelivr con la imagen del paso

  ParentalGuideStep({
    required this.stepNumber,
    required this.instruction,
    required this.imageUrl,
  });
}