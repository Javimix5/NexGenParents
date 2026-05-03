import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/games_provider.dart';
import '../../models/game_model.dart';
import '../../config/app_config.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/common/app_footer.dart';

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
                    
                    const SizedBox(height: AppConfig.paddingLarge),
                    const AppFooter(),
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
        titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        title: Text(
          game.name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: const Offset(0, 2),
                blurRadius: 6.0,
                color: Colors.black.withOpacity(0.8),
              ),
            ],
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (game.backgroundImage != null)
              CachedNetworkImage(
                imageUrl: game.backgroundImage!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: AppConfig.backgroundDark),
                errorWidget: (context, url, error) => Container(color: AppConfig.backgroundDark),
              )
            else
              Container(color: AppConfig.backgroundDark),
            // Gradiente suave desde transparente hasta negro
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.9)],
                  stops: const [0.4, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfo(Game game) {
    final l10n = AppLocalizations.of(context);
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
                  l10n?.gameDetailRelease(game.released!) ?? 'Lanzamiento: ${game.released}',
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
    final l10n = AppLocalizations.of(context);
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConfig.paddingMedium),
      color: pegi != null
          ? _getPegiColor(pegi).withOpacity(0.1)
          : AppConfig.backgroundLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n?.gameDetailPegiTitle ?? 'Clasificación por edad (PEGI)',
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
                    color: _getPegiColor(pegi),
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
                      l10n?.gameDetailPegiWarning(pegi) ?? 'Recomendado para mayores de $pegi años',
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
              l10n?.gameDetailPegiNotAvailable ?? 'No hay información de clasificación PEGI disponible',
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
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n?.gameDetailDescriptionTitle ?? 'Descripción del juego',
            style: TextStyle(
              fontSize: AppConfig.fontSizeHeading,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          Text(
            game.description ?? (l10n?.gameDetailDescriptionEmpty ?? 'No hay descripción disponible'),
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
    final l10n = AppLocalizations.of(context);
    if (game.genres.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n?.gameDetailGenresTitle ?? 'Géneros',
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
    final l10n = AppLocalizations.of(context);
    if (game.platforms.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n?.gameDetailPlatformsTitle ?? 'Plataformas disponibles',
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
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n?.gameDetailScreenshotsTitle ?? 'Capturas de pantalla',
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

  Color _getPegiColor(int rating) {
    if (rating <= 7) return Colors.green;
    if (rating <= 12) return Colors.blue;
    if (rating <= 16) return Colors.orange;
    return Colors.red;
  }

  String _getPegiDescription(BuildContext context, int pegi) {
    final l10n = AppLocalizations.of(context);
    switch (pegi) {
      case 3:
        return l10n?.pegiDescription3 ?? 'Contenido apropiado para todas las edades.';
      case 7:
        return l10n?.pegiDescription7 ?? 'Puede contener escenas o sonidos que asusten a niños pequeños.';
      case 12:
        return l10n?.pegiDescription12 ?? 'Puede incluir violencia no realista.';
      case 16:
        return l10n?.pegiDescription16 ?? 'Puede contener violencia realista, lenguaje fuerte o contenido sexual leve.';
      case 18:
        return l10n?.pegiDescription18 ?? 'Contenido para adultos. Puede incluir violencia intensa, lenguaje fuerte, contenido sexual explícito o uso de drogas.';
      default:
        return l10n?.pegiDescriptionUnknown ?? 'No hay una descripción disponible para esta clasificación PEGI.';
    }
  }
}