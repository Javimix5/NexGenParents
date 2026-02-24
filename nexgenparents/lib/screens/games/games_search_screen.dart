import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/games_provider.dart';
import '../../config/app_config.dart';
import 'game_detail_screen.dart';

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
    // Cargar juegos populares al inicio
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
          // Barra de búsqueda
          Padding(
            padding: EdgeInsets.all(AppConfig.paddingMedium),
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
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {});
                if (value.isNotEmpty) {
                  Provider.of<GamesProvider>(context, listen: false)
                      .searchGames(value);
                }
              },
            ),
          ),
          
          // Lista de juegos
          Expanded(
            child: Consumer<GamesProvider>(
              builder: (context, gamesProvider, child) {
                if (gamesProvider.isLoading || gamesProvider.isSearching) {
                  return Center(child: CircularProgressIndicator());
                }

                final games = _searchController.text.isEmpty
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
                            'Intenta con otro término de búsqueda',
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
                      child: ListTile(
                        leading: game.backgroundImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  AppConfig.borderRadiusSmall,
                                ),
                                child: Image.network(
                                  game.backgroundImage!,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 60,
                                      height: 60,
                                      color: AppConfig.textSecondaryColor,
                                      child: Icon(Icons.videogame_asset),
                                    );
                                  },
                                ),
                              )
                            : Container(
                                width: 60,
                                height: 60,
                                color: AppConfig.textSecondaryColor,
                                child: Icon(Icons.videogame_asset),
                              ),
                        title: Text(
                          game.name,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rating: ${game.rating}/5'),
                            if (game.pegiRating != null)
                              Text('PEGI: ${game.pegiRating}+'),
                          ],
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
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
}