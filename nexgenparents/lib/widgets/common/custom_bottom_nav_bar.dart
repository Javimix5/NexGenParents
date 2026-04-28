import 'package:flutter/material.dart';

/// La barra de navegación inferior (footer) para la aplicación.
/// Gestiona la navegación entre las secciones principales.
class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  // Determina el índice seleccionado basándose en la ruta actual.
  // NOTA: Para una app más compleja, este estado debería ser manejado por un Provider.
  int _getSelectedIndex(BuildContext context) {
    final String? currentRoute = ModalRoute.of(context)?.settings.name;
    switch (currentRoute) {
      case '/home':
        return 0;
      case '/search':
        return 1;
      case '/guides':
        return 2;
      default:
        return 0; // Por defecto, el home
    }
  }

  void _onItemTapped(int index, BuildContext context) {
    // Evita recargar la misma ruta
    if (_getSelectedIndex(context) == index) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/search');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/guides');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.search_outlined),
          activeIcon: const Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.menu_book_outlined),
          activeIcon: const Icon(Icons.menu_book),
          label: 'Guides',
        ),
      ],
      currentIndex: _getSelectedIndex(context),
      onTap: (index) => _onItemTapped(index, context),
    );
  }
}