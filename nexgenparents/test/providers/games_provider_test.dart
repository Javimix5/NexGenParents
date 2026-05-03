import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nexgen_parents/providers/games_provider.dart';
import 'package:nexgen_parents/models/game_model.dart';
import 'package:nexgen_parents/services/rawg_service.dart';

// 1. Creamos la clase Mock que imita al servicio real
class MockRawgService extends Mock implements RawgService {}

void main() {
  group('GamesProvider Tests', () {
    late MockRawgService mockRawgService;

    setUp(() {
      // Limpiamos el almacenamiento local simulado antes de cada test para evitar contaminación
      SharedPreferences.setMockInitialValues({});
      // 2. Instanciamos un mock limpio antes de cada prueba
      mockRawgService = MockRawgService();
    });

    test('Estado inicial correcto al instanciar', () {
      final provider = GamesProvider();
      
      expect(provider.isLoading, isFalse);
      expect(provider.isLoadingDetails, isFalse);
      expect(provider.favoriteGames, isEmpty);
      expect(provider.popularGames, isEmpty);
      expect(provider.searchResults, isEmpty);
    });

    test('Añadir y persistir favoritos en almacenamiento local', () async {
      final providerA = GamesProvider();
      await Future<void>.delayed(const Duration(milliseconds: 10));

      final game = Game(id: 7, name: 'Local Favorite', rating: 4.0);
      providerA.addToFavorites(game);

      await Future<void>.delayed(const Duration(milliseconds: 50));

      // Instanciamos un nuevo provider B para verificar que lee correctamente desde SharedPreferences
      final providerB = GamesProvider();
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(providerB.isFavorite(7), isTrue);
      expect(providerB.favoriteGames.any((g) => g.name == 'Local Favorite'), isTrue);
    });

    test('Eliminar un juego de favoritos', () async {
      final provider = GamesProvider();
      await Future<void>.delayed(const Duration(milliseconds: 10));

      final game = Game(id: 10, name: 'To Be Removed', rating: 3.5);
      provider.addToFavorites(game);
      expect(provider.isFavorite(10), isTrue);

      provider.removeFromFavorites(10);
      expect(provider.isFavorite(10), isFalse);
      expect(provider.favoriteGames, isEmpty);
    });

    test('clearSearch limpia los resultados y el estado de búsqueda', () {
      final provider = GamesProvider();
      
      provider.clearSearch();
      
      expect(provider.searchResults, isEmpty);
      expect(provider.isLoading, isFalse);
    });

    test('loadPopularGames solicita datos a la API y actualiza el estado', () async {
      // 3. Preparamos una respuesta falsa de la API (Mock)
      final mockGamesList = [
        Game(id: 101, name: 'Mocked Game 1', rating: 4.8),
        Game(id: 102, name: 'Mocked Game 2', rating: 4.2),
      ];

      // Le decimos a mocktail: "Cuando alguien llame a getPopularGames, devuelve esta lista falsa"
      when(() => mockRawgService.getPopularGames())
          .thenAnswer((_) async => mockGamesList);

      // 4. Inyectamos nuestro servicio falso en el Provider
      final provider = GamesProvider(rawgService: mockRawgService);

      // 5. Ejecutamos la función
      final future = provider.loadPopularGames(); // No le ponemos await todavía
      expect(provider.isLoading, isTrue); // Comprobamos que el loading se activa

      await future; // Ahora sí esperamos a que termine

      // 6. Verificamos que el estado final es correcto
      expect(provider.isLoading, isFalse);
      expect(provider.popularGames.length, 2);
      expect(provider.popularGames.first.name, 'Mocked Game 1');
      verify(() => mockRawgService.getPopularGames()).called(1); // Verificamos que se llamó a la API exactamente 1 vez
    });
  });
}
