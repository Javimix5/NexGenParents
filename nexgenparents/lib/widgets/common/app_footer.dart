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
              TextStyle(color: Colors.white.withValues(alpha: 0.78), fontSize: 13);

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
          _SocialButton(
            item: item,
            iconColor: iconColor,
            backgroundColor: backgroundColor,
            onTap: () => _openExternalLink(context, item.url),
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
            color: AppConfig.primaryColor.withValues(alpha: 0.18),
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
        style: TextStyle(color: Colors.white.withValues(alpha: 0.78)),
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

/// Widget stateful para mostrar tooltip manual sin necesitar Overlay
class _SocialButton extends StatefulWidget {
  const _SocialButton({
    required this.item,
    required this.iconColor,
    required this.backgroundColor,
    required this.onTap,
  });

  final _SocialItem item;
  final Color iconColor;
  final Color backgroundColor;
  final VoidCallback onTap;

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.item.name,
      button: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Botón principal
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _hovered
                      ? widget.backgroundColor.withValues(alpha: 0.7)
                      : widget.backgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.item.icon,
                  color: widget.iconColor,
                  size: 18,
                ),
              ),
              // Tooltip manual (sin Overlay)
              if (_hovered)
                Positioned(
                  bottom: 42,
                  left: -10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      widget.item.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}