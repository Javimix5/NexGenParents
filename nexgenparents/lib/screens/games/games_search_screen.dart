import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/games_provider.dart';
import '../../models/game_filters.dart';
import '../../config/app_config.dart';
import 'game_detail_screen.dart';
import 'games_filters_screen.dart';

class GamesSearchScreen extends StatefulWidget {
  const GamesSearchScreen({super.key});

  @override
  State<GamesSearchScreen> createState() => _GamesSearchScreenState();
}

class _GamesSearchScreenState extends State<GamesSearchScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GamesProvider>(context, listen: false).loadPopularGames();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Videojuegos'),
      ),
      body: Column(
        children: [
          // Barra de búsqueda y botón de filtros
          Padding(
            padding: EdgeInsets.all(AppConfig.paddingMedium),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar juego por nombre...',
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                                Provider.of<GamesProvider>(context, listen: false)
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
                SizedBox(width: AppConfig.paddingSmall),
                
                // Botón de filtros avanzados
                Consumer<GamesProvider>(
                  builder: (context, gamesProvider, child) {
                    final hasFilters = gamesProvider.currentFilters.hasActiveFilters;
                    
                    return Stack(
                      children: [
                        IconButton(
                          onPressed: () => _showFilters(context),
                          icon: Icon(Icons.filter_list),
                          style: IconButton.styleFrom(
                            backgroundColor: hasFilters 
                                ? AppConfig.primaryColor.withOpacity(0.1)
                                : null,
                          ),
                          tooltip: 'Filtros avanzados',
                        ),
                        if (hasFilters)
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
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

          // Chips de filtros activos
          Consumer<GamesProvider>(
            builder: (context, gamesProvider, child) {
              final filters = gamesProvider.currentFilters;
              
              if (!filters.hasActiveFilters) {
                return SizedBox.shrink();
              }

              return Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
                child: Wrap(
                  spacing: AppConfig.paddingSmall / 2,
                  children: [
                    if (filters.yearFrom != null)
                      Chip(
                        label: Text('Desde ${filters.yearFrom}'),
                        deleteIcon: Icon(Icons.close, size: 18),
                        onDeleted: () {
                          final newFilters = filters.copyWith(yearFrom: null);
                          gamesProvider.searchWithFilters(newFilters);
                        },
                      ),
                    if (filters.yearTo != null)
                      Chip(
                        label: Text('Hasta ${filters.yearTo}'),
                        deleteIcon: Icon(Icons.close, size: 18),
                        onDeleted: () {
                          final newFilters = filters.copyWith(yearTo: null);
                          gamesProvider.searchWithFilters(newFilters);
                        },
                      ),
                    if (filters.pegiAge != null)
                      Chip(
                        label: Text('PEGI ${filters.pegiAge}+'),
                        deleteIcon: Icon(Icons.close, size: 18),
                        onDeleted: () {
                          final newFilters = filters.copyWith(pegiAge: null);
                          gamesProvider.searchWithFilters(newFilters);
                        },
                      ),
                    if (filters.selectedGenres.isNotEmpty)
                      Chip(
                        label: Text('${filters.selectedGenres.length} género(s)'),
                        deleteIcon: Icon(Icons.close, size: 18),
                        onDeleted: () {
                          final newFilters = filters.copyWith(selectedGenres: []);
                          gamesProvider.searchWithFilters(newFilters);
                        },
                      ),
                    if (filters.selectedPlatforms.isNotEmpty)
                      Chip(
                        label: Text('${filters.selectedPlatforms.length} plataforma(s)'),
                        deleteIcon: Icon(Icons.close, size: 18),
                        onDeleted: () {
                          final newFilters = filters.copyWith(selectedPlatforms: []);
                          gamesProvider.searchWithFilters(newFilters);
                        },
                      ),
                    
                    // Botón limpiar todos
                    ActionChip(
                      label: Text('Limpiar todo'),
                      onPressed: () {
                        gamesProvider.clearFilters();
                        _searchController.clear();
                        setState(() {});
                      },
                      avatar: Icon(Icons.clear_all, size: 18),
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
                  return Center(child: CircularProgressIndicator());
                }

                final games = _searchController.text.isEmpty && 
                              !gamesProvider.currentFilters.hasActiveFilters
                    ? gamesProvider.popularGames
                    : gamesProvider.searchResults;

                if (games.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(AppConfig.paddingLarge),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.videogame_asset_off,
                            size: 80,
                            color: AppConfig.textSecondaryColor,
                          ),
                          SizedBox(height: AppConfig.paddingMedium),
                          Text(
                            'No se encontraron juegos',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          SizedBox(height: AppConfig.paddingSmall),
                          Text(
                            'Intenta ajustar los filtros o busca otro término',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
                  itemCount: games.length,
                  itemBuilder: (context, index) {
                    final game = games[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: AppConfig.paddingMedium),
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
                        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
                        child: Padding(
                          padding: EdgeInsets.all(AppConfig.paddingMedium),
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
                                        errorBuilder: (context, error, stackTrace) {
                                          return _buildPlaceholderImage();
                                        },
                                      )
                                    : _buildPlaceholderImage(),
                              ),
                              SizedBox(width: AppConfig.paddingMedium),
                              
                              // Información del juego
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      game.name,
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: AppConfig.paddingSmall / 2),
                                    Row(
                                      children: [
                                        Icon(Icons.star, size: 16, color: Colors.amber),
                                        SizedBox(width: 4),
                                        Text('${game.rating}/5'),
                                      ],
                                    ),
                                    if (game.pegiRating != null) ...[
                                      SizedBox(height: AppConfig.paddingSmall / 2),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: AppConfig.paddingSmall,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getPegiColor(game.pegiRating!)
                                              .withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(4),
                                          border: Border.all(
                                            color: _getPegiColor(game.pegiRating!),
                                          ),
                                        ),
                                        child: Text(
                                          'PEGI ${game.pegiRating}+',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: _getPegiColor(game.pegiRating!),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              
                              Icon(Icons.arrow_forward_ios, size: 16),
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
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: 80,
      height: 80,
      color: AppConfig.textSecondaryColor.withOpacity(0.1),
      child: Icon(
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
      final filtersWithQuery = result.copyWith(searchQuery: query.isNotEmpty ? query : null);
      gamesProvider.searchWithFilters(filtersWithQuery);
    }
  }
}