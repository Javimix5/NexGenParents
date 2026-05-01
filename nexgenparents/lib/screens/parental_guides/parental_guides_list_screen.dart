import 'package:flutter/material.dart';
import '../../config/app_config.dart';
import '../../l10n/app_localizations.dart';
import '../../models/parental_guide_model.dart';
import '../../services/parental_guides_service.dart';
import '../../widgets/common/app_empty_state.dart';
import 'parental_guide_detail_screen.dart';
import '../info/pegi_info_screen.dart';
import '../../widgets/common/app_footer.dart';

class ParentalGuidesListScreen extends StatelessWidget {
  const ParentalGuidesListScreen({super.key});

  String _t(BuildContext context,
      {required String es, required String gl, required String en}) {
    switch (Localizations.localeOf(context).languageCode) {
      case 'gl':
        return gl;
      case 'en':
        return en;
      default:
        return es;
    }
  }

  String _resolveClosureOrString(BuildContext context, dynamic value) {
    if (value is Function) {
      try {
        return value(AppLocalizations.of(context)!).toString();
      } catch (_) {}
    }
    return value.toString();
  }

  String _sanitizeUrl(String url) {
    if (url.isEmpty || url.contains('tu-usuario') || url.contains('tu-repositorio')) {
      return ''; // Corta en seco URLs de prueba para evitar error 404 en consola
    }
    return url;
  }

  String _getTranslatedTitle(BuildContext context, ParentalGuide guide) {
    final l10n = AppLocalizations.of(context)!;
    final titleStr = _resolveClosureOrString(context, guide.title).toLowerCase();
    final platform = guide.platform.toLowerCase();
    final type = guide.type.toLowerCase();

    if (platform == 'ps' || platform == 'playstation' || titleStr.contains('playstation')) {
      if (type == 'disable' || titleStr.contains('disable') || titleStr.contains('deshabilitar')) return l10n.psDisableGuideTitle;
      return l10n.psEnableGuideTitle;
    }
    if (platform == 'nintendo' || titleStr.contains('nintendo')) return l10n.nintendoGuideTitle;
    if (platform == 'steam' || titleStr.contains('steam')) return l10n.steamGuideTitle;
    if (platform == 'ios' || titleStr.contains('ios')) return l10n.iosGuideTitle;
    if (platform == 'xbox' || titleStr.contains('xbox')) {
      if (type == 'time' || titleStr.contains('time') || titleStr.contains('tiempo')) return l10n.xboxTimeGuideTitle;
      return l10n.xboxGuideTitle;
    }
    return _resolveClosureOrString(context, guide.title);
  }

  String _getTranslatedPlatform(BuildContext context, ParentalGuide guide) {
    final platformDisplay = _resolveClosureOrString(context, guide.platformDisplayName);
    final platform = guide.platform.toLowerCase();
    
    if (platform == 'ps' || platform == 'playstation') return 'PlayStation';
    if (platform == 'xbox') return 'Xbox';
    if (platform == 'nintendo') return 'Nintendo';
    if (platform == 'steam') return 'Steam';
    if (platform == 'ios') return 'iOS';
    if (platform == 'android') return 'Android';
    return platformDisplay;
  }

  @override
  Widget build(BuildContext context) {
    final guidesService = ParentalGuidesService();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: FutureBuilder<List<ParentalGuide>>(
        future: guidesService.getAllGuides(l10n),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                _t(context, es: 'Error al cargar guías: ${snapshot.error}', gl: 'Erro ao cargar guías: ${snapshot.error}', en: 'Error loading guides: ${snapshot.error}'),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return AppEmptyState(
              icon: Icons.shield_outlined,
              title: _t(context, es: 'No hay guías disponibles', gl: 'Non hai guías dispoñibles', en: 'No guides available'),
              message: _t(context, es: 'Vuelve a intentarlo más tarde.', gl: 'Volve intentalo máis tarde.', en: 'Please try again later.'),
            );
          }

          final allGuides = snapshot.data!;
          final Map<String, List<ParentalGuide>> groupedGuides = {};
          for (final guide in allGuides) {
            groupedGuides.putIfAbsent(guide.platform, () => []).add(guide);
          }

          return SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 980),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBanner(context),
                    const SizedBox(height: AppConfig.paddingLarge),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppConfig.paddingMedium),
                      child: Text(
                        _t(context, es: 'Selecciona tu plataforma (${allGuides.length} guía${allGuides.length != 1 ? 's' : ''})', gl: 'Selecciona a túa plataforma (${allGuides.length} guía${allGuides.length != 1 ? 's' : ''})', en: 'Select your platform (${allGuides.length} guide${allGuides.length != 1 ? 's' : ''})'),
                        style: const TextStyle(
                          fontSize: AppConfig.fontSizeHeading,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppConfig.paddingMedium),
                    ...groupedGuides.entries.map(
                      (entry) => _buildPlatformSection(context, entry.value),
                    ),
                    const SizedBox(height: AppConfig.paddingLarge),
                    _buildInfoSection(context),
                    const SizedBox(height: AppConfig.paddingLarge * 2),
                    AppFooter(
                      onPrivacyTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const PegiInfoScreen())),
                      onAboutTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const PegiInfoScreen())),
                      onContactTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const ParentalGuidesListScreen())),
                    ),
                    const SizedBox(height: AppConfig.paddingLarge),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConfig.paddingLarge),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppConfig.primaryColor,
            AppConfig.secondaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppConfig.paddingMedium),
          Text(
            _t(context, es: 'Guías de Control Parental', gl: 'Guías de Control Parental', en: 'Parental Control Guides'),
            style: const TextStyle(
              fontSize: AppConfig.fontSizeTitle,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          Text(
            _t(context, es: 'Aprende a configurar controles de seguridad en las plataformas más populares.', gl: 'Aprende a configurar controis de seguridade nas plataformas máis populares.', en: 'Learn how to set up security controls on the most popular platforms.'),
            style: TextStyle(
              fontSize: AppConfig.fontSizeBody,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: AppConfig.paddingMedium),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const PegiInfoScreen()),
              );
            },
            icon: const Icon(Icons.info_outline, color: Colors.white),
            label: Text(
              _t(context, es: 'Saber más sobre PEGI/ESRB', gl: 'Saber máis sobre PEGI/ESRB', en: 'Learn about PEGI/ESRB'),
              style: const TextStyle(color: Colors.white),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.white.withOpacity(0.5)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformSection(
      BuildContext context, List<ParentalGuide> guides) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    _sanitizeUrl(guides.first.iconUrl),
                    width: 28,
                    height: 28,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.sports_esports,
                      color: AppConfig.primaryColor,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: AppConfig.paddingSmall),
                Text(
                  _getTranslatedPlatform(context, guides.first),
                  style: const TextStyle(
                    fontSize: AppConfig.fontSizeBody,
                    fontWeight: FontWeight.bold,
                    color: AppConfig.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          ...guides.map((guide) => _buildGuideCard(context, guide)),
        ],
      ),
    );
  }

  Widget _buildGuideCard(BuildContext context, ParentalGuide guide) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConfig.paddingMedium,
        vertical: AppConfig.paddingSmall / 2,
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ParentalGuideDetailScreen(guide: guide),
            ),
          );
        },
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppConfig.paddingMedium),
          child: Row(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppConfig.borderRadiusSmall),
                child: Image.network(
                  _sanitizeUrl(guide.iconUrl),
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 48,
                    height: 48,
                    color: AppConfig.primaryColor.withValues(alpha: 0.08),
                    child: const Icon(
                      Icons.sports_esports,
                      size: 24,
                      color: AppConfig.primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppConfig.paddingMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getTranslatedTitle(context, guide),
                      style: const TextStyle(
                        fontSize: AppConfig.fontSizeBody,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppConfig.paddingSmall / 2),
                    Text(
                      '${_resolveClosureOrString(context, guide.typeDisplayName)} • ${guide.steps.length} ${_t(context, es: 'pasos', gl: 'pasos', en: 'steps')}',
                      style: const TextStyle(
                        fontSize: AppConfig.fontSizeCaption,
                        color: AppConfig.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppConfig.textSecondaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _t(context, es: '¿Por qué es importante?', gl: 'Por que é importante?', en: 'Why is it important?'),
            style: const TextStyle(
              fontSize: AppConfig.fontSizeHeading,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConfig.paddingMedium),
          _buildInfoCard(
            context,
            icon: Icons.child_care,
            title: _t(context, es: 'Protección infantil', gl: 'Protección infantil', en: 'Child protection'),
            description: _t(context, es: 'Evita que tus hijos accedan a contenido no apropiado para su edad.', gl: 'Evita que os teus fillos accedan a contido non apropiado para a súa idade.', en: 'Prevent your children from accessing age-inappropriate content.'),
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          _buildInfoCard(
            context,
            icon: Icons.schedule,
            title: _t(context, es: 'Gestión del tiempo', gl: 'Xestión do tempo', en: 'Time management'),
            description: _t(context, es: 'Establece límites de tiempo de juego para mantener un equilibrio saludable.', gl: 'Establece límites de tempo de xogo para manter un equilibrio saudable.', en: 'Set playtime limits to maintain a healthy balance.'),
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          _buildInfoCard(
            context,
            icon: Icons.credit_card,
            title: _t(context, es: 'Control de gastos', gl: 'Control de gastos', en: 'Spending control'),
            description: _t(context, es: 'Previene compras no autorizadas dentro de los juegos.', gl: 'Prevén compras non autorizadas dentro dos xogos.', en: 'Prevent unauthorized in-game purchases.'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConfig.paddingMedium),
      decoration: BoxDecoration(
        color: AppConfig.backgroundLight,
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
        border: Border.all(
            color: AppConfig.textSecondaryColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppConfig.primaryColor, size: 28),
          const SizedBox(width: AppConfig.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: AppConfig.fontSizeBody,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppConfig.paddingSmall / 2),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: AppConfig.fontSizeCaption,
                    color: AppConfig.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
