import 'package:flutter/material.dart';
import '../../services/parental_guides_service.dart';
import '../../models/parental_guide_model.dart';
import '../../config/app_config.dart';
import 'parental_guide_detail_screen.dart';

class ParentalGuidesListScreen extends StatelessWidget {
  const ParentalGuidesListScreen({super.key});

  @override
Widget build(BuildContext context) {
  final guidesService = ParentalGuidesService();
  final allGuides = guidesService.getAllGuides();
  
  // Agrupar guías por plataforma
  final Map<String, List<ParentalGuide>> groupedGuides = {};
  for (var guide in allGuides) {
    if (!groupedGuides.containsKey(guide.platform)) {
      groupedGuides[guide.platform] = [];
    }
    groupedGuides[guide.platform]!.add(guide);
  }

  return Scaffold(
    appBar: AppBar(
      title: Text('Control Parental'),
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner informativo (sin cambios)
          // Banner informativo
Container(
  width: double.infinity,
  padding: EdgeInsets.all(AppConfig.paddingLarge),
  decoration: BoxDecoration(
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
      Icon(
        Icons.security,
        size: 50,
        color: Colors.white,
      ),
      SizedBox(height: AppConfig.paddingMedium),
      Text(
        'Guías de Control Parental',
        style: TextStyle(
          fontSize: AppConfig.fontSizeTitle,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      SizedBox(height: AppConfig.paddingSmall),
      Text(
        'Aprende a configurar controles de seguridad en las consolas y plataformas más populares.',
        style: TextStyle(
          fontSize: AppConfig.fontSizeBody,
          color: Colors.white.withOpacity(0.9),
        ),
      ),
    ],
  ),
),
          
          SizedBox(height: AppConfig.paddingLarge),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
            child: Text(
              'Selecciona tu plataforma',
              style: TextStyle(
                fontSize: AppConfig.fontSizeHeading,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: AppConfig.paddingMedium),
          
          // Mostrar guías agrupadas por plataforma
          ...groupedGuides.entries.map((entry) {
            return _buildPlatformSection(context, entry.key, entry.value);
          }).toList(),
          
          SizedBox(height: AppConfig.paddingLarge),
          _buildInfoSection(context),
          SizedBox(height: AppConfig.paddingLarge * 2),
        ],
      ),
    ),
  );
}

Widget _buildPlatformSection(BuildContext context, String platform, List<ParentalGuide> guides) {
  return Padding(
    padding: EdgeInsets.only(bottom: AppConfig.paddingMedium),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
          child: Text(
            guides.first.platformDisplayName,
            style: TextStyle(
              fontSize: AppConfig.fontSizeBody,
              fontWeight: FontWeight.bold,
              color: AppConfig.primaryColor,
            ),
          ),
        ),
        SizedBox(height: AppConfig.paddingSmall),
        ...guides.map((guide) => _buildGuideCard(context, guide)).toList(),
      ],
    ),
  );
}

  Widget _buildGuideCard(BuildContext context, ParentalGuide guide) {
  return Card(
    margin: EdgeInsets.symmetric(
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
        padding: EdgeInsets.all(AppConfig.paddingMedium),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: guide.type == 'enable' 
                    ? AppConfig.accentColor.withOpacity(0.1)
                    : AppConfig.errorColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConfig.borderRadiusSmall),
              ),
              child: Icon(
                guide.type == 'enable' ? Icons.lock : Icons.lock_open,
                size: 28,
                color: guide.type == 'enable' 
                    ? AppConfig.accentColor 
                    : AppConfig.errorColor,
              ),
            ),
            SizedBox(width: AppConfig.paddingMedium),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${guide.typeDisplayName} Control Parental',
                    style: TextStyle(
                      fontSize: AppConfig.fontSizeBody,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: AppConfig.paddingSmall / 2),
                  Text(
                    '${guide.steps.length} pasos',
                    style: TextStyle(
                      fontSize: AppConfig.fontSizeCaption,
                      color: AppConfig.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            
            Icon(
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
      padding: EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¿Por qué es importante?',
            style: TextStyle(
              fontSize: AppConfig.fontSizeHeading,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppConfig.paddingMedium),
          
          _buildInfoCard(
            icon: Icons.child_care,
            title: 'Protección infantil',
            description: 'Evita que tus hijos accedan a contenido no apropiado para su edad.',
          ),
          SizedBox(height: AppConfig.paddingSmall),
          
          _buildInfoCard(
            icon: Icons.schedule,
            title: 'Gestión del tiempo',
            description: 'Establece límites de tiempo de juego para mantener un equilibrio saludable.',
          ),
          SizedBox(height: AppConfig.paddingSmall),
          
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
      padding: EdgeInsets.all(AppConfig.paddingMedium),
      decoration: BoxDecoration(
        color: AppConfig.cardColor,
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
        border: Border.all(
          color: AppConfig.textSecondaryColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppConfig.primaryColor,
            size: 28,
          ),
          SizedBox(width: AppConfig.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: AppConfig.fontSizeBody,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppConfig.paddingSmall / 2),
                Text(
                  description,
                  style: TextStyle(
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

  IconData _getPlatformIcon(String platform) {
    switch (platform) {
      case 'playstation':
        return Icons.sports_esports;
      case 'xbox':
        return Icons.gamepad;
      case 'nintendo':
        return Icons.videogame_asset;
      case 'steam':
        return Icons.computer;
      default:
        return Icons.devices;
    }
  }

  Color _getPlatformColor(String platform) {
    switch (platform) {
      case 'playstation':
        return Colors.blue;
      case 'xbox':
        return Colors.green;
      case 'nintendo':
        return Colors.red;
      case 'steam':
        return Colors.indigo;
      default:
        return AppConfig.primaryColor;
    }
  }
}