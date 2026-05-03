import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../l10n/app_localizations.dart';
import '../../config/app_config.dart';

class PegiInfoScreen extends StatefulWidget {
  const PegiInfoScreen({super.key});

  @override
  State<PegiInfoScreen> createState() => _PegiInfoScreenState();
}

class _PegiInfoScreenState extends State<PegiInfoScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;

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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.classificationSystemsTitle),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            _buildPegiExplanation(context),
            _buildEsrbExplanation(context),
            _buildContentDescriptors(context),
            const SizedBox(height: AppConfig.paddingLarge * 2),
          ],
        ),
      ),
      floatingActionButton: _showBackToTopButton
          ? FloatingActionButton.small(
              heroTag: 'pegi_info_back_to_top_btn',
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

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConfig.paddingLarge),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            size: 60,
            color: theme.colorScheme.onPrimary,
          ),
          const SizedBox(height: AppConfig.paddingMedium),
          Text(
            l10n.ageRatingsMeaningTitle,
            style: TextStyle(
              fontSize: AppConfig.fontSizeTitle,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          Text(
            l10n.pegiInfoSubtitle,
            style: TextStyle(
              fontSize: AppConfig.fontSizeBody,
              color: theme.colorScheme.onPrimary.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPegiExplanation(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.flag, color: theme.colorScheme.primary),
              const SizedBox(width: AppConfig.paddingSmall),
              Text(
                l10n.pegiSystemEuropa,
                style: theme.textTheme.displayLarge,
              ),
            ],
          ),
          const SizedBox(height: AppConfig.paddingMedium),
          _buildPegiCard(
            context,
            age: '3',
            imageUrl: '${AppConfig.githubCdnBase}/info/pegi/PEGI_3.webp',
            title: 'PEGI 3',
            description: l10n.pegiDescription3,
          ),
          _buildPegiCard(
            context,
            age: '7',
            imageUrl: '${AppConfig.githubCdnBase}/info/pegi/PEGI_7.webp',
            title: 'PEGI 7',
            description: l10n.pegiDescription7,
          ),
          _buildPegiCard(
            context,
            age: '12',
            imageUrl: '${AppConfig.githubCdnBase}/info/pegi/PEGI_12.webp',
            title: 'PEGI 12',
            description: l10n.pegiDescription12,
          ),
          _buildPegiCard(
            context,
            age: '16',
            imageUrl: '${AppConfig.githubCdnBase}/info/pegi/PEGI_16.webp',
            title: 'PEGI 16',
            description: l10n.pegiDescription16,
          ),
          _buildPegiCard(
            context,
            age: '18',
            imageUrl: '${AppConfig.githubCdnBase}/info/pegi/PEGI_18.webp',
            title: 'PEGI 18',
            description: l10n.pegiDescription18,
          ),
        ],
      ),
    );
  }

  Widget _buildEsrbExplanation(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.flag, color: theme.colorScheme.secondary),
              const SizedBox(width: AppConfig.paddingSmall),
              Text(
                l10n.esrbSystemUsa,
                style: theme.textTheme.displayLarge,
              ),
            ],
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          Text(
            l10n.esrbApiNote,
            style: TextStyle(
              fontSize: AppConfig.fontSizeCaption,
              fontStyle: FontStyle.italic,
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(height: AppConfig.paddingMedium),
          _buildEsrbCard(
            context,
            'E',
            'Everyone',
            l10n.esrbDescriptionE,
            '${AppConfig.githubCdnBase}/info/esrb/ESRB_E.webp',
          ),
          _buildEsrbCard(
            context,
            'E10+',
            'Everyone 10+',
            l10n.esrbDescriptionE10,
            '${AppConfig.githubCdnBase}/info/esrb/ESRB_Early_Childhood.webp',
          ),
          _buildEsrbCard(
            context,
            'T',
            'Teen',
            l10n.esrbDescriptionT,
            '${AppConfig.githubCdnBase}/info/esrb/ESRB_Teen.webp',
          ),
          _buildEsrbCard(
            context,
            'M',
            'Mature 17+',
            l10n.esrbDescriptionM,
            '${AppConfig.githubCdnBase}/info/esrb/ESRB_Mature_17+.webp',
          ),
          _buildEsrbCard(
            context,
            'AO',
            'Adults Only',
            l10n.esrbDescriptionAO,
            '${AppConfig.githubCdnBase}/info/esrb/ESRB_Adults_Only_18+.webp',
          ),
          _buildEsrbCard(
            context,
            'RP',
            'Rating Pending',
            l10n.esrbDescriptionRP,
            '${AppConfig.githubCdnBase}/info/esrb/ESRB_RP.webp',
          ),
        ],
      ),
    );
  }

  Widget _buildPegiCard(
    BuildContext context, {
    required String age,
    required String imageUrl,
    required String title,
    required String description,
  }) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: AppConfig.paddingMedium),
      padding: const EdgeInsets.all(AppConfig.paddingMedium),
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border.all(color: theme.dividerColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
      ),
      child: Row(
        children: [
          // Imagen de clasificación PEGI
          ClipRRect(
            borderRadius: BorderRadius.circular(AppConfig.borderRadiusSmall),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.contain,
              placeholder: (context, url) => Container(
                width: 60,
                height: 60,
                color: theme.colorScheme.onSurface.withOpacity(0.1),
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius:
                      BorderRadius.circular(AppConfig.borderRadiusSmall),
                ),
                child: Center(
                  child: Text(
                    age,
                    style: const TextStyle(
                      color: Colors
                          .white, // Aquí blanco está bien porque el fondo es el color primario
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
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
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppConfig.fontSizeBody,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: AppConfig.paddingSmall / 2),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: AppConfig.fontSizeCaption,
                    // El color del texto se hereda del tema por defecto, no hace falta especificarlo
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEsrbCard(
    BuildContext context,
    String rating,
    String fullName,
    String description,
    String imageUrl,
  ) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: AppConfig.paddingSmall),
      padding: const EdgeInsets.all(AppConfig.paddingMedium),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
        border: Border.all(color: theme.dividerColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppConfig.borderRadiusSmall),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.contain,
              placeholder: (context, url) => Container(
                width: 50,
                height: 50,
                color: theme.colorScheme.onSurface.withOpacity(0.1),
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(AppConfig.paddingSmall),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(AppConfig.borderRadiusSmall),
                  border: Border.all(color: theme.colorScheme.secondary),
                ),
                child: Center(
                  child: Text(
                    rating,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: theme.colorScheme.secondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
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
                  fullName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppConfig.fontSizeBody,
                  ),
                ),
                const SizedBox(height: AppConfig.paddingSmall / 2),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: AppConfig.fontSizeCaption,
                    // Color heredado del tema
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentDescriptors(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.all(AppConfig.paddingMedium),
      padding: const EdgeInsets.all(AppConfig.paddingMedium),
      decoration: BoxDecoration(
        color:
            theme.colorScheme.tertiaryContainer, // Un buen color para destacar
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
        border: Border.all(color: theme.colorScheme.tertiary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber, color: theme.colorScheme.tertiary),
              const SizedBox(width: AppConfig.paddingSmall),
              Text(
                l10n.pegiContentDescriptorsTitle,
                style: TextStyle(
                  fontSize: AppConfig.fontSizeHeading,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          Text(
            l10n.pegiContentDescriptorsSubtitle,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: AppConfig.paddingMedium),
          Wrap(
            spacing: AppConfig.paddingSmall,
            runSpacing: AppConfig.paddingSmall,
            children: [
              _buildDescriptorChip(
                context,
                l10n.contentDescriptorViolence,
                '${AppConfig.githubCdnBase}/info/content/PEGI_Violence.webp',
              ),
              _buildDescriptorChip(
                context,
                l10n.contentDescriptorFear,
                '${AppConfig.githubCdnBase}/info/content/Pegi_Fear.webp',
              ),
              _buildDescriptorChip(
                context,
                l10n.contentDescriptorOnline,
                '${AppConfig.githubCdnBase}/info/content/PEGI_Online.webp',
              ),
              _buildDescriptorChip(
                context,
                l10n.contentDescriptorDiscrimination,
                '${AppConfig.githubCdnBase}/info/content/PEGI_discrimination.webp',
              ),
              _buildDescriptorChip(
                context,
                l10n.contentDescriptorDrugs,
                '${AppConfig.githubCdnBase}/info/content/PEGI_drugs.webp',
              ),
              _buildDescriptorChip(
                context,
                l10n.contentDescriptorSex,
                '${AppConfig.githubCdnBase}/info/content/PEGIsex.webp',
              ),
              _buildDescriptorChip(
                context,
                l10n.contentDescriptorBadLanguage,
                '${AppConfig.githubCdnBase}/info/content/PEGIlenguagex.webp',
              ),
              _buildDescriptorChip(
                context,
                l10n.contentDescriptorGambling,
                '${AppConfig.githubCdnBase}/info/content/PEGI_gambling.webp',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptorChip(
      BuildContext context, String label, String imageUrl) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppConfig.paddingSmall),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusSmall),
        border: Border.all(color: theme.dividerColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 30,
              height: 30,
              fit: BoxFit.contain,
              placeholder: (context, url) => Container(
                width: 30,
                height: 30,
                color: theme.colorScheme.onSurface.withOpacity(0.1),
                child: const Center(
                  child: SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 30,
                height: 30,
                color: theme.colorScheme.tertiary.withOpacity(0.2),
                child: Icon(Icons.warning,
                    size: 16, color: theme.colorScheme.tertiary),
              ),
            ),
          ),
          const SizedBox(width: AppConfig.paddingSmall),
          Text(
            label,
            style: const TextStyle(
              fontSize: AppConfig.fontSizeCaption,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
