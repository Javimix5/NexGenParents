import 'package:flutter/material.dart';
import '../../config/app_config.dart';
import '../../models/parental_guide_model.dart';
import '../../services/parental_guides_service.dart';
import 'parental_guide_detail_screen.dart';

class ParentalGuidesListScreen extends StatelessWidget {
  const ParentalGuidesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final guidesService = ParentalGuidesService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Control Parental'),
      ),
      body: FutureBuilder<List<ParentalGuide>>(
        future: guidesService.getAllGuides(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error al cargar guías: ${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay guías disponibles'));
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
                    _buildBanner(),
                    const SizedBox(height: AppConfig.paddingLarge),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
                      child: Text(
                        'Selecciona tu plataforma (${allGuides.length} guía${allGuides.length != 1 ? 's' : ''})',
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
                    _buildInfoSection(),
                    const SizedBox(height: AppConfig.paddingLarge * 2),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBanner() {
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
          const Icon(Icons.security, size: 50, color: Colors.white),
          const SizedBox(height: AppConfig.paddingMedium),
          const Text(
            'Guías de Control Parental',
            style: TextStyle(
              fontSize: AppConfig.fontSizeTitle,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          Text(
            'Aprende a configurar controles de seguridad en las plataformas más populares.',
            style: TextStyle(
              fontSize: AppConfig.fontSizeBody,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformSection(BuildContext context, List<ParentalGuide> guides) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    guides.first.iconUrl,
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
                  guides.first.platformDisplayName,
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
                borderRadius: BorderRadius.circular(AppConfig.borderRadiusSmall),
                child: Image.network(
                  guide.iconUrl,
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
                      guide.title,
                      style: const TextStyle(
                        fontSize: AppConfig.fontSizeBody,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppConfig.paddingSmall / 2),
                    Text(
                      '${guide.typeDisplayName} • ${guide.steps.length} pasos',
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

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '¿Por qué es importante?',
            style: TextStyle(
              fontSize: AppConfig.fontSizeHeading,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConfig.paddingMedium),
          _buildInfoCard(
            icon: Icons.child_care,
            title: 'Protección infantil',
            description: 'Evita que tus hijos accedan a contenido no apropiado para su edad.',
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          _buildInfoCard(
            icon: Icons.schedule,
            title: 'Gestión del tiempo',
            description: 'Establece límites de tiempo de juego para mantener un equilibrio saludable.',
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          _buildInfoCard(
            icon: Icons.credit_card,
            title: 'Control de gastos',
            description: 'Previene compras no autorizadas dentro de los juegos.',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConfig.paddingMedium),
      decoration: BoxDecoration(
        color: AppConfig.cardColor,
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
        border: Border.all(color: AppConfig.textSecondaryColor.withValues(alpha: 0.2)),
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
