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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Container(
        height: 58,
        decoration: BoxDecoration(
          color: const Color(0xFF060617),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF060617).withValues(alpha: 0.26),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppConfig.primaryColor.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppConfig.primaryColor.withValues(alpha: 0.35),
                ),
              ),
              child: const Icon(
                Icons.videogame_asset_outlined,
                size: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxWidth < 760;
                  if (compact) {
                    return const SizedBox.shrink();
                  }

                  return Wrap(
                    spacing: 18,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _buildNavLink(
                        _t(context, es: 'Inicio', gl: 'Inicio', en: 'Home'),
                        activeSection == AppSection.inicio,
                        () => onNavigate(AppSection.inicio),
                      ),
                      _buildNavLink(
                        _t(context, es: 'Diccionario', gl: 'Dicionario', en: 'Dictionary'),
                        activeSection == AppSection.diccionario,
                        () => onNavigate(AppSection.diccionario),
                      ),
                      _buildNavLink(
                        _t(context, es: 'Videojuegos', gl: 'Videoxogos', en: 'Games'),
                        activeSection == AppSection.videojuegos,
                        () => onNavigate(AppSection.videojuegos),
                      ),
                      _buildNavLink(
                        _t(context, es: 'Control Parental', gl: 'Control Parental', en: 'Parental Controls'),
                        activeSection == AppSection.controlParental,
                        () => onNavigate(AppSection.controlParental),
                      ),
                      _buildNavLink(
                        _t(context, es: 'Comunidad', gl: 'Comunidade', en: 'Community'),
                        activeSection == AppSection.comunidad,
                        () => onNavigate(AppSection.comunidad),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              width: 290,
              child: TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: onSearchSubmitted,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: _t(context, es: 'Buscar...', gl: 'Buscar...', en: 'Search...'),
                  hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.45),
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 18,
                    color: Colors.white.withValues(alpha: 0.55),
                  ),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.05),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: AppConfig.primaryColor.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            _buildLocaleButton(
              tooltip: 'Español (España)',
              onTap: () => localeProvider.setLocale(const Locale('es')),
              active: currentLanguage == 'es',
              child: _buildSpainFlag(),
            ),
            const SizedBox(width: 8),
            _buildLocaleButton(
              tooltip: 'Galego',
              onTap: () => localeProvider.setLocale(const Locale('gl')),
              active: currentLanguage == 'gl',
              child: _buildGaliciaFlag(),
            ),
            const SizedBox(width: 8),
            _buildLocaleButton(
              tooltip: 'English',
              onTap: () => localeProvider.setLocale(const Locale('en')),
              active: currentLanguage == 'en',
              child: _buildUKFlag(),
            ),
            const SizedBox(width: 8),
            PopupMenuButton<String>(
              icon: UserAvatar(photoUrl: avatarUrl, size: 38),
              onSelected: onMenuSelected,
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'profile',
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text(_t(context, es: 'Editar perfil', gl: 'Editar perfil', en: 'Edit profile')),
                  ),
                ),
                PopupMenuItem(
                  value: 'my_terms',
                  child: ListTile(
                    leading: const Icon(Icons.article_outlined),
                    title: Text(_t(context, es: 'Mis términos propuestos', gl: 'Os meus termos propostos', en: 'My proposed terms')),
                    subtitle: Text(_t(context, es: '$proposedTermsCount términos', gl: '$proposedTermsCount termos', en: '$proposedTermsCount terms')),
                  ),
                ),
                if (isModerator)
                  PopupMenuItem(
                    value: 'moderation',
                    child: ListTile(
                      leading: Icon(Icons.admin_panel_settings),
                      title: Text(_t(context, es: 'Moderación', gl: 'Moderación', en: 'Moderation')),
                    ),
                  ),
                if (isAdmin)
                  PopupMenuItem(
                    value: 'users_management',
                    child: ListTile(
                      leading: Icon(Icons.people),
                      title: Text(_t(context, es: 'Gestión de usuarios', gl: 'Xestión de usuarios', en: 'User management')),
                    ),
                  ),
                const PopupMenuDivider(),
                PopupMenuItem(
                  value: 'logout',
                  child: ListTile(
                    leading: Icon(Icons.logout, color: AppConfig.errorColor),
                    title: Text(_t(context, es: 'Cerrar sesión', gl: 'Pechar sesión', en: 'Sign out')),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildNavLink(String label, bool active, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Text(
          label,
          style: TextStyle(
            color: active ? const Color(0xFF3BF1E0) : const Color(0xFFE7E7E7),
            fontSize: 13,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            shadows: active
                ? const [
                    Shadow(
                      color: Color(0xFF68409F),
                      blurRadius: 8,
                    ),
                  ]
                : null,
          ),
        ),
      ),
    );
  }

  Widget _buildLocaleButton({
    required String tooltip,
    required VoidCallback onTap,
    required bool active,
    required Widget child,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: active
                  ? const Color(0xFF3BF1E0)
                  : Colors.white.withValues(alpha: 0.25),
              width: active ? 1.6 : 1,
            ),
          ),
          child: ClipOval(child: child),
        ),
      ),
    );
  }

  Widget _buildSpainFlag() {
    return Column(
      children: const [
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
            const Positioned.fill(child: ColoredBox(color: Color(0xFF012169))),
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

  String _t(
    BuildContext context, {
    required String es,
    required String gl,
    required String en,
  }) {
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
