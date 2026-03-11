// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:nexgen_parents/config/app_theme.dart';
import 'package:nexgen_parents/config/app_config.dart';

void main() {
  testWidgets('Renderiza pantalla base con tema de la app', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const Scaffold(
          body: Center(child: Text('NexGen Parents Test UI')),
        ),
      ),
    );

    expect(find.text('NexGen Parents Test UI'), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(AppConfig.appName, equals('NexGen Parents'));
  });
}
