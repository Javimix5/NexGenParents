import 'package:flutter/material.dart';
import '../../../config/app_config.dart';
import '../../../l10n/app_localizations.dart';

class ForumPlatformsSection extends StatelessWidget {
  final bool isDark;

  const ForumPlatformsSection({
    super.key,
    required this.isDark,
  });

  String _getIconUrl(String path) {
    return '${AppConfig.githubRawBase}/$path?v=20260311';
  }

  @override
  Widget build(BuildContext context) {
    // Configuramos las plataformas utilizando los mismos logos que en la guía de control parental
    // y añadimos la sección mobile (Android/iOS).
    final l10n = AppLocalizations.of(context);
    final platforms = [
      {
        'name': 'PlayStation',
        'icon': 'icons/PlayStation.png',
        'color': const Color(0xFF003791)
      },
      {
        'name': 'Nintendo Switch',
        'icon': 'icons/nintendo.png',
        'color': const Color(0xFFE60012)
      },
      {
        'name': 'Xbox',
        'icon': 'icons/xbox.png',
        'color': const Color(0xFF107C10)
      },
      {
        'name': 'PC (Steam)',
        'icon': 'icons/steam.png',
        'color': const Color(0xFF171A21)
      },
      {
        'name': 'Android / iOS',
        'icon': 'icons/ios.png', // Reutilizando el icono de iOS para englobar el entorno móvil
        'color': const Color(0xFF555555)
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n?.forumPlatformsTitle ?? 'Plataformas',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: platforms.map((p) {
            return Container(
              width: 150,
              height: 130, // Fijamos la altura al contenedor para que el Wrap lo calcule bien
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1A1A2E) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isDark ? Colors.white10 : Colors.black.withOpacity(0.08)),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.network(
                        _getIconUrl(p['icon'] as String),
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Icon(
                          p['name'] == 'Android / iOS' ? Icons.smartphone : Icons.videogame_asset,
                          size: 40,
                          color: isDark ? Colors.white30 : Colors.black26,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                        color: (p['color'] as Color).withOpacity(0.9),
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(11))),
                    child: Text(p['name'] as String,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}