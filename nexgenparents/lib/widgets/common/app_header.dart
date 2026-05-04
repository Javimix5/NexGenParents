import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/app_config.dart';
import '../../providers/locale_provider.dart';
import 'user_avatar.dart';
import '../../l10n/app_localizations.dart';

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
    required this.isLoggedIn,
    required this.onNavigate,
    required this.onSearchSubmitted,
    required this.onMenuSelected,
    this.navigatorContextGetter,
    this.onCloseMenu,
    this.accountMenuKey,
  });

  final AppSection activeSection;
  final String? avatarUrl;
  final int proposedTermsCount;
  final bool isModerator;
  final bool isAdmin;
  final bool isLoggedIn;
  final ValueChanged<AppSection> onNavigate;
  final ValueChanged<String> onSearchSubmitted;
  final ValueChanged<String> onMenuSelected;
  final BuildContext? Function()? navigatorContextGetter;
  final VoidCallback? onCloseMenu;
  final GlobalKey<AccountMenuButtonState>? accountMenuKey;



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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF060617).withOpacity(0.26),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 14.0, sigmaY: 14.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: compact ? 12 : 16,
                      vertical: compact ? 12 : 0,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF060617).withOpacity(0.65), // Fondo translúcido
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.12),
                      ),
                    ),
                    child: compact
                        ? _buildCompactLayout(context, localeProvider, currentLanguage)
                        : _buildWideLayout(context, localeProvider, currentLanguage),
                  ),
                ),
              ),
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
    final l10n = AppLocalizations.of(context);
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
                  label: l10n?.navHome ?? 'Inicio',
                  active: activeSection == AppSection.inicio,
                  onTap: () => onNavigate(AppSection.inicio),
                ),
                const SizedBox(width: 4),
                _buildNavLink(
                  context,
                  label: l10n?.navDictionary ?? 'Diccionario',
                  active: activeSection == AppSection.diccionario,
                  onTap: () => onNavigate(AppSection.diccionario),
                ),
                const SizedBox(width: 4),
                _buildNavLink(
                  context,
                  label: l10n?.navGames ?? 'Videojuegos',
                  active: activeSection == AppSection.videojuegos,
                  onTap: () => onNavigate(AppSection.videojuegos),
                ),
                const SizedBox(width: 4),
                _buildNavLink(
                  context,
                  label: l10n?.navParentalControl ?? 'Control Parental',
                  active: activeSection == AppSection.controlParental,
                  onTap: () => onNavigate(AppSection.controlParental),
                ),
                const SizedBox(width: 4),
                _buildNavLink(
                  context,
                  label: l10n?.navCommunity ?? 'Comunidad',
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
  onTap: () {
    localeProvider.setLocale(const Locale('es'));
  },
  active: currentLanguage == 'es',
  child: _buildSpainFlag(),
),
_buildLocaleButton(
  label: 'Galego',
  onTap: () { 
    localeProvider.setLocale(const Locale('gl'));
  },
  active: currentLanguage == 'gl',
  child: _buildGaliciaFlag(),
),
_buildLocaleButton(
  label: 'English',
  onTap: () {
    localeProvider.setLocale(const Locale('en'));
  },
  active: currentLanguage == 'en',
  child: _buildUKFlag(),
),
          const SizedBox(width: 12),

                    

          AccountMenuButton(
    key: accountMenuKey,
    avatarUrl: avatarUrl,
    proposedTermsCount: proposedTermsCount,
    isModerator: isModerator,
    isAdmin: isAdmin,
    isLoggedIn: isLoggedIn,
    onMenuSelected: onMenuSelected,
    navigatorContextGetter: navigatorContextGetter,
    onCloseMenu: () => accountMenuKey?.currentState?.closeMenu(),
  ),
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
    return _CompactHeaderRow(
      brandMark: _buildBrandMark(),
      navMenu: _buildCompactNavMenu(context),
      localeButtons: [
        _buildLocaleButton(
          label: 'Español (España)',
          onTap: () {
            localeProvider.setLocale(const Locale('es'));
          },
          active: currentLanguage == 'es',
          child: _buildSpainFlag(),
        ),
        _buildLocaleButton(
          label: 'Galego',
          onTap: () {
            localeProvider.setLocale(const Locale('gl'));
          },
          active: currentLanguage == 'gl',
          child: _buildGaliciaFlag(),
        ),
        _buildLocaleButton(
          label: 'English',
          onTap: () {
            localeProvider.setLocale(const Locale('en'));
          },
          active: currentLanguage == 'en',
          child: _buildUKFlag(),
        ),
      ],
      accountMenu: AccountMenuButton(
        key: accountMenuKey,
        avatarUrl: avatarUrl,
        proposedTermsCount: proposedTermsCount,
        isModerator: isModerator,
        isAdmin: isAdmin,
        isLoggedIn: isLoggedIn,
        onMenuSelected: onMenuSelected,
        navigatorContextGetter: navigatorContextGetter,
        onCloseMenu: () => accountMenuKey?.currentState?.closeMenu(),
      ),
      onSearchSubmitted: onSearchSubmitted,
      hintText: AppLocalizations.of(context)?.headerSearchHint ?? 'Buscar...',
    );
  }

  Widget _buildBrandMark() {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: AppConfig.primaryColor.withOpacity(0.18),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppConfig.primaryColor.withOpacity(0.35),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Image.asset(
          'assets/images/logo_principal.png',
          fit: BoxFit.contain,
        ),
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
              AppLocalizations.of(context)?.headerSearchHint ?? 'Buscar...',
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.35),
            fontSize: 13,
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 17,
            color: Colors.white.withOpacity(0.45),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                BorderSide(color: Colors.white.withOpacity(0.08)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                BorderSide(color: Colors.white.withOpacity(0.08)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppConfig.primaryColor.withOpacity(0.8),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompactNavMenu(BuildContext context) {
    return CompactNavMenuButton(
      activeSection: activeSection,
      onNavigate: onNavigate,
      navigatorContextGetter: navigatorContextGetter,
    );
  }

  Widget _buildLocaleButton({
    required String label,
    required VoidCallback onTap,
    required bool active,
    required Widget child,
  }) {
    return TapRegion(
      groupId: 'account_menu',
      child: Semantics(
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
                    : Colors.white.withOpacity(0.25),
                width: active ? 1.8 : 1,
              ),
            ),
            child: ClipOval(child: child),
          ),
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
}

class _CompactHeaderRow extends StatefulWidget {
  const _CompactHeaderRow({
    required this.brandMark,
    required this.navMenu,
    required this.localeButtons,
    required this.accountMenu,
    required this.onSearchSubmitted,
    required this.hintText,
  });

  final Widget brandMark;
  final Widget navMenu;
  final List<Widget> localeButtons;
  final Widget accountMenu;
  final ValueChanged<String> onSearchSubmitted;
  final String hintText;

  @override
  State<_CompactHeaderRow> createState() => _CompactHeaderRowState();
}

class _CompactHeaderRowState extends State<_CompactHeaderRow> {
  bool _isSearchExpanded = false;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!_isSearchExpanded) ...[
          widget.brandMark,
          const SizedBox(width: 12),
          Expanded(child: widget.navMenu),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 22),
            onPressed: () {
              setState(() {
                _isSearchExpanded = true;
              });
              _focusNode.requestFocus();
            },
            padding: const EdgeInsets.symmetric(horizontal: 8),
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 4),
        ] else ...[
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              textInputAction: TextInputAction.search,
              onSubmitted: (val) {
                widget.onSearchSubmitted(val);
                setState(() {
                  _isSearchExpanded = false;
                });
                _controller.clear();
              },
              style: const TextStyle(color: Colors.white, fontSize: 13),
              decoration: InputDecoration(
                isDense: true,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.35),
                  fontSize: 13,
                ),
                prefixIcon: IconButton(
                  icon: const Icon(Icons.arrow_back, size: 17),
                  color: Colors.white.withOpacity(0.8),
                  onPressed: () {
                    setState(() {
                      _isSearchExpanded = false;
                    });
                    _controller.clear();
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppConfig.primaryColor.withOpacity(0.8)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
        ...widget.localeButtons,
        const SizedBox(width: 8),
        widget.accountMenu,
      ],
    );
  }
}

class CompactNavMenuButton extends StatefulWidget {
  const CompactNavMenuButton({
    super.key,
    required this.activeSection,
    required this.onNavigate,
    this.navigatorContextGetter,
  });

  final AppSection activeSection;
  final ValueChanged<AppSection> onNavigate;
  final BuildContext? Function()? navigatorContextGetter;

  @override
  State<CompactNavMenuButton> createState() => _CompactNavMenuButtonState();
}

class _CompactNavMenuButtonState extends State<CompactNavMenuButton> {
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void closeMenu() {
    if (_isOpen) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      if (mounted) {
        setState(() {
          _isOpen = false;
        });
      }
    }
  }

  void _toggleMenu() {
    if (_isOpen) {
      closeMenu();
    } else {
      _showMenu();
    }
  }

  void _showMenu() {
    final navContext = widget.navigatorContextGetter?.call() ?? context;
    final RenderBox overlay =
        Navigator.of(navContext).overlay!.context.findRenderObject()! as RenderBox;
    final RenderBox button = context.findRenderObject()! as RenderBox;

    final Offset offset = button.localToGlobal(Offset.zero, ancestor: overlay);

    _overlayEntry = OverlayEntry(
      builder: (overlayContext) {
        return Positioned(
          top: offset.dy + button.size.height + 8,
          left: offset.dx,
          child: TapRegion(
            groupId: 'nav_menu',
            onTapOutside: (event) {
              closeMenu();
            },
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 200,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _buildMenuItems(context),
                ),
              ),
            ),
          ),
        );
      },
    );

    Navigator.of(navContext).overlay!.insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
  }

  @override
  void didUpdateWidget(CompactNavMenuButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _isOpen) {
          _overlayEntry?.markNeedsBuild();
        }
      });
    }
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  List<Widget> _buildMenuItems(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return [
      _buildMenuItem(
        context,
        text: l10n?.navHome ?? 'Inicio',
        value: AppSection.inicio,
      ),
      _buildMenuItem(
        context,
        text: l10n?.navDictionary ?? 'Diccionario',
        value: AppSection.diccionario,
      ),
      _buildMenuItem(
        context,
        text: l10n?.navGames ?? 'Videojuegos',
        value: AppSection.videojuegos,
      ),
      _buildMenuItem(
        context,
        text: l10n?.navParentalControl ?? 'Control Parental',
        value: AppSection.controlParental,
      ),
      _buildMenuItem(
        context,
        text: l10n?.navCommunity ?? 'Comunidad',
        value: AppSection.comunidad,
      ),
    ];
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String text,
    required AppSection value,
  }) {
    final isActive = widget.activeSection == value;
    final color = isActive ? const Color(0xFF3BF1E0) : Colors.white;

    return InkWell(
      onTap: () {
        // Retraso para que se vea el efecto ripple y evitar el cuelgue en Web
        Future.delayed(const Duration(milliseconds: 120), () {
          closeMenu();
          widget.onNavigate(value);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    String currentSectionName = l10n?.headerMenuBtn ?? 'Menú';
    switch (widget.activeSection) {
      case AppSection.inicio:
        currentSectionName = l10n?.navHome ?? 'Inicio';
        break;
      case AppSection.diccionario:
        currentSectionName = l10n?.navDictionary ?? 'Diccionario';
        break;
      case AppSection.videojuegos:
        currentSectionName = l10n?.navGames ?? 'Videojuegos';
        break;
      case AppSection.controlParental:
        currentSectionName = l10n?.navParentalControl ?? 'Control Parental';
        break;
      case AppSection.comunidad:
        currentSectionName = l10n?.navCommunity ?? 'Comunidad';
        break;
    }

    return TapRegion(
      groupId: 'nav_menu',
      child: InkWell(
        onTap: _toggleMenu,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.menu, color: Colors.white),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  currentSectionName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
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

class AccountMenuButton extends StatefulWidget {
  const AccountMenuButton({
    super.key,
    required this.avatarUrl,
    required this.proposedTermsCount,
    required this.isModerator,
    required this.isAdmin,
    required this.isLoggedIn,
    required this.onMenuSelected,
    this.navigatorContextGetter,
    this.onCloseMenu,
  });

  final String? avatarUrl;
  final int proposedTermsCount;
  final bool isModerator;
  final bool isAdmin;
  final bool isLoggedIn;
  final ValueChanged<String> onMenuSelected;
  final BuildContext? Function()? navigatorContextGetter;
  final VoidCallback? onCloseMenu;

  @override
  State<AccountMenuButton> createState() => AccountMenuButtonState();
}

class AccountMenuButtonState extends State<AccountMenuButton> {
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void closeMenu() {
    if (_isOpen) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      if (mounted) {
        setState(() {
          _isOpen = false;
        });
      }
    }
  }

  void _toggleMenu() {
    if (!widget.isLoggedIn) {
      widget.onMenuSelected('login');
      return;
    }

    if (_isOpen) {
      closeMenu();
    } else {
      _showMenu();
    }
  }

  void _showMenu() {
    final navContext = widget.navigatorContextGetter?.call() ?? context;
    final RenderBox overlay =
        Navigator.of(navContext).overlay!.context.findRenderObject()! as RenderBox;
    final RenderBox button = context.findRenderObject()! as RenderBox;

    final Offset offset = button.localToGlobal(Offset.zero, ancestor: overlay);

    _overlayEntry = OverlayEntry(
      builder: (overlayContext) {
        return Positioned(
          top: offset.dy + button.size.height + 12,
          right: overlay.size.width - offset.dx - button.size.width,
          child: TapRegion(
            groupId: 'account_menu',
            onTapOutside: (event) {
              closeMenu();
            },
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 240,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _buildMenuItems(context),
                ),
              ),
            ),
          ),
        );
      },
    );

    Navigator.of(navContext).overlay!.insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
  }

  @override
  void didUpdateWidget(AccountMenuButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _isOpen) {
          _overlayEntry?.markNeedsBuild();
        }
      });
    }
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoggedIn) {
      final l10n = AppLocalizations.of(context);
      final isCompact = MediaQuery.of(context).size.width < 1100;

      if (isCompact) {
        return InkWell(
          onTap: () => widget.onMenuSelected('login'),
          borderRadius: BorderRadius.circular(999),
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppConfig.primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.login, color: Colors.white, size: 18),
          ),
        );
      }

      return ElevatedButton.icon(
        onPressed: () => widget.onMenuSelected('login'),
        icon: const Icon(Icons.login, size: 16),
        label: Text(l10n?.loginBtn ?? 'Iniciar sesión'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConfig.primaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(0, 38),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      );
    }

    return TapRegion(
      groupId: 'account_menu',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: _toggleMenu,
          child: UserAvatar(photoUrl: widget.avatarUrl, size: 38),
        ),
      ),
    );
  }

  List<Widget> _buildMenuItems(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = <Widget>[
      _buildMenuItem(
        context,
        icon: Icons.person,
        text: l10n?.accountMenuProfile ?? 'Mi perfil',
        value: 'profile',
      ),
      _buildMenuItem(
        context,
        icon: Icons.list_alt,
        text: l10n?.accountMenuMyTerms ?? 'Mis términos propuestos',
        subtitle: l10n?.accountMenuTermsCount(widget.proposedTermsCount) ?? '${widget.proposedTermsCount} términos',
        value: 'my_terms',
      ),
    ];

    if (widget.isModerator) {
      items.add(_buildMenuItem(
        context,
        icon: Icons.admin_panel_settings,
        text: l10n?.accountMenuModeration ?? 'Moderación',
        value: 'moderation',
      ));
    }

    if (widget.isAdmin) {
      items.add(_buildMenuItem(
        context,
        icon: Icons.people,
        text: l10n?.accountMenuUsers ?? 'Gestión de usuarios',
        value: 'users_management',
      ));
    }

    items.add(Divider(color: Colors.white.withOpacity(0.1), height: 16));
    items.add(_buildMenuItem(
      context,
      icon: Icons.logout,
      text: l10n?.accountMenuLogout ?? 'Cerrar sesión',
      color: const Color(0xFFEF4444),
      value: 'logout',
    ));

    return items;
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    String? subtitle,
    Color color = Colors.white70,
    required String value,
  }) {
    return InkWell(
      onTap: () {
        // Retraso para que se vea el efecto ripple y evitar el cuelgue en Web
        Future.delayed(const Duration(milliseconds: 120), () {
          closeMenu();
          widget.onMenuSelected(value);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: color == Colors.white70 ? Colors.white : color,
                      fontSize: 14,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(color: Colors.white54, fontSize: 11),
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}