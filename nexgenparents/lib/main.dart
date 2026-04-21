import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'config/app_theme.dart';
import 'config/app_config.dart';
import 'providers/auth_provider.dart';
import 'providers/forum_provider.dart';
import 'providers/dictionary_provider.dart';
import 'providers/games_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home/home_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    // MultiProvider con todos los providers necesarios [1]
    return MultiProvider(
      providers: [
        // Provider de Autenticación [1]
        ChangeNotifierProvider(create: (_) => AuthProvider()),

        // Provider del Foro [1]
        ChangeNotifierProvider(create: (_) => ForumProvider()),
        
        // Provider del Diccionario Colaborativo [1]
        ChangeNotifierProvider(create: (_) => DictionaryProvider()),
        
        // Provider de Videojuegos [1]
        ChangeNotifierProvider(create: (_) => GamesProvider()),
      ],
      child: MaterialApp(
        title: AppConfig.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        builder: (context, child) {
          final content = child ?? const SizedBox.shrink();

          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 1200) {
                return content;
              }

              return Container(
                color: AppConfig.backgroundColor,
                child: Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: content,
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              );
            },
          );
        },
        home: const AuthWrapper(),
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
        // Mostrar indicador de carga mientras verifica autenticación
        if (authProvider.isLoading) {
          return const Scaffold(
            backgroundColor: AppConfig.backgroundColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.videogame_asset,
                    size: 80,
                    color: AppConfig.primaryColor,
                  ),
                  SizedBox(height: AppConfig.paddingLarge),
                  CircularProgressIndicator(),
                  SizedBox(height: AppConfig.paddingMedium),
                  Text(
                    'Cargando ${AppConfig.appName}...',
                    style: TextStyle(
                      fontSize: AppConfig.fontSizeBody,
                      color: AppConfig.textSecondaryColor,
                    ),
                  ),
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