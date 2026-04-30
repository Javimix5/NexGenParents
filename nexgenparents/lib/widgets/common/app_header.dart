import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/app_config.dart';
import '../../providers/locale_provider.dart';
import 'user_avatar.dart';

enum AppSection {
  inicio,
  diccionario,
  videojuegos,
  controlParental,
  comunidad,
}


class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.activeSection,
    required this.avatarUrl,
    required this.proposedTermsCount,
    required this.isModerator,
    required this.isAdmin,
    required this.onNavigate,
    required this.onSearchSubmitted,
    required this.onMenuSelected,
  });

  final AppSection activeSection;
  final String? avatarUrl;
  final int proposedTermsCount;
  final bool isModerator;
  final bool isAdmin;
  final ValueChanged<AppSection> onNavigate;
  final ValueChanged<String> onSearchSubmitted;
  final ValueChanged<String> onMenuSelected;

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();
    final currentLanguage = localeProvider.locale?.languageCode ?? 'es';

    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 1100;

            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: compact ? 12 : 16,
                vertical: compact ? 12 : 0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF060617),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF060617).withValues(alpha: 0.26),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: compact
                  ? _buildCompactLayout(context, localeProvider, currentLanguage)
                  : _buildWideLayout(context, localeProvider, currentLanguage),
            );
          },
        ),
      ),
    );
  }

  // ───────────────────────
  // LAYOUT ANCHO (≥ 1100px)
  // ───────────────────────
  Widget _buildWideLayout(
    BuildContext context,
    LocaleProvider localeProvider,
    String currentLanguage,
  ) {
    return SizedBox(
      height: 58,
      child: Row(
        children: [
          _buildBrandMark(),
          const SizedBox(width: 24),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildNavLink(
                  context,
                  label: _t(context, es: 'Inicio', gl: 'Inicio', en: 'Home'),
                  active: activeSection == AppSection.inicio,
                  onTap: () => onNavigate(AppSection.inicio),
                ),
                const SizedBox(width: 4),
                _buildNavLink(
                  context,
                  label: _t(context,
                      es: 'Diccionario',
                      gl: 'Dicionario',
                      en: 'Dictionary'),
                  active: activeSection == AppSection.diccionario,
                  onTap: () => onNavigate(AppSection.diccionario),
                ),
                const SizedBox(width: 4),
                _buildNavLink(
                  context,
                  label: _t(context,
                      es: 'Videojuegos',
                      gl: 'Videoxogos',
                      en: 'Game Search'),
                  active: activeSection == AppSection.videojuegos,
                  onTap: () => onNavigate(AppSection.videojuegos),
                ),
                const SizedBox(width: 4),
                _buildNavLink(
                  context,
                  label: _t(context,
                      es: 'Control Parental',
                      gl: 'Control Parental',
                      en: 'Parental Control'),
                  active: activeSection == AppSection.controlParental,
                  onTap: () => onNavigate(AppSection.controlParental),
                ),
                const SizedBox(width: 4),
                _buildNavLink(
                  context,
                  label: _t(context,
                      es: 'Comunidad',
                      gl: 'Comunidade',
                      en: 'Community'),
                  active: activeSection == AppSection.comunidad,
                  onTap: () => onNavigate(AppSection.comunidad),
                ),
              ],
            ),
          ),

          _buildSearchField(context),
          const SizedBox(width: 12),

          // Banderas de idioma
          _buildLocaleButton(
            label: 'Español (España)',
            onTap: () => localeProvider.setLocale(const Locale('es')),
            active: currentLanguage == 'es',
            child: _buildSpainFlag(),
          ),
          const SizedBox(width: 6),
          _buildLocaleButton(
            label: 'Galego',
            onTap: () => localeProvider.setLocale(const Locale('gl')),
            active: currentLanguage == 'gl',
            child: _buildGaliciaFlag(),
          ),
          const SizedBox(width: 6),
          _buildLocaleButton(
            label: 'English',
            onTap: () => localeProvider.setLocale(const Locale('en')),
            active: currentLanguage == 'en',
            child: _buildUKFlag(),
          ),
          const SizedBox(width: 10),

          _AccountMenuButton(
            avatarUrl: avatarUrl,
            proposedTermsCount: proposedTermsCount,
            isModerator: isModerator,
            isAdmin: isAdmin,
            onMenuSelected: onMenuSelected,
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────
  // LAYOUT COMPACTO (< 1100px)
  // ──────────────────────────────────────────────
  Widget _buildCompactLayout(
    BuildContext context,
    LocaleProvider localeProvider,
    String currentLanguage,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            _buildBrandMark(),
            const SizedBox(width: 12),
            Expanded(child: _buildCompactNavMenu(context)),
            const SizedBox(width: 8),
            _buildLocaleButton(
              label: 'Español (España)',
              onTap: () => localeProvider.setLocale(const Locale('es')),
              active: currentLanguage == 'es',
              child: _buildSpainFlag(),
            ),
            const SizedBox(width: 6),
            _buildLocaleButton(
              label: 'Galego',
              onTap: () => localeProvider.setLocale(const Locale('gl')),
              active: currentLanguage == 'gl',
              child: _buildGaliciaFlag(),
            ),
            const SizedBox(width: 6),
            _buildLocaleButton(
              label: 'English',
              onTap: () => localeProvider.setLocale(const Locale('en')),
              active: currentLanguage == 'en',
              child: _buildUKFlag(),
            ),
            const SizedBox(width: 8),

            _AccountMenuButton(
              avatarUrl: avatarUrl,
              proposedTermsCount: proposedTermsCount,
              isModerator: isModerator,
              isAdmin: isAdmin,
              onMenuSelected: onMenuSelected,
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildSearchField(context, expanded: true),
      ],
    );
  }

  Widget _buildBrandMark() {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: AppConfig.primaryColor.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppConfig.primaryColor.withValues(alpha: 0.35),
        ),
      ),
      child: const Icon(
        Icons.videogame_asset_outlined,
        size: 20,
        color: Colors.white,
      ),
    );
  }

  /// Nav link con indicador activo (color + subrayado)
  Widget _buildNavLink(
    BuildContext context, {
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: active
                    ? const Color(0xFF3BF1E0)
                    : const Color(0xFFCBD5E1),
                fontSize: 13.5,
                fontWeight:
                    active ? FontWeight.w700 : FontWeight.w500,
                letterSpacing: active ? 0.2 : 0,
              ),
            ),
            const SizedBox(height: 2),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: active ? 24 : 0,
              decoration: BoxDecoration(
                color: const Color(0xFF3BF1E0),
                borderRadius: BorderRadius.circular(999),
                boxShadow: active
                    ? [
                        const BoxShadow(
                          color: Color(0xFF3BF1E0),
                          blurRadius: 6,
                        )
                      ]
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context, {bool expanded = false}) {
    return SizedBox(
      width: expanded ? double.infinity : 220,
      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: onSearchSubmitted,
        style: const TextStyle(color: Colors.white, fontSize: 13),
        decoration: InputDecoration(
          isDense: true,
          hintText:
              _t(context, es: 'Buscar...', gl: 'Buscar...', en: 'Search forum...'),
          hintStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.35),
            fontSize: 13,
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 17,
            color: Colors.white.withValues(alpha: 0.45),
          ),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.05),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                BorderSide(color: Colors.white.withValues(alpha: 0.08)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                BorderSide(color: Colors.white.withValues(alpha: 0.08)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppConfig.primaryColor.withValues(alpha: 0.8),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompactNavMenu(BuildContext context) {
    return PopupMenuButton<AppSection>(
      onSelected: onNavigate,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: AppSection.inicio,
          child: Text(_t(context, es: 'Inicio', gl: 'Inicio', en: 'Home')),
        ),
        PopupMenuItem(
          value: AppSection.diccionario,
          child: Text(_t(context,
              es: 'Diccionario', gl: 'Dicionario', en: 'Dictionary')),
        ),
        PopupMenuItem(
          value: AppSection.videojuegos,
          child: Text(_t(context,
              es: 'Videojuegos', gl: 'Videoxogos', en: 'Games')),
        ),
        PopupMenuItem(
          value: AppSection.controlParental,
          child: Text(_t(context,
              es: 'Control Parental',
              gl: 'Control Parental',
              en: 'Parental Controls')),
        ),
        PopupMenuItem(
          value: AppSection.comunidad,
          child: Text(_t(context,
              es: 'Comunidad', gl: 'Comunidade', en: 'Community')),
        ),
      ],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.menu, color: Colors.white),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              _t(context, es: 'Menú', gl: 'Menú', en: 'Menu'),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocaleButton({
    required String label,
    required VoidCallback onTap,
    required bool active,
    required Widget child,
  }) {
    return Semantics(
      label: label,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: active
                  ? const Color(0xFF3BF1E0)
                  : Colors.white.withValues(alpha: 0.25),
              width: active ? 1.8 : 1,
            ),
          ),
          child: ClipOval(child: child),
        ),
      ),
    );
  }

  Widget _buildSpainFlag() {
    return const Column(
      children: [
        Expanded(child: ColoredBox(color: Color(0xFFAA151B))),
        Expanded(flex: 2, child: ColoredBox(color: Color(0xFFF1BF00))),
        Expanded(child: ColoredBox(color: Color(0xFFAA151B))),
      ],
    );
  }

  Widget _buildGaliciaFlag() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            const Positioned.fill(child: ColoredBox(color: Colors.white)),
            Positioned.fill(
              child: Transform.rotate(
                angle: -0.55,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.34,
                  ),
                  color: const Color(0xFF2A66B8),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildUKFlag() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            const Positioned.fill(
                child: ColoredBox(color: Color(0xFF012169))),
            Positioned(
              top: constraints.maxHeight * 0.4,
              left: 0,
              right: 0,
              height: constraints.maxHeight * 0.2,
              child: const ColoredBox(color: Colors.white),
            ),
            Positioned(
              left: constraints.maxWidth * 0.4,
              top: 0,
              bottom: 0,
              width: constraints.maxWidth * 0.2,
              child: const ColoredBox(color: Colors.white),
            ),
            Positioned(
              top: constraints.maxHeight * 0.44,
              left: 0,
              right: 0,
              height: constraints.maxHeight * 0.12,
              child: const ColoredBox(color: Color(0xFFC8102E)),
            ),
            Positioned(
              left: constraints.maxWidth * 0.44,
              top: 0,
              bottom: 0,
              width: constraints.maxWidth * 0.12,
              child: const ColoredBox(color: Color(0xFFC8102E)),
            ),
          ],
        );
      },
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

class _AccountMenuButton extends StatelessWidget {
  const _AccountMenuButton({
    required this.avatarUrl,
    required this.proposedTermsCount,
    required this.isModerator,
    required this.isAdmin,
    required this.onMenuSelected,
  });

  final String? avatarUrl;
  final int proposedTermsCount;
  final bool isModerator;
  final bool isAdmin;
  final ValueChanged<String> onMenuSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onMenuSelected,
      offset: const Offset(0, 46),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: const Color(0xFF1E293B),
      itemBuilder: _buildItems,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          UserAvatar(photoUrl: avatarUrl, size: 34),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down,
              color: Colors.white54, size: 16),
        ],
      ),
    );
  }

  List<PopupMenuEntry<String>> _buildItems(BuildContext context) {
    final items = <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        value: 'profile',
        child: ListTile(
          dense: true,
          leading: const Icon(Icons.person, color: Colors.white70),
          title: Text(
            _t(context,
                es: 'Editar perfil',
                gl: 'Editar perfil',
                en: 'Edit profile'),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      PopupMenuItem<String>(
        value: 'my_terms',
        child: ListTile(
          dense: true,
          leading:
              const Icon(Icons.article_outlined, color: Colors.white70),
          title: Text(
            _t(context,
                es: 'Mis términos propuestos',
                gl: 'Os meus termos propostos',
                en: 'My proposed terms'),
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            _t(context,
                es: '$proposedTermsCount términos',
                gl: '$proposedTermsCount termos',
                en: '$proposedTermsCount terms'),
            style: const TextStyle(color: Colors.white54, fontSize: 11),
          ),
        ),
      ),
    ];

    if (isModerator) {
      items.add(PopupMenuItem<String>(
        value: 'moderation',
        child: ListTile(
          dense: true,
          leading: const Icon(Icons.admin_panel_settings,
              color: Colors.white70),
          title: Text(
            _t(context,
                es: 'Moderación', gl: 'Moderación', en: 'Moderation'),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ));
    }

    if (isAdmin) {
      items.add(PopupMenuItem<String>(
        value: 'users_management',
        child: ListTile(
          dense: true,
          leading: const Icon(Icons.people, color: Colors.white70),
          title: Text(
            _t(context,
                es: 'Gestión de usuarios',
                gl: 'Xestión de usuarios',
                en: 'User management'),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ));
    }

    items.addAll([
      const PopupMenuDivider(),
      PopupMenuItem<String>(
        value: 'logout',
        child: ListTile(
          dense: true,
          leading: const Icon(Icons.logout, color: Color(0xFFEF4444)),
          title: Text(
            _t(context,
                es: 'Cerrar sesión',
                gl: 'Pechar sesión',
                en: 'Sign out'),
            style: const TextStyle(color: Color(0xFFEF4444)),
          ),
        ),
      ),
    ]);

    return items;
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