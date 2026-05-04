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
import '../../screens/parental_guides/parental_guides_list_screen.dart';
import '../../screens/profile/edit_profile_screen.dart';
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

// persistent_frame.dart

class _PersistentFrameState extends State<PersistentFrame> {
  AppSection _activeSection = AppSection.inicio;
  final GlobalKey<AccountMenuButtonState> headerKey = GlobalKey<AccountMenuButtonState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.currentUser;

    return PersistentFrameScope(
      enabled: true,
      activeSection: _activeSection,
      setActiveSection: _setActiveSection,
      child: SafeArea(
        child: Column(
          children: [
            AppHeader(
              activeSection: _activeSection,
              avatarUrl: user?.photoUrl,
              proposedTermsCount: user?.termsProposed ?? 0,
              isModerator: authProvider.isModerator,
              isAdmin: authProvider.isAdmin,
              isLoggedIn: user != null,
              accountMenuKey: headerKey,

              // Proveemos el contexto del Navigator raíz via getter
              navigatorContextGetter: () =>
                  widget.navigatorKey.currentContext,
              onSearchSubmitted: (_) =>
                  _navigateWithSection(const GamesSearchScreen(), AppSection.videojuegos),
              onNavigate: (section) {
                switch (section) {
                  case AppSection.inicio:
                    final nav = widget.navigatorKey.currentState;
                    if (nav != null) {
                      nav.popUntil((route) => route.isFirst);
                      _setActiveSection(AppSection.inicio);
                    }
                    break;
                  case AppSection.diccionario:
                    _navigateWithSection(const DictionaryListScreen(), section);
                    break;
                  case AppSection.videojuegos:
                    _navigateWithSection(const GamesSearchScreen(), section);
                    break;
                  case AppSection.controlParental:
                    _navigateWithSection(const ParentalGuidesListScreen(), section);
                    break;
                  case AppSection.comunidad:
                    _navigateWithSection(const ForumListScreen(), section);
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
                  case 'login':
                    _navigateTo(const LoginScreen());
                    break;
                  case 'logout':
                    final nav = widget.navigatorKey.currentState;
                    if (nav != null && nav.mounted) {
                      nav.pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (_) => const LoginScreen()),
                        (route) => false,
                      );
                    }
                    authProvider.signOut();
                    break;
                }
              },
            ),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (n) {
                  if (n is ScrollStartNotification) {
                    headerKey.currentState?.closeMenu();
                  }
                  return false;
                },
                child: widget.child,
              ),
            ),
          ],
        ),
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

  void _navigateWithSection(Widget screen, AppSection targetSection) {
    final nav = widget.navigatorKey.currentState;
    if (nav == null || !nav.mounted) return;
    final previousSection = _activeSection;
    _setActiveSection(targetSection);
    nav.push(MaterialPageRoute(builder: (_) => screen)).then((_) {
      if (mounted) {
        _setActiveSection(previousSection);
      }
    });
  }
}