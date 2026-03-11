import 'package:flutter_test/flutter_test.dart';
import 'package:nexgen_parents/models/game_model.dart';

void main() {
  test('Game.fromJson parsea campos y mapea PEGI desde ESRB', () {
    final game = Game.fromJson({
      'id': 42,
      'name': 'Test Game',
      'rating': 4.5,
      'esrb_rating': {'name': 'Teen'},
      'genres': [
        {'name': 'Action'},
        {'name': 'Adventure'},
      ],
      'platforms': [
        {
          'platform': {'name': 'PC'}
        }
      ],
      'tags': [
        {'name': 'Singleplayer'},
        {'name': 'Story Rich'},
      ],
      'description_raw': 'Descripcion extensa',
    });

    expect(game.id, 42);
    expect(game.name, 'Test Game');
    expect(game.pegiRating, 12);
    expect(game.genres, contains('Action'));
    expect(game.platforms, contains('PC'));
    expect(game.tags, contains('Singleplayer'));
  });

  test('isAppropriateForAge y getAgeWarning se comportan correctamente', () {
    final game = Game.fromJson({
      'id': 1,
      'name': 'Mature Test',
      'esrb_rating': {'name': 'Mature'},
    });

    expect(game.isAppropriateForAge(12), isFalse);
    expect(game.isAppropriateForAge(16), isTrue);
    expect(game.getAgeWarning(12), contains('mayores de 16'));
  });
}
