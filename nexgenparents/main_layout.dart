import 'package:flutter/material.dart';
import 'package:nexgen_parents/widgets/common/custom_app_bar.dart';
import 'package:nexgen_parents/widgets/common/custom_bottom_nav_bar.dart';

/// Este widget actúa como la plantilla principal de la aplicación.
/// Dibuja un AppBar y una barra de navegación inferior persistentes,
/// y muestra el contenido de la pantalla actual en el cuerpo.
class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(), // Tu header/appbar personalizado
      body: child, // Aquí se inserta el contenido de la pantalla actual
      bottomNavigationBar: const CustomBottomNavBar(), // Tu footer/barra de navegación
    );
  }
}