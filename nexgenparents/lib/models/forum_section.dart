class ForumSectionDefinition {
  const ForumSectionDefinition({
    required this.id,
    required this.nameEs,
    required this.nameGl,
    required this.descriptionEs,
    required this.descriptionGl,
  });

  final String id;
  final String nameEs;
  final String nameGl;
  final String descriptionEs;
  final String descriptionGl;

  String localizedName(String languageCode) {
    return languageCode == 'gl' ? nameGl : nameEs;
  }

  String localizedDescription(String languageCode) {
    return languageCode == 'gl' ? descriptionGl : descriptionEs;
  }
}

class ForumSections {
  static const welcome = ForumSectionDefinition(
    id: 'welcome',
    nameEs: 'Bienvenida',
    nameGl: 'Benvida',
    descriptionEs: 'Presentaciones y primeros pasos en la comunidad.',
    descriptionGl: 'Presentacións e primeiros pasos na comunidade.',
  );

  static const general = ForumSectionDefinition(
    id: 'general',
    nameEs: 'General',
    nameGl: 'Xeral',
    descriptionEs: 'Debates generales sobre crianza digital y videojuegos.',
    descriptionGl: 'Debates xerais sobre crianza dixital e videoxogos.',
  );

  static const news = ForumSectionDefinition(
    id: 'news',
    nameEs: 'Noticias',
    nameGl: 'Novas',
    descriptionEs: 'Actualidad del sector y novedades importantes.',
    descriptionGl: 'Actualidade do sector e novidades importantes.',
  );

  static const qna = ForumSectionDefinition(
    id: 'qna',
    nameEs: 'Preguntas y respuestas',
    nameGl: 'Preguntas e respostas',
    descriptionEs: 'Dudas concretas y ayuda entre familias.',
    descriptionGl: 'Dúbidas concretas e axuda entre familias.',
  );

  static const guides = ForumSectionDefinition(
    id: 'guides',
    nameEs: 'Guías, trucos y walkthroughs',
    nameGl: 'Guías, trucos e walkthroughs',
    descriptionEs: 'Recursos prácticos para entender y acompañar mejor.',
    descriptionGl: 'Recursos prácticos para entender e acompañar mellor.',
  );

  static const offtopic = ForumSectionDefinition(
    id: 'offtopic',
    nameEs: 'Offtopic',
    nameGl: 'Offtopic',
    descriptionEs: 'Conversación general fuera del foco principal.',
    descriptionGl: 'Conversa xeral fóra do foco principal.',
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
