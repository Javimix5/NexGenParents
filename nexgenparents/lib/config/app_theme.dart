import 'package:flutter/material.dart';
import 'app_config.dart';

class AppTheme {
  // Tema claro de la aplicación
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // Colores principales
    primaryColor: AppConfig.primaryColor,
    scaffoldBackgroundColor: AppConfig.backgroundLight,
    colorScheme: ColorScheme.light(
      primary: AppConfig.primaryColor,
      secondary: AppConfig.secondaryColor,
      tertiary: AppConfig.accentColor,
      tertiaryContainer: AppConfig.accentColor.withOpacity(0.1),
      error: AppConfig.errorColor,
      surface: Colors.white, // Tarjetas blancas sobre fondo gris claro
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppConfig.textPrimaryColor,
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
      color: Colors.white,
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
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.all(AppConfig.paddingMedium),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
        borderSide: const BorderSide(color: AppConfig.textSecondaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
        borderSide:
            const BorderSide(color: AppConfig.textSecondaryColor, width: 1),
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

  // Tema oscuro de la aplicación
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    // Colores principales
    primaryColor: AppConfig.primaryColor,
    scaffoldBackgroundColor: AppConfig.backgroundDark,
    colorScheme: ColorScheme.dark(
      primary: AppConfig.primaryColor,
      secondary: AppConfig.secondaryColor,
      tertiary: AppConfig.accentColor,
      tertiaryContainer: AppConfig.accentColor.withOpacity(0.15),
      error: AppConfig.errorColor,
      surface: AppConfig.cardDark,
      onPrimary: Colors.white,
      onSecondary: Colors.white, // Texto claro sobre fondo oscuro
      onSurface:
          AppConfig.backgroundLight, // Texto claro sobre tarjetas oscuras
    ),

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppConfig.cardDark,
      foregroundColor: AppConfig.backgroundLight,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: AppConfig.fontSizeHeading,
        fontWeight: FontWeight.bold,
        color: AppConfig.backgroundLight,
      ),
    ),

    // Textos
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: AppConfig.fontSizeTitle,
          fontWeight: FontWeight.bold,
          color: AppConfig.backgroundLight),
      displayMedium: TextStyle(
          fontSize: AppConfig.fontSizeHeading,
          fontWeight: FontWeight.w600,
          color: AppConfig.backgroundLight),
      bodyLarge: TextStyle(
          fontSize: AppConfig.fontSizeBody, color: AppConfig.backgroundLight),
      bodyMedium:
          TextStyle(fontSize: AppConfig.fontSizeBody, color: Color(0xFFBFC7D9)),
      labelLarge: TextStyle(
          fontSize: AppConfig.fontSizeBody, fontWeight: FontWeight.w600),
    ),

    // Cards
    cardTheme: CardThemeData(
      color: AppConfig.cardDark,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
      ),
      margin: const EdgeInsets.symmetric(
          horizontal: AppConfig.paddingMedium,
          vertical: AppConfig.paddingSmall),
    ),

    // Botones (los estilos base se adaptan bien, solo ajustamos foreground si es necesario)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: Colors.white,
      ),
    ),

    // Campos de texto
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppConfig.cardDark,
      contentPadding: const EdgeInsets.all(AppConfig.paddingMedium),
      prefixIconColor: Color(0xFFD5DBEA),
      suffixIconColor: Color(0xFFD5DBEA),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
        borderSide: const BorderSide(color: Color(0xFF8D98B3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
        borderSide: const BorderSide(color: Color(0xFF8D98B3), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
        borderSide: const BorderSide(
            color: AppConfig.accentColor,
            width: 2), // Usamos el acento para el foco
      ),
      labelStyle: const TextStyle(
          fontSize: AppConfig.fontSizeBody, color: Color(0xFFD5DBEA)),
      floatingLabelStyle: const TextStyle(
          fontSize: AppConfig.fontSizeBody, color: Color(0xFFE8ECF7)),
      hintStyle: const TextStyle(
          fontSize: AppConfig.fontSizeBody, color: Color(0xFFBFC7D9)),
    ),

    // Indicadores de progreso
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppConfig.accentColor, // El turquesa destacará genial
    ),
  );

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
