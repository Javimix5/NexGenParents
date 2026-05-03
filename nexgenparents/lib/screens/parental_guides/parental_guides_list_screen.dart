import 'package:flutter/material.dart';
import '../../config/app_config.dart';
import '../../l10n/app_localizations.dart';
import '../../models/parental_guide_model.dart';
import '../../services/parental_guides_service.dart';
import '../../widgets/common/app_empty_state.dart';
import 'parental_guide_detail_screen.dart';
import '../info/pegi_info_screen.dart';
import '../../widgets/common/app_footer.dart';

class ParentalGuidesListScreen extends StatefulWidget {
  const ParentalGuidesListScreen({super.key});

  @override
  State<ParentalGuidesListScreen> createState() => _ParentalGuidesListScreenState();
}

class _ParentalGuidesListScreenState extends State<ParentalGuidesListScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;
  Future<List<ParentalGuide>>? _guidesFuture;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;
      if (_scrollController.offset >= 300 && !_showBackToTopButton) {
        setState(() => _showBackToTopButton = true);
      } else if (_scrollController.offset < 300 && _showBackToTopButton) {
        setState(() => _showBackToTopButton = false);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Cacheamos el Future aquí para que un setState() no reinicie el FutureBuilder
    if (_guidesFuture == null) {
      final guidesService = ParentalGuidesService();
      final l10n = AppLocalizations.of(context)!;
      _guidesFuture = guidesService.getAllGuides(l10n);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: FutureBuilder<List<ParentalGuide>>(
        future: _guidesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                l10n.parentalGuidesError(snapshot.error.toString()),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return AppEmptyState(
              icon: Icons.shield_outlined,
              title: l10n.parentalGuidesEmptyTitle,
              message: l10n.parentalGuidesEmptyMessage,
            );
          }

          final allGuides = snapshot.data!;
          final Map<String, List<ParentalGuide>> groupedGuides = {};
          for (final guide in allGuides) {
            groupedGuides.putIfAbsent(guide.platform, () => []).add(guide);
          }

          return SingleChildScrollView(
            controller: _scrollController,
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
                        l10n.parentalGuidesSelectPlatform(allGuides.length),
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
                    const AppFooter(),
                    const SizedBox(height: AppConfig.paddingLarge),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: _showBackToTopButton
          ? FloatingActionButton.small(
              heroTag: 'parental_guides_back_to_top_btn',
              onPressed: () {
                if (_scrollController.hasClients) {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
              backgroundColor: AppConfig.primaryColor,
              foregroundColor: Colors.white,
              child: const Icon(Icons.arrow_upward),
            )
          : null,
    );
  }

  Widget _buildBanner(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
            l10n.parentalGuidesBannerTitle,
            style: const TextStyle(
              fontSize: AppConfig.fontSizeTitle,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          Text(
            l10n.parentalGuidesBannerSubtitle,
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
              l10n.parentalGuidesMoreInfoBtn,
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
    final theme = Theme.of(context);
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
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.sports_esports,
                      color: theme.colorScheme.primary,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: AppConfig.paddingSmall),
                Text(
                  _getTranslatedPlatform(context, guides.first),
                  style: TextStyle(
                    fontSize: AppConfig.fontSizeBody,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
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
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
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
                    color: theme.colorScheme.primary.withValues(alpha: 0.08),
                    child: Icon(
                      Icons.sports_esports,
                      size: 24,
                      color: theme.colorScheme.primary,
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
                      '${_resolveClosureOrString(context, guide.typeDisplayName)} • ${l10n.parentalGuidesStepsCount(guide.steps.length)}',
                      style: TextStyle(
                        fontSize: AppConfig.fontSizeCaption,
                        color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.parentalGuidesWhyImportant,
            style: const TextStyle(
              fontSize: AppConfig.fontSizeHeading,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConfig.paddingMedium),
          _buildInfoCard(
            context,
            icon: Icons.child_care,
            title: l10n.parentalGuidesProtectionTitle,
            description: l10n.parentalGuidesProtectionDesc,
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          _buildInfoCard(
            context,
            icon: Icons.schedule,
            title: l10n.parentalGuidesTimeTitle,
            description: l10n.parentalGuidesTimeDesc,
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          _buildInfoCard(
            context,
            icon: Icons.credit_card,
            title: l10n.parentalGuidesSpendingTitle,
            description: l10n.parentalGuidesSpendingDesc,
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
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppConfig.paddingMedium),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
        border: Border.all(
            color: theme.dividerColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 28),
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
                  style: TextStyle(
                    fontSize: AppConfig.fontSizeCaption,
                    color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
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
