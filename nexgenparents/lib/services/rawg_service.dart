import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/game_model.dart';
import '../config/app_config.dart';

class RawgService {
  final String _baseUrl = AppConfig.rawgBaseUrl;
  final String _apiKey = AppConfig.rawgApiKey;

  // Buscar juegos por nombre
  Future<List<Game>> searchGames(String query) async {
    try {
      if (query.isEmpty) return [];

      final url = Uri.parse('$_baseUrl/games?key=$_apiKey&search=$query&page_size=20');
      
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'] ?? [];
        
        return results.map((gameJson) => Game.fromJson(gameJson)).toList();
      } else {
        print('Error en la API: ${response.statusCode}');
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
      final url = Uri.parse(
        '$_baseUrl/games?key=$_apiKey&ordering=-rating&page=$page&page_size=20'
      );
      
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'] ?? [];
        
        return results.map((gameJson) => Game.fromJson(gameJson)).toList();
      } else {
        print('Error en la API: ${response.statusCode}');
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
      // Obtener todos los juegos y filtrar localmente por edad
      // (RAWG no tiene filtro directo por PEGI en la API gratuita)
      final url = Uri.parse(
        '$_baseUrl/games?key=$_apiKey&ordering=-rating&page_size=40'
      );
      
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'] ?? [];
        
        final allGames = results.map((gameJson) => Game.fromJson(gameJson)).toList();
        
        // Filtrar juegos apropiados para la edad
        return allGames.where((game) => game.isAppropriateForAge(age)).toList();
      } else {
        print('Error en la API: ${response.statusCode}');
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
      
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Game.fromJson(data);
      } else {
        print('Error en la API: ${response.statusCode}');
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
      
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'] ?? [];
        
        return results.map((gameJson) => Game.fromJson(gameJson)).toList();
      } else {
        print('Error en la API: ${response.statusCode}');
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
      
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'] ?? [];
        
        return results.map((gameJson) => Game.fromJson(gameJson)).toList();
      } else {
        print('Error en la API: ${response.statusCode}');
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
      
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'] ?? [];
        
        return results
            .map((screenshot) => screenshot['image'] as String)
            .toList();
      } else {
        print('Error en la API: ${response.statusCode}');
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
      final now = DateTime.now();
      final oneMonthAgo = now.subtract(Duration(days: 30));
      
      final dateFormat = '${oneMonthAgo.year}-${oneMonthAgo.month.toString().padLeft(2, '0')}-${oneMonthAgo.day.toString().padLeft(2, '0')}';
      
      final url = Uri.parse(
        '$_baseUrl/games?key=$_apiKey&dates=$dateFormat,${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}&ordering=-released&page_size=20'
      );
      
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'] ?? [];
        
        return results.map((gameJson) => Game.fromJson(gameJson)).toList();
      } else {
        print('Error en la API: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error al obtener juegos nuevos: $e');
      return [];
    }
  }
}