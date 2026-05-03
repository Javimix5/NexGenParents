import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

import 'firebase_options.dart';
import 'config/app_theme.dart';
import 'config/app_config.dart';
import 'providers/auth_provider.dart';
import 'providers/forum_provider.dart';
import 'providers/dictionary_provider.dart';
import 'providers/games_provider.dart';
import 'providers/locale_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/welcome_screen.dart';
import 'widgets/common/persistent_frame.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase con las opciones específicas de la plataforma
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> appNavigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ForumProvider()),
        ChangeNotifierProvider(create: (_) => DictionaryProvider()),
        ChangeNotifierProvider(create: (_) => GamesProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (context, themeProvider, localeProvider, child) {
          return MaterialApp(
            title: AppConfig.appName,
            debugShowCheckedModeBanner: false,
            navigatorKey: appNavigatorKey,

            // --- Configuración de Tema ---
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,

            // --- Configuración de Idioma (Localización) ---
            locale: localeProvider.locale,
            supportedLocales:
                L10n.all, // Usando la clase L10n del locale_provider
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            builder: (context, child) {
              final content = child ?? const SizedBox.shrink();
              final authProvider = Provider.of<AuthProvider>(context);
              final frameAwareContent =
                  authProvider.isAuthenticated && !authProvider.isLoading
                      ? PersistentFrame(
                          navigatorKey: appNavigatorKey,
                          child: content,
                        )
                      : content;

              return LayoutBuilder(
                builder: (context, constraints) {
                  // Vista móvil/tablet
                  if (constraints.maxWidth < 1200) {
                    return frameAwareContent;
                  }

                  // Vista de escritorio centrada
                  return Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Row(
                      children: [
                        const Expanded(child: SizedBox()),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: Material(
                            elevation: 16,
                            child: frameAwareContent,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  );
                },
              );
            },
            home: const WelcomeScreen(),
          );
        },
      ),
    );
  }
}
