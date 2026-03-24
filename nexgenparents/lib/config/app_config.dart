import 'package:flutter/material.dart';

class AppConfig {
  // App Info
  static const String appName = 'NexGen Parents';
  static const String appVersion = '1.0.0';
  
  // API Keys y URLs
  static const String rawgApiKey = '8df1d5b4e2c1454a903fda6703ab3103'; // Cambiar por tu key de RAWG.io
  static const String rawgBaseUrl = 'https://api.rawg.io/api';
  
  // GitHub + jsDelivr para imágenes estáticas
  static const String githubCdnBase = 
      'https://cdn.jsdelivr.net/gh/javimix5/nexgen-parents-assets@main';
    static const String githubRawBase =
      'https://raw.githubusercontent.com/Javimix5/nexgen-parents-assets/main';
  
  // Colores del tema (adaptado a padres/madres - interfaz amigable)
  static const Color primaryColor = Color(0xFF6366F1); // Indigo suave
  static const Color secondaryColor = Color(0xFF8B5CF6); // Púrpura
  static const Color accentColor = Color(0xFF10B981); // Verde (aprobado)
  static const Color errorColor = Color(0xFFEF4444); // Rojo
  static const Color warningColor = Color(0xFFF59E0B); // Amarillo
  static const Color backgroundColor = Color(0xFFF9FAFB); // Gris muy claro
  static const Color cardColor = Color(0xFFFFFFFF); // Blanco
  static const Color textPrimaryColor = Color(0xFF111827); // Gris oscuro
  static const Color textSecondaryColor = Color(0xFF6B7280); // Gris medio
  
  // Tipografía (adaptada a personas no nativas digitales - tamaños grandes)
  static const double fontSizeTitle = 24.0;
  static const double fontSizeHeading = 20.0;
  static const double fontSizeBody = 16.0;
  static const double fontSizeCaption = 14.0;
  
  // Spacing
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  
  // Border Radius
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;
  
  // Categorías del Diccionario
  static const List<String> dictionaryCategories = [
    'jerga_gamer',
    'mecánicas_juego',
    'plataformas',
  ];
  
  // Clasificaciones PEGI
  static const List<int> pegiRatings = [3, 7, 12, 16, 18];
  
  // Cache Duration
  static const Duration cacheDuration = Duration(hours: 24);
  
  // Roles de Usuario
  static const String roleUser = 'user';
  static const String roleModerator = 'moderator';
  static const String roleAdmin = 'admin';
  
  // Status de términos del diccionario
  static const String statusPending = 'pending';
  static const String statusApproved = 'approved';
  static const String statusRejected = 'rejected';
}