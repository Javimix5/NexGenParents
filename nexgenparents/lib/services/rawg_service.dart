import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/game_model.dart';
import '../config/app_config.dart';

class RawgService {
  final http.Client _httpClient;
  final Duration _requestTimeout;
  final String _baseUrl = AppConfig.rawgBaseUrl;
  final String _apiKey = AppConfig.rawgApiKey;

  RawgService({
    http.Client? httpClient,
    Duration requestTimeout = const Duration(seconds: 12),
  })  : _httpClient = httpClient ?? http.Client(),
        _requestTimeout = requestTimeout;

  Future<Map<String, dynamic>?> _fetchJson(Uri url) async {
    try {
      final response = await _httpClient.get(url).timeout(_requestTimeout);

      if (response.statusCode != 200) {
        print('Error HTTP ${response.statusCode} en RAWG');
        return null;
      }

      final decoded = json.decode(response.body);
      if (decoded is! Map<String, dynamic>) {
        print('Respuesta JSON inválida en RAWG');
        return null;
      }

      return decoded;
    } on TimeoutException {
      print('Timeout en la llamada a RAWG');
      return null;
    } on http.ClientException catch (e) {
      print('Error de red en RAWG: $e');
      return null;
    } on FormatException catch (e) {
      print('JSON inválido en RAWG: $e');
      return null;
    } catch (e) {
      print('Error inesperado en RAWG: $e');
      return null;
    }
  }

  // Obtener fecha de hace 5 años en formato YYYY-MM-DD
  String _getDateFiveYearsAgo() {
    final now = DateTime.now();
    final fiveYearsAgo = DateTime(now.year - 5, now.month, now.day);
    return '${fiveYearsAgo.year}-${fiveYearsAgo.month.toString().padLeft(2, '0')}-${fiveYearsAgo.day.toString().padLeft(2, '0')}';
  }

  // Obtener fecha actual en formato YYYY-MM-DD
  String _getCurrentDate() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  DateTime _startOfCurrentWeek() {
    final now = DateTime.now();
    final daysFromMonday = now.weekday - DateTime.monday;
    return DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: daysFromMonday));
  }

  DateTime _endOfCurrentWeek() {
    return _startOfCurrentWeek().add(const Duration(days: 6));
  }

  DateTime _startOfCurrentMonth() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, 1);
  }

  DateTime _endOfCurrentMonth() {
    final now = DateTime.now();
    return DateTime(now.year, now.month + 1, 0);
  }

  // Buscar juegos por nombre
  Future<List<Game>> searchGames(String query) async {
  try {
    if (query.isEmpty) return [];

    final dateRange = '${_getDateFiveYearsAgo()},${_getCurrentDate()}';
    
    final url = Uri.parse(
      '$_baseUrl/games?key=$_apiKey&search=$query&dates=$dateRange&page_size=20&ordering=-rating'
    );
    
    final data = await _fetchJson(url);
    if (data != null) {
      final List results = data['results'] as List? ?? [];
      
      return results.map((gameJson) => Game.fromJson(gameJson)).toList();
    } else {
      return [];
    }
  } catch (e) {
    print('Error al buscar juegos: $e');
    return [];
  }
}

  // Obtener juegos populares
  Future<List<Game>> getPopularGames({int page = 1}) async {
  try {
    final dateRange = '${_getDateFiveYearsAgo()},${_getCurrentDate()}';
    
    final url = Uri.parse(
      '$_baseUrl/games?key=$_apiKey&dates=$dateRange&ordering=-rating&page=$page&page_size=20'
    );
    
    final data = await _fetchJson(url);
    if (data != null) {
      final List results = data['results'] as List? ?? [];
      
      return results.map((gameJson) => Game.fromJson(gameJson)).toList();
    } else {
      return [];
    }
  } catch (e) {
    print('Error al obtener juegos populares: $e');
    return [];
  }
}

  // Obtener juegos por edad PEGI
  Future<List<Game>> getGamesByAge(int age) async {
  try {
    final dateRange = '${_getDateFiveYearsAgo()},${_getCurrentDate()}';
    
    final url = Uri.parse(
      '$_baseUrl/games?key=$_apiKey&dates=$dateRange&ordering=-rating&page_size=40'
    );
    
    final data = await _fetchJson(url);
    if (data != null) {
      final List results = data['results'] as List? ?? [];
      
      final allGames = results.map((gameJson) => Game.fromJson(gameJson)).toList();
      
      // Filtrar juegos apropiados para la edad
      return allGames.where((game) => game.isAppropriateForAge(age)).toList();
    } else {
      return [];
    }
  } catch (e) {
    print('Error al obtener juegos por edad: $e');
    return [];
  }
}

  // Obtener detalles completos de un juego específico
  Future<Game?> getGameDetails(int gameId) async {
    try {
      final url = Uri.parse('$_baseUrl/games/$gameId?key=$_apiKey');

      final data = await _fetchJson(url);
      if (data != null) {
        return Game.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      print('Error al obtener detalles del juego: $e');
      return null;
    }
  }

  // Obtener juegos por género
  Future<List<Game>> getGamesByGenre(String genre) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/games?key=$_apiKey&genres=$genre&page_size=20'
      );
      
      final data = await _fetchJson(url);
      if (data != null) {
        final List results = data['results'] as List? ?? [];
        
        return results.map((gameJson) => Game.fromJson(gameJson)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error al obtener juegos por género: $e');
      return [];
    }
  }

  // Obtener juegos por plataforma
  Future<List<Game>> getGamesByPlatform(int platformId) async {
    try {
      // IDs comunes: PlayStation 5 = 187, Xbox Series X = 186, PC = 4, Nintendo Switch = 7
      final url = Uri.parse(
        '$_baseUrl/games?key=$_apiKey&platforms=$platformId&page_size=20'
      );
      
      final data = await _fetchJson(url);
      if (data != null) {
        final List results = data['results'] as List? ?? [];
        
        return results.map((gameJson) => Game.fromJson(gameJson)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error al obtener juegos por plataforma: $e');
      return [];
    }
  }

  // Obtener screenshots de un juego
  Future<List<String>> getGameScreenshots(int gameId) async {
    try {
      final url = Uri.parse('$_baseUrl/games/$gameId/screenshots?key=$_apiKey');

      final data = await _fetchJson(url);
      if (data != null) {
        final List results = data['results'] as List? ?? [];
        
        return results
            .map((screenshot) => screenshot['image'] as String)
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error al obtener screenshots: $e');
      return [];
    }
  }

  // Obtener juegos nuevos/recientes
  Future<List<Game>> getNewGames() async {
  try {
    final dateRange = '${_getDateFiveYearsAgo()},${_getCurrentDate()}';
    
    final url = Uri.parse(
      '$_baseUrl/games?key=$_apiKey&dates=$dateRange&ordering=-released&page_size=20'
    );
    
    final data = await _fetchJson(url);
    if (data != null) {
      final List results = data['results'] as List? ?? [];
      
      return results.map((gameJson) => Game.fromJson(gameJson)).toList();
    } else {
      return [];
    }
  } catch (e) {
    print('Error al obtener juegos nuevos: $e');
    return [];
  }
}

// Búsqueda avanzada con múltiples filtros
Future<List<Game>> searchGamesWithFilters({
  String? query,
  int? yearFrom,
  int? yearTo,
  List<String>? genres,
  List<int>? platforms,
  int? pegiAge,
  String ordering = '-rating',
  int page = 1,
}) async {
  try {
    Map<String, String> queryParams = {
      'key': _apiKey,
      'page_size': '20',
      'page': page.toString(),
      'ordering': ordering,
    };

    if (query != null && query.isNotEmpty) {
      queryParams['search'] = query;
    }

    if (yearFrom != null && yearTo != null) {
      final dateFrom = '$yearFrom-01-01';
      final dateTo = '$yearTo-12-31';
      queryParams['dates'] = '$dateFrom,$dateTo';
    } else if (yearFrom != null) {
      final dateFrom = '$yearFrom-01-01';
      final now = DateTime.now();
      final dateTo = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
      queryParams['dates'] = '$dateFrom,$dateTo';
    }

    if (genres != null && genres.isNotEmpty) {
      queryParams['genres'] = genres.join(',');
    }

    if (platforms != null && platforms.isNotEmpty) {
      queryParams['platforms'] = platforms.join(',');
    }

    final uri = Uri.parse('$_baseUrl/games').replace(queryParameters: queryParams);
    
    final data = await _fetchJson(uri);
    if (data != null) {
      final List results = data['results'] as List? ?? [];
      
      var games = results.map((gameJson) => Game.fromJson(gameJson)).toList();
      
      if (pegiAge != null) {
        games = games.where((game) => game.isAppropriateForAge(pegiAge)).toList();
      }
      
      return games;
    } else {
      return [];
    }
  } catch (e) {
    print('Error al buscar juegos con filtros: $e');
    return [];
  }
}

// Obtener lista de géneros disponibles
Future<List<Map<String, dynamic>>> getGenres() async {
  try {
    final url = Uri.parse('$_baseUrl/genres?key=$_apiKey');
    final data = await _fetchJson(url);
    if (data != null) {
      final List results = data['results'] as List? ?? [];
      return results.map((genre) => {
        'id': genre['id'].toString(),
        'name': genre['name'] as String,
        'slug': genre['slug'] as String,
      }).toList();
    }
    return [];
  } catch (e) {
    print('Error al obtener géneros: $e');
    return [];
  }
}

// Obtener el juego con mejor rating de la semana actual.
Future<Game?> getTopRatedGameOfCurrentWeek() async {
  try {
    final start = _formatDate(_startOfCurrentWeek());
    final end = _formatDate(_endOfCurrentWeek());
    final url = Uri.parse(
      '$_baseUrl/games?key=$_apiKey&dates=$start,$end&ordering=-rating&page_size=1',
    );

    final data = await _fetchJson(url);
    if (data == null) return null;

    final List results = data['results'] as List? ?? [];
    if (results.isEmpty) return null;

    return Game.fromJson(results.first as Map<String, dynamic>);
  } catch (e) {
    print('Error al obtener el juego de la semana: $e');
    return null;
  }
}

// Obtener juegos del mes actual (ya lanzados y próximos en el mes).
Future<List<Game>> getCurrentMonthGames() async {
  try {
    final start = _formatDate(_startOfCurrentMonth());
    final end = _formatDate(_endOfCurrentMonth());
    final url = Uri.parse(
      '$_baseUrl/games?key=$_apiKey&dates=$start,$end&ordering=-released&page_size=40',
    );

    final data = await _fetchJson(url);
    if (data == null) return [];

    final List results = data['results'] as List? ?? [];
    return results
        .map((gameJson) => Game.fromJson(gameJson as Map<String, dynamic>))
        .toList();
  } catch (e) {
    print('Error al obtener juegos del mes actual: $e');
    return [];
  }
}
}