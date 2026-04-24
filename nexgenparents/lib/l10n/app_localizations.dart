import 'package:flutter/widgets.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String loading(String appName) => 'Cargando $appName...';

  String get classificationSystemsTitle =>
      locale.languageCode == 'gl' ? 'Sistemas de clasificación' : 'Sistemas de clasificación';

  String get ageRatingsMeaningTitle =>
      locale.languageCode == 'gl' ? 'Que significan as clasificacións por idade' : 'Qué significan las clasificaciones por edad';

  String get pegiInfoSubtitle => locale.languageCode == 'gl'
      ? 'Aprende a interpretar PEGI e ESRB para decidir mellor.'
      : 'Aprende a interpretar PEGI y ESRB para tomar mejores decisiones.';

  String get pegiSystemEuropa =>
      locale.languageCode == 'gl' ? 'Sistema PEGI (Europa)' : 'Sistema PEGI (Europa)';

  String get esrbSystemUsa =>
      locale.languageCode == 'gl' ? 'Sistema ESRB (EUA)' : 'Sistema ESRB (EE.UU.)';

  String get esrbApiNote => locale.languageCode == 'gl'
      ? 'Nota: A API pode devolver códigos ESRB en lugar de PEGI nalgúns xogos.'
      : 'Nota: La API puede devolver códigos ESRB en lugar de PEGI en algunos juegos.';

  String get pegiContentDescriptorsTitle => locale.languageCode == 'gl'
      ? 'Descritores de contido PEGI'
      : 'Descriptores de contenido PEGI';

  String get pegiContentDescriptorsSubtitle => locale.languageCode == 'gl'
      ? 'Estes iconos explican o tipo de contido que pode aparecer no xogo.'
      : 'Estos iconos explican el tipo de contenido que puede aparecer en el juego.';

  String get contentDescriptorViolence =>
      locale.languageCode == 'gl' ? 'Violencia' : 'Violencia';

  String get contentDescriptorFear =>
      locale.languageCode == 'gl' ? 'Medo' : 'Miedo';

  String get contentDescriptorOnline =>
      locale.languageCode == 'gl' ? 'En liña' : 'En línea';

  String get contentDescriptorDiscrimination =>
      locale.languageCode == 'gl' ? 'Discriminación' : 'Discriminación';

  String get contentDescriptorDrugs =>
      locale.languageCode == 'gl' ? 'Drogas' : 'Drogas';

  String get contentDescriptorSex =>
      locale.languageCode == 'gl' ? 'Sexo' : 'Sexo';

  String get contentDescriptorBadLanguage =>
      locale.languageCode == 'gl' ? 'Linguaxe malsonante' : 'Lenguaje malsonante';

  String get contentDescriptorGambling =>
      locale.languageCode == 'gl' ? 'Xogo de azar' : 'Apuestas';
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['es', 'gl'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
