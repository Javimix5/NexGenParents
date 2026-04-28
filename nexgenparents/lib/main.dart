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
import 'screens/auth/login_screen.dart';
import 'screens/home/home_screen.dart';
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
            home: const AuthWrapper(),
          );
        },
      ),
    );
  }
}

// Widget que decide qué pantalla mostrar según el estado de autenticación
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final theme = Theme.of(context);

        // Mostrar indicador de carga mientras verifica autenticación
        if (authProvider.isLoading) {
          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.videogame_asset,
                    size: 80,
                    color: theme.primaryColor,
                  ),
                  const SizedBox(height: AppConfig.paddingLarge),
                  const CircularProgressIndicator(),
                  const SizedBox(height: AppConfig.paddingMedium),
                  // Usamos AppLocalizations si está disponible, si no un texto por defecto
                  Text(AppLocalizations.of(context)
                          ?.loading(AppConfig.appName) ??
                      'Cargando ${AppConfig.appName}...'),
                ],
              ),
            ),
          );
        }

        // Si está autenticado, mostrar Home
        // Si no está autenticado, mostrar Login
        return authProvider.isAuthenticated
            ? const HomeScreen()
            : const LoginScreen();
      },
    );
  }
}
