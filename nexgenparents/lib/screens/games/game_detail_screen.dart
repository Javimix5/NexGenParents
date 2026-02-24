import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/games_provider.dart';
import '../../models/game_model.dart';
import '../../config/app_config.dart';
import '../../config/app_theme.dart';

class GameDetailScreen extends StatefulWidget {
  final int gameId;
  final String gameName;

  const GameDetailScreen({
    super.key,
    required this.gameId,
    required this.gameName,
  });

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar detalles del juego
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GamesProvider>(context, listen: false)
          .loadGameDetails(widget.gameId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GamesProvider>(
        builder: (context, gamesProvider, child) {
          if (gamesProvider.isLoadingDetails) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: AppConfig.paddingMedium),
                  Text('Cargando información del juego...'),
                ],
              ),
            );
          }

          final game = gamesProvider.selectedGame;

          if (game == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 60,
                    color: AppConfig.errorColor,
                  ),
                  SizedBox(height: AppConfig.paddingMedium),
                  Text('No se pudo cargar la información del juego'),
                  SizedBox(height: AppConfig.paddingMedium),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Volver'),
                  ),
                ],
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              // AppBar con imagen de fondo
              _buildAppBar(game),
              
              // Contenido principal
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Información básica
                    _buildBasicInfo(game),
                    
                    Divider(height: 1),
                    
                    // Clasificación PEGI y advertencias
                    _buildPegiSection(game),
                    
                    Divider(height: 1),
                    
                    // Descripción/Sinopsis [1]
                    _buildDescriptionSection(game),
                    
                    // Géneros
                    _buildGenresSection(game),
                    
                    // Plataformas
                    _buildPlatformsSection(game),
                    
                    // Screenshots
                    if (gamesProvider.selectedGameScreenshots.isNotEmpty)
                      _buildScreenshotsSection(gamesProvider.selectedGameScreenshots),
                    
                    SizedBox(height: AppConfig.paddingLarge * 2),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar(Game game) {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Container(
  padding: EdgeInsets.symmetric(
    horizontal: AppConfig.paddingSmall,
    vertical: AppConfig.paddingSmall / 2,
  ),
  decoration: BoxDecoration(
    color: Colors.black.withOpacity(0.7),
    borderRadius: BorderRadius.circular(AppConfig.borderRadiusSmall),
  ),
  child: Text(
    game.name,
    style: TextStyle(
      fontSize: AppConfig.fontSizeBody,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      shadows: [
        Shadow(
          offset: Offset(0, 1),
          blurRadius: 3.0,
          color: Colors.black.withOpacity(0.8),
        ),
      ],
    ),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
  ),
),
        background: game.backgroundImage != null
            ? CachedNetworkImage(
                imageUrl: game.backgroundImage!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppConfig.textSecondaryColor,
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppConfig.textSecondaryColor,
                  child: Icon(Icons.videogame_asset, size: 60),
                ),
              )
            : Container(
                color: AppConfig.textSecondaryColor,
                child: Icon(Icons.videogame_asset, size: 60, color: Colors.white),
              ),
      ),
    );
  }

  Widget _buildBasicInfo(Game game) {
    return Padding(
      padding: EdgeInsets.all(AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Rating
              Icon(Icons.star, color: Colors.amber, size: 24),
              SizedBox(width: AppConfig.paddingSmall / 2),
              Text(
                '${game.rating}/5',
                style: TextStyle(
                  fontSize: AppConfig.fontSizeHeading,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: AppConfig.paddingMedium),
              
              // Metacritic
              if (game.metacritic != null) ...[
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppConfig.paddingSmall,
                    vertical: AppConfig.paddingSmall / 2,
                  ),
                  decoration: BoxDecoration(
                    color: _getMetacriticColor(game.metacritic!),
                    borderRadius: BorderRadius.circular(AppConfig.borderRadiusSmall),
                  ),
                  child: Text(
                    'Metacritic: ${game.metacritic}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
          
          if (game.released != null) ...[
            SizedBox(height: AppConfig.paddingSmall),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: AppConfig.textSecondaryColor),
                SizedBox(width: AppConfig.paddingSmall / 2),
                Text(
                  'Lanzamiento: ${game.released}',
                  style: TextStyle(color: AppConfig.textSecondaryColor),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPegiSection(Game game) {
    final pegi = game.pegiRating;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppConfig.paddingMedium),
      color: pegi != null
          ? AppTheme.getPegiColor(pegi).withOpacity(0.1)
          : AppConfig.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Clasificación por edad (PEGI)',
            style: TextStyle(
              fontSize: AppConfig.fontSizeHeading,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppConfig.paddingSmall),
          
          if (pegi != null) ...[
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppTheme.getPegiColor(pegi),
                    borderRadius: BorderRadius.circular(AppConfig.borderRadiusSmall),
                  ),
                  child: Center(
                    child: Text(
                      'PEGI\n$pegi+',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: AppConfig.fontSizeBody,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: AppConfig.paddingMedium),
                Expanded(
                  child: Text(
                    _getPegiDescription(pegi),
                    style: TextStyle(fontSize: AppConfig.fontSizeBody),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppConfig.paddingMedium),
            
            // Advertencia para padres
            Container(
              padding: EdgeInsets.all(AppConfig.paddingMedium),
              decoration: BoxDecoration(
                color: AppConfig.warningColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
                border: Border.all(color: AppConfig.warningColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: AppConfig.warningColor),
                  SizedBox(width: AppConfig.paddingSmall),
                  Expanded(
                    child: Text(
                      'Recomendado para mayores de $pegi años',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppConfig.fontSizeBody,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            Text(
              'No hay información de clasificación PEGI disponible',
              style: TextStyle(
                color: AppConfig.textSecondaryColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(Game game) {
    return Padding(
      padding: EdgeInsets.all(AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Descripción del juego',
            style: TextStyle(
              fontSize: AppConfig.fontSizeHeading,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppConfig.paddingSmall),
          Text(
            game.description ?? 'No hay descripción disponible',
            style: TextStyle(
              fontSize: AppConfig.fontSizeBody,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenresSection(Game game) {
    if (game.genres.isEmpty) return SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Géneros',
            style: TextStyle(
              fontSize: AppConfig.fontSizeHeading,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppConfig.paddingSmall),
          Wrap(
            spacing: AppConfig.paddingSmall,
            runSpacing: AppConfig.paddingSmall,
            children: game.genres.map((genre) {
              return Chip(
                label: Text(genre),
                backgroundColor: AppConfig.primaryColor.withOpacity(0.1),
              );
            }).toList(),
          ),
          SizedBox(height: AppConfig.paddingMedium),
        ],
      ),
    );
  }

  Widget _buildPlatformsSection(Game game) {
    if (game.platforms.isEmpty) return SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Plataformas disponibles',
            style: TextStyle(
              fontSize: AppConfig.fontSizeHeading,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppConfig.paddingSmall),
          Wrap(
            spacing: AppConfig.paddingSmall,
            runSpacing: AppConfig.paddingSmall,
            children: game.platforms.map((platform) {
              return Chip(
                label: Text(platform),
                avatar: Icon(Icons.devices, size: 16),
              );
            }).toList(),
          ),
          SizedBox(height: AppConfig.paddingMedium),
        ],
      ),
    );
  }

  Widget _buildScreenshotsSection(List<String> screenshots) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Capturas de pantalla',
            style: TextStyle(
              fontSize: AppConfig.fontSizeHeading,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppConfig.paddingSmall),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: screenshots.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: AppConfig.paddingSmall),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
                    child: CachedNetworkImage(
                      imageUrl: screenshots[index],
                      width: 250,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 250,
                        color: AppConfig.textSecondaryColor,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 250,
                        color: AppConfig.textSecondaryColor,
                        child: Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getMetacriticColor(int score) {
    if (score >= 75) return Colors.green;
    if (score >= 50) return Colors.orange;
    return Colors.red;
  }

  String _getPegiDescription(int pegi) {
    switch (pegi) {
      case 3:
        return 'Contenido apropiado para todas las edades. Sin violencia ni lenguaje inapropiado.';
      case 7:
        return 'Puede contener escenas o sonidos que asusten a niños pequeños.';
      case 12:
        return 'Puede incluir violencia no realista hacia personajes de fantasía o violencia realista leve.';
        case 16:
        return 'Puede contener violencia realista, lenguaje fuerte o contenido sexual leve.';
        case 18:
        return 'Contenido para adultos. Puede incluir violencia intensa, lenguaje fuerte, contenido sexual explícito o uso de drogas.';
        default:
        return 'No hay una descripción disponible para esta clasificación PEGI.';
    }
  }
}