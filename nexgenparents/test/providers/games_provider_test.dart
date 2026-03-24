import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nexgen_parents/providers/games_provider.dart';
import 'package:nexgen_parents/models/game_model.dart';

void main() {
  test('GamesProvider persiste favoritos en almacenamiento local', () async {
    SharedPreferences.setMockInitialValues({});

    final providerA = GamesProvider();
    await Future<void>.delayed(const Duration(milliseconds: 10));

    final game = Game(id: 7, name: 'Local Favorite', rating: 4.0);
    providerA.addToFavorites(game);

    await Future<void>.delayed(const Duration(milliseconds: 50));

    final providerB = GamesProvider();
    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(providerB.isFavorite(7), isTrue);
    expect(providerB.favoriteGames.any((g) => g.name == 'Local Favorite'), isTrue);
  });
}
