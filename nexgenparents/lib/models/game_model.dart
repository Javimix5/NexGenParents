class Game {
  final int id;
  final String name;
  final String? backgroundImage;
  final double rating;
  final String? released; // Fecha de lanzamiento
  final int? metacritic; // Puntuación Metacritic
  final List<String> genres; // Géneros del juego
  final List<String> platforms; // Plataformas (PS5, Xbox, PC, etc.)
  final String? esrbRating; // Clasificación ESRB/PEGI
  final String? description; // Descripción/sinopsis
  final List<String> tags; // Etiquetas del juego

  Game({
    required this.id,
    required this.name,
    this.backgroundImage,
    this.rating = 0.0,
    this.released,
    this.metacritic,
    this.genres = const [],
    this.platforms = const [],
    this.esrbRating,
    this.description,
    this.tags = const [],
  });

  // Constructor desde JSON de RAWG API
  factory Game.fromJson(Map<String, dynamic> json) {
    // Extraer géneros
    List<String> genresList = [];
    if (json['genres'] != null) {
      genresList = (json['genres'] as List)
          .map((genre) => genre['name'] as String)
          .toList();
    }

    // Extraer plataformas
    List<String> platformsList = [];
    if (json['platforms'] != null) {
      platformsList = (json['platforms'] as List)
          .map((platform) => platform['platform']['name'] as String)
          .toList();
    }

    // Extraer tags
    List<String> tagsList = [];
    if (json['tags'] != null) {
      tagsList = (json['tags'] as List)
          .take(5) // Solo los primeros 5 tags
          .map((tag) => tag['name'] as String)
          .toList();
    }

    return Game(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Sin título',
      backgroundImage: json['background_image'],
      rating: (json['rating'] ?? 0.0).toDouble(),
      released: json['released'],
      metacritic: json['metacritic'],
      genres: genresList,
      platforms: platformsList,
      esrbRating: json['esrb_rating']?['name'],
      description: json['description_raw'], // Texto plano sin HTML
      tags: tagsList,
    );
  }

  // Convertir a Map (para cache local)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'background_image': backgroundImage,
      'rating': rating,
      'released': released,
      'metacritic': metacritic,
      'genres': genres,
      'platforms': platforms,
      'esrb_rating': esrbRating,
      'description_raw': description,
      'tags': tags,
    };
  }

  // Método para obtener edad recomendada en formato PEGI
  int? get pegiRating {
    if (esrbRating == null) return null;
    
    // Mapeo de clasificaciones ESRB a PEGI
    switch (esrbRating?.toLowerCase()) {
      case 'everyone':
        return 3;
      case 'everyone 10+':
        return 7;
      case 'teen':
        return 12;
      case 'mature':
        return 16;
      case 'adults only':
        return 18;
      default:
        return null;
    }
  }

  // Método para obtener descripción corta (primeros 200 caracteres)
  String get shortDescription {
    if (description == null || description!.isEmpty) {
      return 'No hay descripción disponible';
    }
    if (description!.length <= 200) {
      return description!;
    }
    return '${description!.substring(0, 200)}...';
  }

  // Verificar si el juego es apropiado para una edad específica
  bool isAppropriateForAge(int age) {
    final pegi = pegiRating;
    if (pegi == null) return true; // Si no hay clasificación, no restringimos
    return age >= pegi;
  }

  // Obtener texto de advertencia según edad
  String getAgeWarning(int childAge) {
    final pegi = pegiRating;
    if (pegi == null) {
      return 'Sin clasificación PEGI disponible';
    }
    
    if (childAge < pegi) {
      return '⚠️ Este juego está clasificado para mayores de $pegi años';
    }
    return '✅ Apropiado para la edad';
  }

  @override
  String toString() {
    return 'Game(id: $id, name: $name, rating: $rating, pegi: $pegiRating)';
  }
}