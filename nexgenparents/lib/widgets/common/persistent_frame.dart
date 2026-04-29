import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../screens/admin/users_management_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/dictionary/dictionary_list_screen.dart';
import '../../screens/dictionary/moderation_screen.dart';
import '../../screens/dictionary/my_proposed_terms_screen.dart';
import '../../screens/forum/forum_list_screen.dart';
import '../../screens/games/games_search_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/info/pegi_info_screen.dart';
import '../../screens/parental_guides/parental_guides_list_screen.dart';
import '../../screens/profile/edit_profile_screen.dart';
import 'app_footer.dart';
import 'app_header.dart';

class PersistentFrameScope extends InheritedWidget {
  const PersistentFrameScope({
    super.key,
    required this.enabled,
    required this.activeSection,
    required this.setActiveSection,
    required super.child,
  });

  final bool enabled;
  final AppSection activeSection;
  final ValueChanged<AppSection> setActiveSection;

  static bool of(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<PersistentFrameScope>()
            ?.enabled ??
        false;
  }

  static AppSection? activeSectionOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<PersistentFrameScope>()
        ?.activeSection;
  }

  static void setSection(BuildContext context, AppSection section) {
    final scope = context
            .getElementForInheritedWidgetOfExactType<PersistentFrameScope>()
            ?.widget as PersistentFrameScope?;
    scope?.setActiveSection(section);
  }

  @override
  bool updateShouldNotify(PersistentFrameScope oldWidget) {
    return enabled != oldWidget.enabled ||
        activeSection != oldWidget.activeSection;
  }
}

class PersistentFrame extends StatefulWidget {
  const PersistentFrame({
    super.key,
    required this.navigatorKey,
    required this.child,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final Widget child;

  @override
  State<PersistentFrame> createState() => _PersistentFrameState();
}

class _PersistentFrameState extends State<PersistentFrame> {
  AppSection _activeSection = AppSection.inicio;

  // Clave para el Overlay local que provee contexto a Header y Footer
  final _overlayKey = GlobalKey<OverlayState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.currentUser;

    return PersistentFrameScope(
      enabled: true,
      activeSection: _activeSection,
      setActiveSection: _setActiveSection,
      // ✅ Overlay propio para Header y Footer
      child: Overlay(
        key: _overlayKey,
        initialEntries: [
          OverlayEntry(
            builder: (overlayContext) => SafeArea(
              child: Column(
                children: [
                  // ✅ AppHeader ahora tiene Overlay disponible
                  AppHeader(
                    activeSection: _activeSection,
                    avatarUrl: user?.photoUrl,
                    proposedTermsCount: user?.termsProposed ?? 0,
                    isModerator: authProvider.isModerator,
                    isAdmin: authProvider.isAdmin,
                    onSearchSubmitted: (_) =>
                        _navigateTo(const GamesSearchScreen()),
                    onNavigate: (section) {
                      _setActiveSection(section);
                      switch (section) {
                        case AppSection.inicio:
                          _navigateTo(const HomeScreen());
                          break;
                        case AppSection.diccionario:
                          _navigateTo(const DictionaryListScreen());
                          break;
                        case AppSection.videojuegos:
                          _navigateTo(const GamesSearchScreen());
                          break;
                        case AppSection.controlParental:
                          _navigateTo(const ParentalGuidesListScreen());
                          break;
                        case AppSection.comunidad:
                          _navigateTo(const ForumListScreen());
                          break;
                      }
                    },
                    onMenuSelected: (value) async {
                      switch (value) {
                        case 'profile':
                          _navigateTo(const EditProfileScreen());
                          break;
                        case 'my_terms':
                          _navigateTo(const MyProposedTermsScreen());
                          break;
                        case 'moderation':
                          if (authProvider.isModerator) {
                            _navigateTo(const ModerationScreen());
                          }
                          break;
                        case 'users_management':
                          if (authProvider.isAdmin) {
                            _navigateTo(const UsersManagementScreen());
                          }
                          break;
                        case 'logout':
                          await authProvider.signOut();
                          final nav = widget.navigatorKey.currentState;
                          if (nav == null || !nav.mounted) return;
                          nav.pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()),
                            (route) => false,
                          );
                          break;
                      }
                    },
                  ),
                  // ✅ Contenido principal (Navigator)
                  Expanded(child: widget.child),
                  // ✅ AppFooter ahora tiene Overlay disponible
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: AppFooter(
                      onPrivacyTap: () => _navigateTo(const PegiInfoScreen()),
                      onAboutTap: () => _navigateTo(const PegiInfoScreen()),
                      onContactTap: () =>
                          _navigateTo(const ParentalGuidesListScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _setActiveSection(AppSection section) {
    if (_activeSection == section) return;
    setState(() => _activeSection = section);
  }

  void _navigateTo(Widget screen) {
    final nav = widget.navigatorKey.currentState;
    if (nav == null || !nav.mounted) return;
    nav.push(MaterialPageRoute(builder: (_) => screen));
  }
}