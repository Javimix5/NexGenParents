class ForumSectionDefinition {
  const ForumSectionDefinition({
    required this.id,
    required this.nameEs,
    required this.nameGl,
    required this.nameEn,
    required this.descriptionEs,
    required this.descriptionGl,
    required this.descriptionEn,
  });

  final String id;
  final String nameEs;
  final String nameGl;
  final String nameEn;
  final String descriptionEs;
  final String descriptionGl;
  final String descriptionEn;

  String localizedName(String languageCode) {
    if (languageCode == 'gl') return nameGl;
    if (languageCode == 'en') return nameEn;
    return nameEs;
  }

  String localizedDescription(String languageCode) {
    if (languageCode == 'gl') return descriptionGl;
    if (languageCode == 'en') return descriptionEn;
    return descriptionEs;
  }
}

class ForumSections {
  static const welcome = ForumSectionDefinition(
    id: 'welcome',
    nameEs: 'Bienvenida',
    nameGl: 'Benvida',
    nameEn: 'Welcome',
    descriptionEs: 'Presentaciones y primeros pasos en la comunidad.',
    descriptionGl: 'Presentacións e primeiros pasos na comunidade.',
    descriptionEn: 'Introductions and first steps in the community.',
  );

  static const general = ForumSectionDefinition(
    id: 'general',
    nameEs: 'General',
    nameGl: 'Xeral',
    nameEn: 'General',
    descriptionEs: 'Debates generales sobre crianza digital y videojuegos.',
    descriptionGl: 'Debates xerais sobre crianza dixital e videoxogos.',
    descriptionEn: 'General discussions about digital parenting and video games.',
  );

  static const news = ForumSectionDefinition(
    id: 'news',
    nameEs: 'Noticias',
    nameGl: 'Novas',
    nameEn: 'News',
    descriptionEs: 'Actualidad del sector y novedades importantes.',
    descriptionGl: 'Actualidade do sector e novidades importantes.',
    descriptionEn: 'Industry news and important updates.',
  );

  static const qna = ForumSectionDefinition(
    id: 'qna',
    nameEs: 'Preguntas y respuestas',
    nameGl: 'Preguntas e respostas',
    nameEn: 'Q&A',
    descriptionEs: 'Dudas concretas y ayuda entre familias.',
    descriptionGl: 'Dúbidas concretas e axuda entre familias.',
    descriptionEn: 'Specific questions and help among families.',
  );

  static const guides = ForumSectionDefinition(
    id: 'guides',
    nameEs: 'Guías, trucos y walkthroughs',
    nameGl: 'Guías, trucos e walkthroughs',
    nameEn: 'Guides, cheats and walkthroughs',
    descriptionEs: 'Recursos prácticos para entender y acompañar mejor.',
    descriptionGl: 'Recursos prácticos para entender e acompañar mellor.',
    descriptionEn: 'Practical resources to understand and support better.',
  );

  static const offtopic = ForumSectionDefinition(
    id: 'offtopic',
    nameEs: 'Offtopic',
    nameGl: 'Offtopic',
    nameEn: 'Offtopic',
    descriptionEs: 'Conversación general fuera del foco principal.',
    descriptionGl: 'Conversa xeral fóra do foco principal.',
    descriptionEn: 'General conversation outside the main focus.',
  );

  static const List<ForumSectionDefinition> all = [
    welcome,
    general,
    news,
    qna,
    guides,
    offtopic,
  ];

  static String normalizeId(String? id) {
    if (id == null || id.trim().isEmpty) {
      return general.id;
    }
    return id.trim().toLowerCase();
  }

  static ForumSectionDefinition byId(String? id) {
    final normalized = normalizeId(id);
    return all.firstWhere(
      (section) => section.id == normalized,
      orElse: () => general,
    );
  }

  static String idFromLegacyTopic(String? topic) {
    final value = (topic ?? '').trim().toLowerCase();
    if (value.isEmpty) return general.id;

    switch (value) {
      case 'bienvenida':
      case 'benvida':
      case 'welcome':
        return welcome.id;
      case 'general':
      case 'xeral':
        return general.id;
      case 'noticias':
      case 'novas':
      case 'news':
        return news.id;
      case 'preguntas y respuestas':
      case 'preguntas e respostas':
      case 'q&a':
      case 'q and a':
      case 'qna':
        return qna.id;
      case 'guías, trucos y walkthroughs':
      case 'guias, trucos y walkthroughs':
      case 'guías, trucos e walkthroughs':
      case 'guides':
      case 'guides, cheats & walkthroughs':
        return guides.id;
      case 'offtopic':
        return offtopic.id;
      default:
        return general.id;
    }
  }
}
