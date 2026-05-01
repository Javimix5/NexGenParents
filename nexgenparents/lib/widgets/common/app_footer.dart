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
      decoration: BoxDecoration(
        color: const Color(0xFF060617),
        borderRadius: BorderRadius.circular(22),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 760;
          return isMobile
              ? _buildMobileLayout(context)
              : _buildDesktopLayout(context);
        },
      ),
    );
  }

  // ─────────────────────────────────────────
  // LAYOUT MÓVIL
  // ─────────────────────────────────────────
  Widget _buildMobileLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Marca centrada
          _buildFooterBrand(),
          const SizedBox(height: 10),

          // Tagline centrado
          Text(
            _t(context,
                es: 'Empoderando a la próxima generación\nde padres en la era digital',
                gl: 'Empoderando á vindeira xeración\nde pais na era dixital',
                en: 'Empowering the next generation\nof parents in the digital age'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.65),
              fontSize: 13,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 20),
          Divider(color: Colors.white.withValues(alpha: 0.08), height: 1),
          const SizedBox(height: 20),

          // Links y redes en fila
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Links de navegación
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFooterLink(_t(context, es: 'Política de privacidad', gl: 'Política de privacidade', en: 'Privacy Policy'), onPrivacyTap),
                    _buildFooterLink(_t(context, es: 'Quienes somos', gl: 'Quen somos', en: 'About us'), onAboutTap),
                    _buildFooterLink(_t(context, es: 'Contáctanos', gl: 'Contacta connosco', en: 'Contact us'), onContactTap),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // Redes sociales
              _buildSocialGrid(context),
            ],
          ),

          const SizedBox(height: 20),
          Divider(color: Colors.white.withValues(alpha: 0.08), height: 1),
          const SizedBox(height: 14),

          // Copyright centrado
          Text(
            _t(context,
                es: '© ${DateTime.now().year} ${AppConfig.appName}. Todos los derechos reservados.',
                gl: '© ${DateTime.now().year} ${AppConfig.appName}. Todos os dereitos reservados.',
                en: '© ${DateTime.now().year} ${AppConfig.appName}. All rights reserved.'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.35),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // LAYOUT DESKTOP
  // ─────────────────────────────────────────
  Widget _buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Marca + tagline
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFooterBrand(),
                    const SizedBox(height: 10),
                    Text(
                      _t(context,
                          es: 'Empoderando a la próxima generación de padres en la era digital',
                          gl: 'Empoderando á vindeira xeración de pais na era dixital',
                          en: 'Empowering the next generation of parents in the digital age'),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.65),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 32),

              // Links
              _buildFooterLinksColumn(context),

              const SizedBox(width: 32),

              // Redes sociales
              _buildSocialGrid(context),
            ],
          ),

          const SizedBox(height: 16),
          Divider(color: Colors.white.withValues(alpha: 0.08), height: 1),
          const SizedBox(height: 12),

          // Copyright
          Text(
            _t(context,
                es: '© ${DateTime.now().year} ${AppConfig.appName}. Todos los derechos reservados.',
                gl: '© ${DateTime.now().year} ${AppConfig.appName}. Todos os dereitos reservados.',
                en: '© ${DateTime.now().year} ${AppConfig.appName}. All rights reserved.'),
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.35),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // WIDGETS COMPARTIDOS
  // ─────────────────────────────────────────
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

  Widget _buildFooterLinksColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFooterLink(_t(context, es: 'Política de privacidad', gl: 'Política de privacidade', en: 'Privacy Policy'), onPrivacyTap),
        _buildFooterLink(_t(context, es: 'Quienes somos', gl: 'Quen somos', en: 'About us'), onAboutTap),
        _buildFooterLink(_t(context, es: 'Contáctanos', gl: 'Contacta connosco', en: 'Contact us'), onContactTap),
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
        spacing: 10,
        runSpacing: 10,
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

  Future<void> _openExternalLink(BuildContext context, String rawUrl) async {
    final uri = Uri.parse(rawUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      return;
    }

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_t(context,
            es: 'No se pudo abrir el enlace externo.',
            gl: 'Non se puido abrir a ligazón externa.',
            en: 'Could not open external link.')),
      ),
    );
  }

  String _t(BuildContext context,
      {required String es, required String gl, required String en}) {
    switch (Localizations.localeOf(context).languageCode) {
      case 'gl':
        return gl;
      case 'en':
        return en;
      default:
        return es;
    }
  }
}

// ─────────────────────────────────────────────────────────────
// CLASES AUXILIARES
// ─────────────────────────────────────────────────────────────

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