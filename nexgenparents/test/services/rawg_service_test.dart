import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:nexgen_parents/services/rawg_service.dart';

void main() {
  test('searchGames devuelve [] cuando hay timeout', () async {
    final client = MockClient((request) async {
      await Future<void>.delayed(const Duration(milliseconds: 30));
      return http.Response('{"results":[]}', 200);
    });

    final service = RawgService(
      httpClient: client,
      requestTimeout: const Duration(milliseconds: 1),
    );

    final result = await service.searchGames('zelda');
    expect(result, isEmpty);
  });

  test('searchGames devuelve [] cuando JSON es inválido', () async {
    final client = MockClient((request) async {
      return http.Response('no-es-json', 200);
    });

    final service = RawgService(httpClient: client);
    final result = await service.searchGames('mario');

    expect(result, isEmpty);
  });
}
