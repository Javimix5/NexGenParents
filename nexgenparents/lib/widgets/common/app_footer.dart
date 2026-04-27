import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/app_config.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({
    super.key,
    required this.onPrivacyTap,
    required this.onAboutTap,
    required this.onContactTap,
  });

  final VoidCallback onPrivacyTap;
  final VoidCallback onAboutTap;
  final VoidCallback onContactTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF060617),
        borderRadius: BorderRadius.circular(22),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final stacked = constraints.maxWidth < 760;
          final textStyle =
              TextStyle(color: Colors.white.withOpacity(0.78), fontSize: 13);

          if (stacked) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFooterBrand(),
                const SizedBox(height: 16),
                Text(
                  'Empoderando a la próxima generación de padres en la era digital',
                  style: textStyle,
                ),
                const SizedBox(height: 16),
                _buildFooterLinksColumn(),
                const SizedBox(height: 16),
                _buildSocialGrid(context),
              ],
            );
          }

          return Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFooterBrand(),
                    const SizedBox(height: 10),
                    Text(
                      'Empoderando a la próxima generación de padres en la era digital',
                      style: textStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              _buildFooterLinksColumn(),
              const SizedBox(width: 24),
              _buildSocialGrid(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFooterLinksColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFooterLink('Política de privacidad', onPrivacyTap),
        _buildFooterLink('Quienes somos', onAboutTap),
        _buildFooterLink('Contáctanos', onContactTap),
      ],
    );
  }

  Widget _buildSocialGrid(BuildContext context) {
    const iconColor = Color(0xFFE7E7E7);
    const backgroundColor = Color(0xFF475569);

    final items = <_SocialItem>[
      const _SocialItem(
        name: 'Instagram',
        icon: Icons.camera_alt_outlined,
        url: 'https://www.instagram.com',
      ),
      const _SocialItem(
        name: 'Facebook',
        icon: Icons.facebook,
        url: 'https://www.facebook.com',
      ),
      const _SocialItem(
        name: 'X',
        icon: Icons.close,
        url: 'https://x.com',
      ),
      const _SocialItem(
        name: 'YouTube',
        icon: Icons.smart_display,
        url: 'https://www.youtube.com',
      ),
      const _SocialItem(
        name: 'TikTok',
        icon: Icons.music_note,
        url: 'https://www.tiktok.com',
      ),
      const _SocialItem(
        name: 'Reddit',
        icon: Icons.reddit,
        url: 'https://www.reddit.com',
      ),
    ];

    return SizedBox(
      width: 132,
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          for (final item in items)
            Tooltip(
              message: item.name,
              child: InkWell(
                onTap: () => _openExternalLink(context, item.url),
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: backgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(item.icon, color: iconColor, size: 18),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFooterBrand() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppConfig.primaryColor.withOpacity(0.18),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.videogame_asset_outlined,
            color: Colors.white,
            size: 16,
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          AppConfig.appName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget _buildFooterLink(String label, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        style: TextStyle(color: Colors.white.withOpacity(0.78)),
      ),
    );
  }

  Future<void> _openExternalLink(BuildContext context, String rawUrl) async {
    final uri = Uri.parse(rawUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      return;
    }

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No se pudo abrir el enlace externo.')),
    );
  }
}

class _SocialItem {
  const _SocialItem({
    required this.name,
    required this.icon,
    required this.url,
  });

  final String name;
  final IconData icon;
  final String url;
}
