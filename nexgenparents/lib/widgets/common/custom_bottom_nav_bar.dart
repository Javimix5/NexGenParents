import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../screens/info/about_us_screen.dart';
import '../../screens/info/privacy_policy_screen.dart';
import '../../screens/info/contact_us_screen.dart';

/// La barra de navegación inferior (footer) para la aplicación.
/// Gestiona la navegación entre las secciones principales.
class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  // Determina el índice seleccionado basándose en la ruta actual.
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
    if (index == 3) {
      _showMoreBottomSheet(context);
      return;
    }

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

  void _showMoreBottomSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(l10n?.aboutUsTitle ?? 'Quiénes somos'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutUsScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.privacy_tip_outlined),
                title: Text(l10n?.privacyPolicyTitle ?? 'Política de Privacidad'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.mail_outline),
                title: Text(l10n?.contactUsTitle ?? 'Contáctanos'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactUsScreen()));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home),
          label: l10n?.navHome ?? 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.search_outlined),
          activeIcon: const Icon(Icons.search),
          label: l10n?.navSearch ?? 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.menu_book_outlined),
          activeIcon: const Icon(Icons.menu_book),
          label: l10n?.navGuides ?? 'Guías',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.more_horiz_outlined),
          activeIcon: const Icon(Icons.more_horiz),
          label: l10n?.headerMenuBtn ?? 'Más',
        ),
      ],
      currentIndex: _getSelectedIndex(context),
      onTap: (index) => _onItemTapped(index, context),
    );
  }
}