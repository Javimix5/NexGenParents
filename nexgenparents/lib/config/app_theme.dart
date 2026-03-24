import 'package:flutter/material.dart';
import 'app_config.dart';

class AppTheme {
  // Tema claro de la aplicación
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      
      // Colores principales
      primaryColor: AppConfig.primaryColor,
      scaffoldBackgroundColor: AppConfig.backgroundColor,
      colorScheme: const ColorScheme.light(
        primary: AppConfig.primaryColor,
        secondary: AppConfig.secondaryColor,
        error: AppConfig.errorColor,
        surface: AppConfig.cardColor,
      ),
      
      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: AppConfig.fontSizeHeading,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      
      // Textos (tamaños grandes para accesibilidad)
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: AppConfig.fontSizeTitle,
          fontWeight: FontWeight.bold,
          color: AppConfig.textPrimaryColor,
        ),
        displayMedium: TextStyle(
          fontSize: AppConfig.fontSizeHeading,
          fontWeight: FontWeight.w600,
          color: AppConfig.textPrimaryColor,
        ),
        bodyLarge: TextStyle(
          fontSize: AppConfig.fontSizeBody,
          color: AppConfig.textPrimaryColor,
        ),
        bodyMedium: TextStyle(
          fontSize: AppConfig.fontSizeBody,
          color: AppConfig.textSecondaryColor,
        ),
        labelLarge: TextStyle(
          fontSize: AppConfig.fontSizeBody,
          fontWeight: FontWeight.w600,
        ),
      ),
      
      // Cards
      cardTheme: CardThemeData(
        color: AppConfig.cardColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: AppConfig.paddingMedium,
          vertical: AppConfig.paddingSmall,
        ),
      ),
      
      // Botones elevados (principales)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConfig.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConfig.paddingLarge,
            vertical: AppConfig.paddingMedium,
          ),
          textStyle: const TextStyle(
            fontSize: AppConfig.fontSizeBody,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
          ),
          elevation: 2,
        ),
      ),
      
      // Botones de texto (secundarios)
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppConfig.primaryColor,
          textStyle: const TextStyle(
            fontSize: AppConfig.fontSizeBody,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Botones con borde
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppConfig.primaryColor,
          side: const BorderSide(color: AppConfig.primaryColor, width: 2),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConfig.paddingLarge,
            vertical: AppConfig.paddingMedium,
          ),
          textStyle: const TextStyle(
            fontSize: AppConfig.fontSizeBody,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
          ),
        ),
      ),
      
      // Campos de texto (formularios)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppConfig.cardColor,
        contentPadding: const EdgeInsets.all(AppConfig.paddingMedium),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
          borderSide: const BorderSide(color: AppConfig.textSecondaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
          borderSide: const BorderSide(color: AppConfig.textSecondaryColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
          borderSide: const BorderSide(color: AppConfig.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
          borderSide: const BorderSide(color: AppConfig.errorColor, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
          borderSide: const BorderSide(color: AppConfig.errorColor, width: 2),
        ),
        labelStyle: const TextStyle(
          fontSize: AppConfig.fontSizeBody,
          color: AppConfig.textSecondaryColor,
        ),
        hintStyle: const TextStyle(
          fontSize: AppConfig.fontSizeBody,
          color: AppConfig.textSecondaryColor,
        ),
      ),
      
      // Chips (para categorías del diccionario)
      chipTheme: ChipThemeData(
        backgroundColor: AppConfig.primaryColor.withOpacity(0.1),
        labelStyle: const TextStyle(
          fontSize: AppConfig.fontSizeCaption,
          color: AppConfig.primaryColor,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppConfig.paddingSmall,
          vertical: AppConfig.paddingSmall / 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConfig.borderRadiusSmall),
        ),
      ),
      
      // Indicadores de progreso
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppConfig.primaryColor,
      ),
    );
  }
  
  // Método helper para obtener color según status del término
  static Color getStatusColor(String status) {
    switch (status) {
      case AppConfig.statusApproved:
        return AppConfig.accentColor;
      case AppConfig.statusPending:
        return AppConfig.warningColor;
      case AppConfig.statusRejected:
        return AppConfig.errorColor;
      default:
        return AppConfig.textSecondaryColor;
    }
  }
  
  // Método helper para obtener color según clasificación PEGI
  static Color getPegiColor(int rating) {
    if (rating <= 7) {
      return AppConfig.accentColor; // Verde para niños
    } else if (rating <= 12) {
      return Colors.blue; // Azul para preadolescentes
    } else if (rating <= 16) {
      return AppConfig.warningColor; // Amarillo para adolescentes
    } else {
      return AppConfig.errorColor; // Rojo para adultos
    }
  }
}