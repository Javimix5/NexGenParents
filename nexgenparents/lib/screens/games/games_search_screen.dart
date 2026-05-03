import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/games_provider.dart';
import '../../models/game_filters.dart';
import '../../config/app_config.dart';
import '../../widgets/common/app_empty_state.dart';
import '../../l10n/app_localizations.dart';
import 'game_detail_screen.dart';
import 'games_filters_screen.dart';
import '../../widgets/common/app_footer.dart';

class GamesSearchScreen extends StatefulWidget {
  const GamesSearchScreen({super.key});

  @override
  State<GamesSearchScreen> createState() => _GamesSearchScreenState();
}

class _GamesSearchScreenState extends State<GamesSearchScreen> {
  final _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Cargar los juegos por defecto solo si no hay una lista precargada ni filtros.
      final gamesProvider = Provider.of<GamesProvider>(context, listen: false);
      if (gamesProvider.searchResults.isEmpty && !gamesProvider.currentFilters.hasActiveFilters) {
        if (gamesProvider.popularGames.isEmpty) {
          gamesProvider.loadNewGames();
        }
      }
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
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: Column(
        children: [
          // Barra de búsqueda y botón de filtros
          Padding(
            padding: const EdgeInsets.all(AppConfig.paddingMedium),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: l10n?.searchGamesHint ?? 'Buscar juego por nombre...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                                Provider.of<GamesProvider>(context,
                                        listen: false)
                                    .clearSearch();
                              },
                            )
                          : null,
                    ),
                    onChanged: (value) {
                      setState(() {});
                      if (value.isNotEmpty) {
                        Provider.of<GamesProvider>(context, listen: false)
                            .searchGames(value);
                      } else {
                        Provider.of<GamesProvider>(context, listen: false)
                            .clearSearch();
                      }
                    },
                  ),
                ),
                const SizedBox(width: AppConfig.paddingSmall),

                // Botón de filtros avanzados
                Consumer<GamesProvider>(
                  builder: (context, gamesProvider, child) {
                    final hasFilters =
                        gamesProvider.currentFilters.hasActiveFilters;

                    return Stack(
                      children: [
                        IconButton(
                          onPressed: () => _showFilters(context),
                          icon: const Icon(Icons.filter_list),
                          style: IconButton.styleFrom(
                            backgroundColor: hasFilters
                                ? AppConfig.primaryColor.withOpacity(0.1)
                                : null,
                          ),
                          tooltip: l10n?.searchGamesAdvancedFilters ?? 'Filtros avanzados',
                        ),
                        if (hasFilters)
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppConfig.accentColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          // Mensaje informativo
          Consumer<GamesProvider>(
            builder: (context, gamesProvider, child) {
              final filters = gamesProvider.currentFilters;
              
              final showMessage = _searchController.text.isEmpty &&
                  !filters.hasActiveFilters;

              if (!showMessage) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding: const EdgeInsets.fromLTRB(AppConfig.paddingMedium, 0,
                    AppConfig.paddingMedium, AppConfig.paddingSmall),
                child: Text(
                  l10n?.searchGamesShowingRecent ?? 'Mostrando los juegos más recientes del último año',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              );
            },
          ),

          // Chips de filtros activos
          Consumer<GamesProvider>(
            builder: (context, gamesProvider, child) {
              final filters = gamesProvider.currentFilters;
              
              if (!filters.hasActiveFilters) {
                return const SizedBox.shrink();
              }

              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConfig.paddingMedium),
                child: Wrap(
                  spacing: AppConfig.paddingSmall / 2,
                  children: [
                    if (filters.yearFrom != null)
                      Chip(
                        label: Text('${l10n?.searchGamesFilterFrom ?? "Desde"} ${filters.yearFrom}'),
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () {
                          final newFilters = filters.copyWith(yearFrom: null);
                          gamesProvider.searchWithFilters(newFilters);
                          setState(
                              () {}); // Forzar reconstrucción para actualizar los chips
                        },
                      ),
                    if (filters.yearTo != null)
                      Chip(
                        label: Text('${l10n?.searchGamesFilterTo ?? "Hasta"} ${filters.yearTo}'),
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () {
                          final newFilters = filters.copyWith(yearTo: null);
                          gamesProvider.searchWithFilters(newFilters);
                          setState(
                              () {}); // Forzar reconstrucción para actualizar los chips
                        },
                      ),
                    if (filters.pegiAge != null)
                      Chip(
                        label: Text('PEGI ${filters.pegiAge}+'),
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () {
                          final newFilters = filters.copyWith(pegiAge: null);
                          gamesProvider.searchWithFilters(newFilters);
                          setState(
                              () {}); // Forzar reconstrucción para actualizar los chips
                        },
                      ),
                    if (filters.selectedGenres.isNotEmpty)
                      Chip(
                        label:
                            Text('${filters.selectedGenres.length} ${l10n?.searchGamesFilterGenres ?? "género(s)"}'),
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () {
                          final newFilters =
                              filters.copyWith(selectedGenres: []);
                          gamesProvider.searchWithFilters(newFilters);
                          setState(
                              () {}); // Forzar reconstrucción para actualizar los chips
                        },
                      ),
                    if (filters.selectedPlatforms.isNotEmpty)
                      Chip(
                        label: Text(
                            '${filters.selectedPlatforms.length} ${l10n?.searchGamesFilterPlatforms ?? "plataforma(s)"}'),
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () {
                          final newFilters =
                              filters.copyWith(selectedPlatforms: []);
                          gamesProvider.searchWithFilters(newFilters);
                          setState(
                              () {}); // Forzar reconstrucción para actualizar los chips
                        },
                      ),

                    // Botón limpiar todos
                    ActionChip(
                      label: Text(l10n?.searchGamesClearAll ?? 'Limpiar todo'),
                      onPressed: () {
                        gamesProvider.clearFilters();
                        if (gamesProvider.popularGames.isEmpty) {
                          gamesProvider.loadNewGames();
                        }
                        _searchController.clear();
                        setState(() {});
                      },
                      avatar: const Icon(Icons.clear_all, size: 18),
                    ),
                  ],
                ),
              );
            },
          ),

          // Lista de juegos
          Expanded(
            child: Consumer<GamesProvider>(
              builder: (context, gamesProvider, child) {
                if (gamesProvider.isLoading || gamesProvider.isSearching) {
                  return const Center(child: CircularProgressIndicator());
                }

                final games = _searchController.text.isEmpty &&
                        !gamesProvider.currentFilters.hasActiveFilters
                    ? gamesProvider.popularGames
                    : gamesProvider.searchResults;

                if (games.isEmpty) {
                  return AppEmptyState(
                    icon: Icons.videogame_asset_off,
                    title: l10n?.searchGamesEmptyTitle ?? 'No se encontraron juegos',
                    message: l10n?.searchGamesEmptyMessage ?? 'Intenta ajustar los filtros o busca otro término',
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConfig.paddingMedium),
                  itemCount: games.length + 1,
                  itemBuilder: (context, index) {
                    if (index == games.length) {
                      return Padding(
                        padding: const EdgeInsets.only(top: AppConfig.paddingLarge, bottom: AppConfig.paddingLarge),
                      child: const AppFooter(),
                      );
                    }
                    final game = games[index];
                    return Card(
                      margin: const EdgeInsets.only(
                          bottom: AppConfig.paddingMedium),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => GameDetailScreen(
                                gameId: game.id,
                                gameName: game.name,
                              ),
                            ),
                          );
                        },
                        borderRadius:
                            BorderRadius.circular(AppConfig.borderRadiusMedium),
                        child: Padding(
                          padding:
                              const EdgeInsets.all(AppConfig.paddingMedium),
                          child: Row(
                            children: [
                              // Imagen del juego
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  AppConfig.borderRadiusSmall,
                                ),
                                child: game.backgroundImage != null
                                    ? Image.network(
                                        game.backgroundImage!,
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return _buildPlaceholderImage();
                                        },
                                      )
                                    : _buildPlaceholderImage(),
                              ),
                              const SizedBox(width: AppConfig.paddingMedium),

                              // Información del juego
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      game.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                        height: AppConfig.paddingSmall / 2),
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            size: 16, color: Colors.amber),
                                        const SizedBox(width: 4),
                                        Text('${game.rating}/5'),
                                      ],
                                    ),
                                    if (game.pegiRating != null) ...[
                                      const SizedBox(
                                          height: AppConfig.paddingSmall / 2),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: AppConfig.paddingSmall,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getPegiColor(game.pegiRating!)
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                            color:
                                                _getPegiColor(game.pegiRating!),
                                          ),
                                        ),
                                        child: Text(
                                          'PEGI ${game.pegiRating}+',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                _getPegiColor(game.pegiRating!),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),

                              const Icon(Icons.arrow_forward_ios, size: 16),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _showBackToTopButton
          ? FloatingActionButton.small(
              heroTag: 'games_search_back_to_top_btn',
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

  Widget _buildPlaceholderImage() {
    return Container(
      width: 80,
      height: 80,
      color: AppConfig.textSecondaryColor.withOpacity(0.1),
      child: const Icon(
        Icons.videogame_asset,
        color: AppConfig.textSecondaryColor,
      ),
    );
  }

  Color _getPegiColor(int rating) {
    if (rating <= 7) return Colors.green;
    if (rating <= 12) return Colors.blue;
    if (rating <= 16) return Colors.orange;
    return Colors.red;
  }

  Future<void> _showFilters(BuildContext context) async {
    final gamesProvider = Provider.of<GamesProvider>(context, listen: false);

    final result = await Navigator.of(context).push<GameFilters>(
      MaterialPageRoute(
        builder: (_) => GamesFiltersScreen(
          initialFilters: gamesProvider.currentFilters,
        ),
      ),
    );

    if (result != null) {
      // Aplicar filtros seleccionados
      final query = _searchController.text;
      final filtersWithQuery =
          result.copyWith(searchQuery: query.isNotEmpty ? query : null);
      gamesProvider.searchWithFilters(filtersWithQuery);
    }
  }
}
