import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../config/app_config.dart';

class PegiInfoScreen extends StatelessWidget {
  const PegiInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistemas de Clasificación'),
      ),
      body: SingleChildScrollView(
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
    );
  }

  Widget _buildHeader(BuildContext context) {
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
          const Icon(
            Icons.info_outline,
            size: 60,
            color: Colors.white,
          ),
          const SizedBox(height: AppConfig.paddingMedium),
          const Text(
            '¿Qué significan las clasificaciones por edad?',
            style: TextStyle(
              fontSize: AppConfig.fontSizeTitle,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          Text(
            'Los sistemas de clasificación ayudan a los padres a elegir videojuegos apropiados para sus hijos.',
            style: TextStyle(
              fontSize: AppConfig.fontSizeBody,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPegiExplanation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.flag, color: AppConfig.primaryColor),
              const SizedBox(width: AppConfig.paddingSmall),
              Text(
                'Sistema PEGI (Europa)',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ],
          ),
          const SizedBox(height: AppConfig.paddingMedium),
          
          _buildPegiCard(
            age: '3',
            imageUrl: '${AppConfig.githubCdnBase}/info/pegi/PEGI_3.webp',
            title: 'PEGI 3',
            description: 'Contenido apto para todas las edades. Sin violencia ni lenguaje soez.',
          ),
          
          _buildPegiCard(
            age: '7',
            imageUrl: '${AppConfig.githubCdnBase}/info/pegi/PEGI_7.webp',
            title: 'PEGI 7',
            description: 'Puede contener escenas o sonidos que asusten a niños pequeños.',
          ),
          
          _buildPegiCard(
            age: '12',
            imageUrl: '${AppConfig.githubCdnBase}/info/pegi/PEGI_12.webp',
            title: 'PEGI 12',
            description: 'Violencia en un entorno de fantasía o violencia no realista hacia personajes.',
          ),
          
          _buildPegiCard(
            age: '16',
            imageUrl: '${AppConfig.githubCdnBase}/info/pegi/PEGI_16.webp',
            title: 'PEGI 16',
            description: 'Violencia realista, lenguaje soez fuerte o escenas sexuales.',
          ),
          
          _buildPegiCard(
            age: '18',
            imageUrl: '${AppConfig.githubCdnBase}/info/pegi/PEGI_18.webp',
            title: 'PEGI 18',
            description: 'Violencia extrema, contenido sexual explícito o apuestas con dinero real.',
          ),
        ],
      ),
    );
  }

  Widget _buildEsrbExplanation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.flag, color: AppConfig.secondaryColor),
              const SizedBox(width: AppConfig.paddingSmall),
              Text(
                'Sistema ESRB (Estados Unidos)',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ],
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          const Text(
            'Este es el sistema que suele aparecer en la API de videojuegos que utilizamos.',
            style: TextStyle(
              fontSize: AppConfig.fontSizeCaption,
              color: AppConfig.textSecondaryColor,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: AppConfig.paddingMedium),
          
          _buildEsrbCard(
            'E',
            'Everyone',
            'Contenido para todos. Equivalente a PEGI 3.',
            '${AppConfig.githubCdnBase}/info/esrb/ESRB_E.webp',
          ),
          _buildEsrbCard(
            'E10+',
            'Everyone 10+',
            'Para mayores de 10 años. Similar a PEGI 7.',
            '${AppConfig.githubCdnBase}/info/esrb/ESRB_Early_Childhood.webp',
          ),
          _buildEsrbCard(
            'T',
            'Teen',
            'Adolescentes. Equivalente a PEGI 12.',
            '${AppConfig.githubCdnBase}/info/esrb/ESRB_Teen.webp',
          ),
          _buildEsrbCard(
            'M',
            'Mature 17+',
            'Mayores de 17 años. Similar a PEGI 16.',
            '${AppConfig.githubCdnBase}/info/esrb/ESRB_Mature_17+.webp',
          ),
          _buildEsrbCard(
            'AO',
            'Adults Only',
            'Solo adultos. Equivalente a PEGI 18.',
            '${AppConfig.githubCdnBase}/info/esrb/ESRB_Adults_Only_18+.webp',
          ),
          _buildEsrbCard(
            'RP',
            'Rating Pending',
            'Clasificación pendiente (juegos en preventa).',
            '${AppConfig.githubCdnBase}/info/esrb/ESRB_RP.webp',
          ),
        ],
      ),
    );
  }

  Widget _buildPegiCard({
    required String age,
    required String imageUrl,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConfig.paddingMedium),
      padding: const EdgeInsets.all(AppConfig.paddingMedium),
      decoration: BoxDecoration(
        color: AppConfig.cardColor,
        border: Border.all(color: AppConfig.textSecondaryColor.withOpacity(0.3)),
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
                color: AppConfig.textSecondaryColor.withOpacity(0.1),
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppConfig.primaryColor,
                  borderRadius: BorderRadius.circular(AppConfig.borderRadiusSmall),
                ),
                child: Center(
                  child: Text(
                    age,
                    style: const TextStyle(
                      color: Colors.white,
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppConfig.fontSizeBody,
                    color: AppConfig.primaryColor,
                  ),
                ),
                const SizedBox(height: AppConfig.paddingSmall / 2),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: AppConfig.fontSizeCaption,
                    color: AppConfig.textPrimaryColor,
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
    String rating,
    String fullName,
    String description,
    String imageUrl,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConfig.paddingSmall),
      padding: const EdgeInsets.all(AppConfig.paddingMedium),
      decoration: BoxDecoration(
        color: AppConfig.cardColor,
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
        border: Border.all(color: AppConfig.textSecondaryColor.withOpacity(0.2)),
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
                color: AppConfig.textSecondaryColor.withOpacity(0.1),
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(AppConfig.paddingSmall),
                decoration: BoxDecoration(
                  color: AppConfig.secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConfig.borderRadiusSmall),
                  border: Border.all(color: AppConfig.secondaryColor),
                ),
                child: Center(
                  child: Text(
                    rating,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: AppConfig.secondaryColor,
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

  Widget _buildContentDescriptors(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppConfig.paddingMedium),
      padding: const EdgeInsets.all(AppConfig.paddingMedium),
      decoration: BoxDecoration(
        color: AppConfig.warningColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
        border: Border.all(color: AppConfig.warningColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.warning_amber, color: AppConfig.warningColor),
              SizedBox(width: AppConfig.paddingSmall),
              Text(
                'Descriptores de Contenido PEGI',
                style: TextStyle(
                  fontSize: AppConfig.fontSizeHeading,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          const Text(
            'Además de la edad, las clasificaciones incluyen iconos que indican el tipo de contenido:',
            style: TextStyle(fontSize: AppConfig.fontSizeBody),
          ),
          const SizedBox(height: AppConfig.paddingMedium),
          
          Wrap(
            spacing: AppConfig.paddingSmall,
            runSpacing: AppConfig.paddingSmall,
            children: [
              _buildDescriptorChip(
                'Violencia',
                '${AppConfig.githubCdnBase}/info/content/PEGI_Violence.webp',
              ),
              _buildDescriptorChip(
                'Miedo',
                '${AppConfig.githubCdnBase}/info/content/Pegi_Fear.webp',
              ),
              _buildDescriptorChip(
                'Online',
                '${AppConfig.githubCdnBase}/info/content/PEGI_Online.webp',
              ),
              _buildDescriptorChip(
                'Discriminación',
                '${AppConfig.githubCdnBase}/info/content/PEGI_discrimination.webp',
              ),
              _buildDescriptorChip(
                'Drogas',
                '${AppConfig.githubCdnBase}/info/content/PEGI_drugs.webp',
              ),
              _buildDescriptorChip(
                'Sexo',
                '${AppConfig.githubCdnBase}/info/content/PEGIsex.webp',
              ),
              _buildDescriptorChip(
                'Lenguaje soez',
                '${AppConfig.githubCdnBase}/info/content/PEGIlenguagex.webp',
              ),
              _buildDescriptorChip(
                'Juego/Apuestas',
                '${AppConfig.githubCdnBase}/info/content/PEGI_gambling.webp',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptorChip(String label, String imageUrl) {
    return Container(
      padding: const EdgeInsets.all(AppConfig.paddingSmall),
      decoration: BoxDecoration(
        color: AppConfig.cardColor,
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusSmall),
        border: Border.all(color: AppConfig.textSecondaryColor.withOpacity(0.3)),
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
                color: AppConfig.textSecondaryColor.withOpacity(0.1),
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
                color: AppConfig.warningColor.withOpacity(0.2),
                child: const Icon(Icons.warning, size: 16, color: AppConfig.warningColor),
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