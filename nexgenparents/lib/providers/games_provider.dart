import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/rawg_service.dart';
import '../models/game_model.dart';
import '../models/game_filters.dart';

class GamesProvider with ChangeNotifier {
  static const String _favoritesStorageKey = 'games_favorite_items';
  static const String _filtersStorageKey = 'games_last_filters';

  final RawgService _rawgService;

  GamesProvider({RawgService? rawgService})
      : _rawgService = rawgService ?? RawgService() {
    _restoreLocalState();
  }

  List<Game> _popularGames = [];
  List<Game> _searchResults = [];
  List<Game> _gamesByAge = [];
  List<Game> _favoriteGames = [];

  Game? _selectedGame;
  List<String> _selectedGameScreenshots = [];

  bool _isLoading = false;
  bool _isSearching = false;
  bool _isLoadingDetails = false;
  String? _errorMessage;

  // Getters
  List<Game> get popularGames => _popularGames;
  List<Game> get searchResults => _searchResults;
  List<Game> get gamesByAge => _gamesByAge;
  List<Game> get favoriteGames => _favoriteGames;
  Game? get selectedGame => _selectedGame;
  List<String> get selectedGameScreenshots => _selectedGameScreenshots;
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  bool get isLoadingDetails => _isLoadingDetails;
  String? get errorMessage => _errorMessage;

  // Cargar juegos populares al iniciar
  Future<void> loadPopularGames() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _popularGames = await _rawgService.getPopularGames();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error al cargar juegos populares';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Buscar juegos por nombre (filtrado por nombre) [1]
  Future<void> searchGames(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      _isSearching = false;
      notifyListeners();
      return;
    }

    _isSearching = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _searchResults = await _rawgService.searchGames(query);
      _isSearching = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error al buscar juegos';
      _isSearching = false;
      notifyListeners();
    }
  }

  // Buscar juegos por edad recomendada (filtrado por edad) [1]
  Future<void> searchGamesByAge(int age) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _gamesByAge = await _rawgService.getGamesByAge(age);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error al buscar juegos por edad';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Obtener detalles completos de un juego (sinopsis y advertencias) [1]
  Future<void> loadGameDetails(int gameId) async {
    _isLoadingDetails = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _selectedGame = await _rawgService.getGameDetails(gameId);
      
      // Cargar screenshots del juego
      if (_selectedGame != null) {
        _selectedGameScreenshots = await _rawgService.getGameScreenshots(gameId);
      }
      
      _isLoadingDetails = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error al cargar detalles del juego';
      _isLoadingDetails = false;
      notifyListeners();
    }
  }

  // Limpiar búsqueda
  void clearSearch() {
    _searchResults = [];
    _isSearching = false;
    notifyListeners();
  }

  // Limpiar filtro por edad
  void clearAgeFilter() {
    _gamesByAge = [];
    notifyListeners();
  }

  // Añadir juego a favoritos (local)
  void addToFavorites(Game game) {
    if (!_favoriteGames.any((g) => g.id == game.id)) {
      _favoriteGames.add(game);
      _saveFavorites();
      notifyListeners();
    }
  }

  // Eliminar juego de favoritos
  void removeFromFavorites(int gameId) {
    _favoriteGames.removeWhere((game) => game.id == gameId);
    _saveFavorites();
    notifyListeners();
  }

  // Verificar si un juego está en favoritos
  bool isFavorite(int gameId) {
    return _favoriteGames.any((game) => game.id == gameId);
  }

  // Obtener juegos por género
  Future<void> loadGamesByGenre(String genre) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _searchResults = await _rawgService.getGamesByGenre(genre);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error al cargar juegos por género';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Obtener juegos por plataforma
  Future<void> loadGamesByPlatform(int platformId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _searchResults = await _rawgService.getGamesByPlatform(platformId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error al cargar juegos por plataforma';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Obtener juegos nuevos/recientes
  Future<void> loadNewGames() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _popularGames = await _rawgService.getNewGames();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error al cargar juegos nuevos';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Verificar si un juego es apropiado para una edad
  bool isGameAppropriateForAge(Game game, int childAge) {
    return game.isAppropriateForAge(childAge);
  }

  // Obtener texto de advertencia para los padres
  String getAgeWarningForGame(Game game, int childAge) {
    return game.getAgeWarning(childAge);
  }

  // Limpiar mensaje de error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Limpiar juego seleccionado
  void clearSelectedGame() {
    _selectedGame = null;
    _selectedGameScreenshots = [];
    notifyListeners();
  }

  GameFilters _currentFilters = GameFilters();
List<String> _availableGenres = [];

GameFilters get currentFilters => _currentFilters;
List<String> get availableGenres => _availableGenres;

// Cargar géneros disponibles desde la API
Future<void> loadGenres() async {
  try {
    final genres = await _rawgService.getGenres();
    _availableGenres = genres.map((g) => g['slug'] as String).toList();
    notifyListeners();
  } catch (e) {
    print('Error al cargar géneros: $e');
  }
}

// Buscar con filtros avanzados (nombre, año, género, plataforma, edad) [1]
Future<void> searchWithFilters(GameFilters filters) async {
  _isSearching = true;
  _currentFilters = filters;
  _saveFilters();
  _errorMessage = null;
  notifyListeners();

  try {
    _searchResults = await _rawgService.searchGamesWithFilters(
      query: filters.searchQuery,
      yearFrom: filters.yearFrom,
      yearTo: filters.yearTo,
      genres: filters.selectedGenres,
      platforms: filters.selectedPlatforms,
      pegiAge: filters.pegiAge,
      ordering: filters.ordering,
    );
    _isSearching = false;
    notifyListeners();
  } catch (e) {
    _errorMessage = 'Error al buscar juegos con filtros';
    _isSearching = false;
    notifyListeners();
  }
}

// Limpiar todos los filtros
void clearFilters() {
  _currentFilters = GameFilters();
  _searchResults = [];
  _saveFilters();
  notifyListeners();
}

// Aplicar filtro rápido por edad PEGI (mantiene otros filtros activos)
void applyPegiFilter(int age) {
  _currentFilters = _currentFilters.copyWith(pegiAge: age);
  _saveFilters();
  searchWithFilters(_currentFilters);
}

  Future<void> _restoreLocalState() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final favoriteItems = prefs.getStringList(_favoritesStorageKey) ?? [];
      _favoriteGames = favoriteItems
          .map((item) => Game.fromJson(json.decode(item) as Map<String, dynamic>))
          .toList();

      final storedFilters = prefs.getString(_filtersStorageKey);
      if (storedFilters != null && storedFilters.isNotEmpty) {
        _currentFilters = GameFilters.fromJson(
          json.decode(storedFilters) as Map<String, dynamic>,
        );
      }

      notifyListeners();
    } catch (e) {
      _errorMessage = 'No se pudieron restaurar favoritos y filtros locales';
      notifyListeners();
    }
  }

  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final payload = _favoriteGames
          .map((game) => json.encode(game.toJson()))
          .toList();
      await prefs.setStringList(_favoritesStorageKey, payload);
    } catch (e) {
      _errorMessage = 'No se pudieron guardar los favoritos';
      notifyListeners();
    }
  }

  Future<void> _saveFilters() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _filtersStorageKey,
        json.encode(_currentFilters.toJson()),
      );
    } catch (e) {
      _errorMessage = 'No se pudieron guardar los filtros';
      notifyListeners();
    }
  }
}