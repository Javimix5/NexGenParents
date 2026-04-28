import 'package:flutter/material.dart';
import '../../config/app_config.dart';

/// El AppBar (header) personalizado y reutilizable para la aplicación.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(AppConfig.appName),
      automaticallyImplyLeading: false, // Para evitar el botón de "atrás" por defecto
      actions: [
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