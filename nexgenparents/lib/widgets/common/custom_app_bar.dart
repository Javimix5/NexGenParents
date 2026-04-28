import 'package:flutter/material.dart';
import '../../config/app_config.dart';
import '../../l10n/app_localizations.dart';

/// El AppBar (header) personalizado y reutilizable para la aplicación.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppBar(
      title: Text(AppConfig.appName),
      automaticallyImplyLeading: false, // Para evitar el botón de "atrás" por defecto
      actions: [
        IconButton(
          icon: const Icon(Icons.person_outline),
          tooltip: l10n.profileTooltip,
          onPressed: () {
            // TODO: Implementar navegación a la pantalla de perfil
            // Navigator.of(context).pushNamed('/profile');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}