import 'package:flutter/material.dart';
import '../../config/app_config.dart';
import '../../l10n/app_localizations.dart';
import '../../screens/info/about_us_screen.dart';
import '../../screens/info/privacy_policy_screen.dart';
import '../../screens/info/contact_us_screen.dart';

/// El AppBar (header) personalizado y reutilizable para la aplicación.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(AppConfig.appName),
      automaticallyImplyLeading: false, // Para evitar el botón de "atrás" por defecto
      actions: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {
            if (value == 'about') {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AboutUsScreen()));
            } else if (value == 'privacy') {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()));
            } else if (value == 'contact') {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ContactUsScreen()));
            }
          },
          itemBuilder: (BuildContext context) {
            final l10n = AppLocalizations.of(context);
            return [
              PopupMenuItem(
                value: 'about',
                child: Text(l10n?.aboutUsTitle ?? 'Quiénes somos'),
              ),
              PopupMenuItem(
                value: 'privacy',
                child: Text(l10n?.privacyPolicyTitle ?? 'Política de Privacidad'),
              ),
              PopupMenuItem(
                value: 'contact',
                child: Text(l10n?.contactUsTitle ?? 'Contáctanos'),
              ),
            ];
          },
        ),
        IconButton(
          icon: const Icon(Icons.person_outline),
          tooltip: 'Profile',
          onPressed: () {
            Navigator.of(context).pushNamed('/profile');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}