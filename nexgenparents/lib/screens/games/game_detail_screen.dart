import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/games_provider.dart';
import '../../models/game_model.dart';
import '../../config/app_config.dart';
import '../../config/app_theme.dart';
import '../../l10n/app_localizations.dart';

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
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    // Cargar detalles del juego
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GamesProvider>(context, listen: false)
          .loadGameDetails(widget.gameId);
    });
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
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: Consumer<GamesProvider>(
        builder: (context, gamesProvider, child) {
          if (gamesProvider.isLoadingDetails) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: AppConfig.paddingMedium),
                  Text(l10n?.gameDetailLoading ?? 'Cargando información del juego...'),
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
                  const Icon(
                    Icons.error_outline,
                    size: 60,
                    color: AppConfig.errorColor,
                  ),
                  const SizedBox(height: AppConfig.paddingMedium),
                  Text(l10n?.gameDetailError ?? 'No se pudo cargar la información del juego'),
                  const SizedBox(height: AppConfig.paddingMedium),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(l10n?.gameDetailBackBtn ?? 'Volver'),
                  ),
                ],
              ),
            );
          }

          return CustomScrollView(
            controller: _scrollController,
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
                    
                    const Divider(height: 1),
                    
                    // Clasificación PEGI y advertencias
                    _buildPegiSection(game),
                    
                    const Divider(height: 1),
                    
                    // Descripción/Sinopsis [1]
                    _buildDescriptionSection(game),
                    
                    // Géneros
                    _buildGenresSection(game),
                    
                    // Plataformas
                    _buildPlatformsSection(game),
                    
                    // Screenshots
                    if (gamesProvider.selectedGameScreenshots.isNotEmpty)
                      _buildScreenshotsSection(gamesProvider.selectedGameScreenshots),
                    
                    const SizedBox(height: AppConfig.paddingLarge * 2),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: _showBackToTopButton
          ? FloatingActionButton.small(
              heroTag: 'game_detail_back_to_top_btn',
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

  Widget _buildAppBar(Game game) {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Container(
  padding: const EdgeInsets.symmetric(
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
          offset: const Offset(0, 1),
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
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppConfig.textSecondaryColor,
                  child: const Icon(Icons.videogame_asset, size: 60),
                ),
              )
            : Container(
                color: AppConfig.textSecondaryColor,
                child: const Icon(Icons.videogame_asset, size: 60, color: Colors.white),
              ),
      ),
    );
  }

  Widget _buildBasicInfo(Game game) {
    return Padding(
      padding: const EdgeInsets.all(AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Rating
              const Icon(Icons.star, color: Colors.amber, size: 24),
              const SizedBox(width: AppConfig.paddingSmall / 2),
              Text(
                '${game.rating}/5',
                style: const TextStyle(
                  fontSize: AppConfig.fontSizeHeading,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: AppConfig.paddingMedium),
              
              // Metacritic
              if (game.metacritic != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConfig.paddingSmall,
                    vertical: AppConfig.paddingSmall / 2,
                  ),
                  decoration: BoxDecoration(
                    color: _getMetacriticColor(game.metacritic!),
                    borderRadius: BorderRadius.circular(AppConfig.borderRadiusSmall),
                  ),
                  child: Text(
                    'Metacritic: ${game.metacritic}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
          
          if (game.released != null) ...[
            const SizedBox(height: AppConfig.paddingSmall),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: AppConfig.textSecondaryColor),
                const SizedBox(width: AppConfig.paddingSmall / 2),
                Text(
                  _t(context, es: 'Lanzamiento: ${game.released}', gl: 'Lanzamento: ${game.released}', en: 'Release: ${game.released}'),
                  style: const TextStyle(color: AppConfig.textSecondaryColor),
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
      padding: const EdgeInsets.all(AppConfig.paddingMedium),
      color: pegi != null
          ? AppTheme.getPegiColor(pegi).withOpacity(0.1)
          : AppConfig.backgroundLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _t(context, es: 'Clasificación por edad (PEGI)', gl: 'Clasificación por idade (PEGI)', en: 'Age rating (PEGI)'),
            style: TextStyle(
              fontSize: AppConfig.fontSizeHeading,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          
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
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: AppConfig.fontSizeBody,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppConfig.paddingMedium),
                Expanded(
                  child: Text(
                    _getPegiDescription(context, pegi),
                    style: const TextStyle(fontSize: AppConfig.fontSizeBody),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConfig.paddingMedium),
            
            // Advertencia para padres
            Container(
              padding: const EdgeInsets.all(AppConfig.paddingMedium),
              decoration: BoxDecoration(
                color: AppConfig.warningColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
                border: Border.all(color: AppConfig.warningColor),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: AppConfig.warningColor),
                  const SizedBox(width: AppConfig.paddingSmall),
                  Expanded(
                    child: Text(
                      _t(context, es: 'Recomendado para mayores de $pegi años', gl: 'Recomendado para maiores de $pegi anos', en: 'Recommended for ages $pegi and up'),
                      style: const TextStyle(
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
              _t(context, es: 'No hay información de clasificación PEGI disponible', gl: 'Non hai información de clasificación PEGI dispoñible', en: 'No PEGI rating information available'),
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
      padding: const EdgeInsets.all(AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _t(context, es: 'Descripción del juego', gl: 'Descrición do xogo', en: 'Game description'),
            style: TextStyle(
              fontSize: AppConfig.fontSizeHeading,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          Text(
            game.description ?? _t(context, es: 'No hay descripción disponible', gl: 'Non hai descrición dispoñible', en: 'No description available'),
            style: const TextStyle(
              fontSize: AppConfig.fontSizeBody,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenresSection(Game game) {
    if (game.genres.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _t(context, es: 'Géneros', gl: 'Xéneros', en: 'Genres'),
            style: TextStyle(
              fontSize: AppConfig.fontSizeHeading,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConfig.paddingSmall),
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
          const SizedBox(height: AppConfig.paddingMedium),
        ],
      ),
    );
  }

  Widget _buildPlatformsSection(Game game) {
    if (game.platforms.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _t(context, es: 'Plataformas disponibles', gl: 'Plataformas dispoñibles', en: 'Available platforms'),
            style: TextStyle(
              fontSize: AppConfig.fontSizeHeading,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          Wrap(
            spacing: AppConfig.paddingSmall,
            runSpacing: AppConfig.paddingSmall,
            children: game.platforms.map((platform) {
              return Chip(
                label: Text(platform),
                avatar: const Icon(Icons.devices, size: 16),
              );
            }).toList(),
          ),
          const SizedBox(height: AppConfig.paddingMedium),
        ],
      ),
    );
  }

  Widget _buildScreenshotsSection(List<String> screenshots) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _t(context, es: 'Capturas de pantalla', gl: 'Capturas de pantalla', en: 'Screenshots'),
            style: TextStyle(
              fontSize: AppConfig.fontSizeHeading,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: screenshots.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: AppConfig.paddingSmall),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
                    child: CachedNetworkImage(
                      imageUrl: screenshots[index],
                      width: 250,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 250,
                        color: AppConfig.textSecondaryColor,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 250,
                        color: AppConfig.textSecondaryColor,
                        child: const Icon(Icons.error),
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

  String _getPegiDescription(BuildContext context, int pegi) {
    switch (pegi) {
      case 3:
        return _t(context, es: 'Contenido apropiado para todas las edades. Sin violencia ni lenguaje inapropiado.', gl: 'Contido apropiado para todas as idades. Sen violencia nin linguaxe inapropiada.', en: 'Content suitable for all ages. No violence or inappropriate language.');
      case 7:
        return _t(context, es: 'Puede contener escenas o sonidos que asusten a niños pequeños.', gl: 'Pode conter escenas ou sons que asusten a nenos pequenos.', en: 'May contain scenes or sounds that can frighten young children.');
      case 12:
        return _t(context, es: 'Puede incluir violencia no realista hacia personajes de fantasía o violencia realista leve.', gl: 'Pode incluír violencia non realista cara a personaxes de fantasía ou violencia realista leve.', en: 'May include non-realistic violence towards fantasy characters or mild realistic violence.');
      case 16:
        return _t(context, es: 'Puede contener violencia realista, lenguaje fuerte o contenido sexual leve.', gl: 'Pode conter violencia realista, linguaxe forte ou contido sexual leve.', en: 'May contain realistic violence, strong language or mild sexual content.');
      case 18:
        return _t(context, es: 'Contenido para adultos. Puede incluir violencia intensa, lenguaje fuerte, contenido sexual explícito o uso de drogas.', gl: 'Contido para adultos. Pode incluír violencia intensa, linguaxe forte, contido sexual explícito ou uso de drogas.', en: 'Adult content. May include intense violence, strong language, explicit sexual content, or drug use.');
      default:
        return _t(context, es: 'No hay una descripción disponible para esta clasificación PEGI.', gl: 'Non hai unha descrición dispoñible para esta clasificación PEGI.', en: 'No description available for this PEGI rating.');
    }
  }

  String _t(BuildContext context, {required String es, required String gl, required String en}) {
    switch (Localizations.localeOf(context).languageCode) {
      case 'gl':
        return gl;
      case 'en':
        return en;
      default:
        return es;
    }
  }
}