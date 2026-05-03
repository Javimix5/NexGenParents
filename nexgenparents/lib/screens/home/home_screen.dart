import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/app_config.dart';
import '../../models/forum_post_model.dart';
import '../../models/forum_section.dart';
import '../../models/user_model.dart';
import '../../models/game_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/dictionary_provider.dart';
import '../../providers/forum_provider.dart';
import '../../providers/games_provider.dart';
import '../../widgets/common/app_footer.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/common/app_header.dart';
import '../../widgets/common/persistent_frame.dart';
import '../../widgets/common/user_avatar.dart';
import '../admin/users_management_screen.dart';
import '../auth/login_screen.dart';
import '../dictionary/dictionary_list_screen.dart';
import '../dictionary/moderation_screen.dart';
import '../dictionary/my_proposed_terms_screen.dart';
import '../forum/forum_list_screen.dart';
import '../forum/forum_category_posts_screen.dart';
import '../games/game_detail_screen.dart';
import '../games/games_search_screen.dart';
import '../parental_guides/parental_guides_list_screen.dart';
import '../profile/edit_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<int>? _userMessagesCountFuture;
  String? _lastUserId;
  final GlobalKey<AccountMenuButtonState> _accountMenuKey = GlobalKey<AccountMenuButtonState>();
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;

  void _closeUserMenu(BuildContext context) {
    _accountMenuKey.currentState?.closeMenu();
  }

  // Validación de acceso a pantallas protegidas
  bool _requireLogin(BuildContext context, {String? customMessage}) {
    final user = Provider.of<AuthProvider>(context, listen: false).currentUser;
    if (user == null) {
      final l10n = AppLocalizations.of(context);
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l10n?.dictModAccessDeniedTitle ?? 'Acceso restringido'),
          content: Text(customMessage ?? l10n?.alertLoginRequiredForum ?? 'Debes iniciar sesión para acceder a la comunidad y participar en el foro.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n?.adminCancelBtn ?? 'Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
              child: Text(l10n?.loginBtn ?? 'Iniciar sesión'),
            ),
          ],
        ),
      );
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;
      if (_scrollController.offset >= 400 && !_showBackToTopButton) {
        setState(() => _showBackToTopButton = true);
      } else if (_scrollController.offset < 400 && _showBackToTopButton) {
        setState(() => _showBackToTopButton = false);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dictionaryProvider =
          Provider.of<DictionaryProvider>(context, listen: false);
      final gamesProvider = Provider.of<GamesProvider>(context, listen: false);
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      // Cargamos datos iniciales solo si están vacíos para evitar llamadas redundantes de red
      if (dictionaryProvider.approvedTerms.isEmpty) {
        dictionaryProvider.loadApprovedTerms();
      }
      if (gamesProvider.popularGames.isEmpty) {
        gamesProvider.loadCurrentMonthGames();
        gamesProvider.loadWeeklyTopGame();
      }

      final user = authProvider.currentUser;
      if (user != null) {
        dictionaryProvider.loadUserProposedTerms(user.id);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authProvider = Provider.of<AuthProvider>(context);
    final forumProvider = Provider.of<ForumProvider>(context);

    final user = authProvider.currentUser;

    if (user?.id != _lastUserId) {
      _lastUserId = user?.id;
      if (user != null) {
        _userMessagesCountFuture =
            forumProvider.getUserCommunityMessagesCount(user.id);
      } else {
        _userMessagesCountFuture = Future.value(0);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: _buildBody(context),
    floatingActionButton: _showBackToTopButton
        ? FloatingActionButton(
            heroTag: 'home_back_to_top_btn', // Etiqueta única para evitar colisiones
            onPressed: () {
              if (_scrollController.hasClients) {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            },
            backgroundColor: AppConfig.primaryColor,
            foregroundColor: Colors.white,
            mini: true,
            child: const Icon(Icons.arrow_upward),
          )
        : null,
  );
}

Widget _buildBody(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: isDark
            ? const [Color(0xFF0A0F1E), Color(0xFF141B2E)]
            : const [Color(0xFFF7F8FC), Color(0xFFFFFFFF)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: Column(
      children: [
        _buildHeader(context),
        _buildMainContent(context),
      ],
    ),
  );
}

Widget _buildHeader(BuildContext context) {
  final hasPersistentFrame = PersistentFrameScope.of(context);
  final authProvider = Provider.of<AuthProvider>(context);
  final proposedTermsCount = authProvider.currentUser?.termsProposed ?? 0;
  
  if (!hasPersistentFrame) {
    return AppHeader(
      activeSection: AppSection.inicio,
      avatarUrl: authProvider.currentUser?.photoUrl,
      proposedTermsCount: proposedTermsCount,
      isModerator: authProvider.isModerator,
      isAdmin: authProvider.isAdmin,
      accountMenuKey: _accountMenuKey,
      onSearchSubmitted: (_) =>
          _navigateTo(context, const GamesSearchScreen()),
      onNavigate: (section) => _handleNavigation(context, section),
      onMenuSelected: (value) =>
          _handleMenuAction(context, authProvider, value),
    );
  }
  return const SizedBox.shrink();
}

Widget _buildMainContent(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final horizontalPadding = screenWidth < 600
      ? 12.0
      : screenWidth < 1100
          ? 16.0
          : 24.0;
  final contentMaxWidth = screenWidth < 980 ? double.infinity : 1440.0;

  return Expanded(
    child: NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollStartNotification) {
          _closeUserMenu(context);
        }
        return false;
      },
    child: SingleChildScrollView(
      controller: _scrollController,
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        24,
        horizontalPadding,
        24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: contentMaxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeroSection(context),
              const SizedBox(height: 28),
              _buildQuickAccessSection(context),
              const SizedBox(height: 28),
              _buildFeaturedGameAndUpdates(context),
              const SizedBox(height: 28),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    ),
    ),
  );
}

Widget _buildHeroSection(BuildContext context) {
  final authProvider = Provider.of<AuthProvider>(context);
  final user = authProvider.currentUser;
  final l10n = AppLocalizations.of(context);
  
  if (user == null) {
    return _buildGuestHero(context);
  }

  return FutureBuilder<int>(
    future: _userMessagesCountFuture,
    builder: (context, snapshot) {
      final messagesCount = snapshot.data;
      final userLevel = _getCommunityLevel(context, user, messagesCount);

      return _buildHero(
        context,
                userName: user.displayName.isNotEmpty ? user.displayName : (l10n?.homeDefaultUser ?? 'Usuario'),
                approvedTermsCount: user.termsApproved,
                proposedTermsCount: user.termsProposed,
        userLevel: userLevel,
        totalActiveTerms:
            Provider.of<DictionaryProvider>(context).approvedTerms.length,
                avatarUrl: user.photoUrl,
      );
    },
  );
}

Widget _buildQuickAccessSection(BuildContext context) {
  final l10n = AppLocalizations.of(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _buildSectionHeader(
        context,
        title: l10n?.homeQuickAccessTitle ?? 'Acceso rápido',
        subtitle: l10n?.homeQuickAccessSubtitle ?? 'Acceso a las zonas de la web más usadas',
      ),
      const SizedBox(height: 16),
      _buildQuickActions(context),
    ],
  );
}

Widget _buildFeaturedGameAndUpdates(BuildContext context) {
  final gamesProvider = Provider.of<GamesProvider>(context);
  final featuredGame = gamesProvider.weeklyTopGame ?? 
      (gamesProvider.popularGames.isNotEmpty ? gamesProvider.popularGames.first : null);
  final isLoading = gamesProvider.isLoading;

  return LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth < 960) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildGameFeature(context, featuredGame, isLoading),
            const SizedBox(height: 20),
            _buildUpdatesPanel(context),
          ],
        );
      }

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 3,
                      child: _buildGameFeature(context, featuredGame, isLoading),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 2,
                      child: _buildUpdatesPanel(context),
                    ),
                  ],
                ),
              );
    },
  );
}

Widget _buildFooter(BuildContext context) {
    return const AppFooter();
}

void _handleNavigation(BuildContext context, AppSection section) {
  switch (section) {
    case AppSection.inicio:
      break;
    case AppSection.diccionario:
      _navigateTo(context, const DictionaryListScreen());
      break;
    case AppSection.videojuegos:
      _navigateTo(context, const GamesSearchScreen());
      break;
    case AppSection.controlParental:
      _navigateTo(context, const ParentalGuidesListScreen());
      break;
    case AppSection.comunidad:
      if (_requireLogin(context)) {
        _navigateTo(context, const ForumListScreen());
      }
      break;
  }
}

  Widget _buildHero(
    BuildContext context, {
    required String userName,
    required int approvedTermsCount,
    required int proposedTermsCount,
    required String userLevel,
    required int totalActiveTerms,
    required String? avatarUrl,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: theme.dividerColor.withOpacity(0.35)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0B1020).withOpacity(0.06),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _navigateTo(context, const EditProfileScreen()),
          borderRadius: BorderRadius.circular(28),
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final vertical = constraints.maxWidth < 760;
                if (vertical) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: 'profile_avatar',
                        child: UserAvatar(photoUrl: avatarUrl, size: 70),
                      ),
                      const SizedBox(height: 18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n?.homeWelcomeUser(userName) ?? 'Bienvenido, $userName!',
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            l10n?.homeUserStats(approvedTermsCount, proposedTermsCount) ?? 'Tienes $approvedTermsCount términos aprobados y $proposedTermsCount términos propuestos.',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppConfig.textSecondaryColor,
                                  height: 1.35,
                                ),
                          ),
                          const SizedBox(height: 14),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              _buildBadge(
                                text: userLevel,
                                background: isDark
                                    ? const Color(0xFF392B53)
                                    : const Color(0xFFF3E8FF),
                                foreground: isDark
                                    ? const Color(0xFFE2D5FF)
                                    : const Color(0xFF8B5CF6),
                              ),
                              _buildBadge(
                                text: l10n?.homeActiveTerms(totalActiveTerms) ?? '$totalActiveTerms términos activos',
                                background: isDark
                                    ? const Color(0xFF1E3A33)
                                    : const Color(0xFFEAFBF3),
                                foreground: isDark
                                    ? const Color(0xFFA7F3D0)
                                    : const Color(0xFF059669),
                              ),
                            ],
                          ),
                  ],
                ),
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: 'profile_avatar',
                child: UserAvatar(photoUrl: avatarUrl, size: 70),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n?.homeWelcomeUser(userName) ?? 'Bienvenido, $userName!',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n?.homeUserStats(approvedTermsCount, proposedTermsCount) ?? 'Tienes $approvedTermsCount términos aprobados y $proposedTermsCount términos propuestos.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppConfig.textSecondaryColor,
                            height: 1.35,
                          ),
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _buildBadge(
                          text: userLevel,
                          background: isDark
                              ? const Color(0xFF392B53)
                              : const Color(0xFFF3E8FF),
                          foreground: isDark
                              ? const Color(0xFFE2D5FF)
                              : const Color(0xFF8B5CF6),
                        ),
                        _buildBadge(
                          text: l10n?.homeActiveTerms(totalActiveTerms) ?? '$totalActiveTerms términos activos',
                          background: isDark
                              ? const Color(0xFF1E3A33)
                              : const Color(0xFFEAFBF3),
                          foreground: isDark
                              ? const Color(0xFFA7F3D0)
                              : const Color(0xFF059669),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
            ),
          ),
        ),
      );
  }

  Widget _buildGuestHero(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: theme.dividerColor.withOpacity(0.35)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0B1020).withOpacity(0.06),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final vertical = constraints.maxWidth < 760;
              final content = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n?.homeWelcomeGuest ?? '¡Bienvenido a NexGen Parents!',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n?.homeGuestDescription ?? 'Tu guía definitiva sobre videojuegos. Descubre clasificaciones por edad, explora nuestro diccionario de términos gaming y aprende a configurar controles parentales.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppConfig.textSecondaryColor,
                          height: 1.35,
                        ),
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                    icon: const Icon(Icons.login),
                    label: Text(l10n?.loginBtn ?? 'Iniciar sesión'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              );

              if (vertical) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                      child: const Hero(
                        tag: 'profile_avatar',
                        child: UserAvatar(photoUrl: null, size: 70),
                      ),
                    ),
                    const SizedBox(height: 18),
                    content,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                    child: const Hero(
                      tag: 'profile_avatar',
                      child: UserAvatar(photoUrl: null, size: 70),
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(child: content),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final actions = [
      _QuickActionData(
        title: l10n?.homeQuickActionGamesTitle ?? 'Buscar juegos por edad',
        subtitle: l10n?.homeQuickActionGamesSubtitle ?? 'Busca los juegos adecuados según la edad de tu hijo',
        icon: Icons.visibility_outlined,
        tint: const Color(0xFF22C1DC),
        onTap: () => _navigateTo(
          context,
          const GamesSearchScreen(),
          section: AppSection.videojuegos,
        ),
      ),
      _QuickActionData(
        title: l10n?.homeQuickActionDictTitle ?? 'Busca términos en el diccionario',
        subtitle: l10n?.homeQuickActionDictSubtitle ?? 'Descubre qué significan las palabras que usa tu hijo cuando juega',
        icon: Icons.translate_outlined,
        tint: const Color(0xFFA855F7),
        onTap: () => _navigateTo(
          context,
          const DictionaryListScreen(),
          section: AppSection.diccionario,
        ),
      ),
      _QuickActionData(
        title: l10n?.homeQuickActionGuidesTitle ?? 'Configurar Control Parental',
        subtitle: l10n?.homeQuickActionGuidesSubtitle ?? 'Configura los límites de edad y uso según la plataforma',
        icon: Icons.tune_outlined,
        tint: const Color(0xFF0EA5E9),
        onTap: () => _navigateTo(
          context,
          const ParentalGuidesListScreen(),
          section: AppSection.controlParental,
        ),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 940;

        if (isNarrow) {
          return Column(
            children: [
              for (final action in actions) ...[
                _buildQuickActionCard(context, action),
                const SizedBox(height: 14),
              ],
            ],
          );
        }

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var index = 0; index < actions.length; index++) ...[
                Expanded(child: _buildQuickActionCard(context, actions[index])),
                if (index < actions.length - 1) const SizedBox(width: 16),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickActionCard(BuildContext context, _QuickActionData action) {
    final theme = Theme.of(context);

    return Material(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: action.onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          constraints: const BoxConstraints(minHeight: 132),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: theme.dividerColor.withOpacity(0.35)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0B1020).withOpacity(0.03),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: action.tint.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(action.icon, color: action.tint, size: 21),
              ),
              const SizedBox(height: 18),
              Text(
                action.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                action.subtitle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 13.5,
                      height: 1.35,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                '→',
                style: TextStyle(
                  color: action.tint,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context,
      {required String title, required String subtitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 13.5),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGameFeature(BuildContext context, Game? featuredGame, bool isLoading) {
    if (isLoading) {
      return _buildGameFeatureShimmer(context);
    }

    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.dividerColor.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  l10n?.homeGameOfTheWeek ?? 'Juego de la semana',
                  style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
                ),
              ),
              TextButton(
                onPressed: () {
                  _navigateTo(
                    context,
                    const GamesSearchScreen(),
                    section: AppSection.videojuegos,
                  );
                },
                child: Text(
                  l10n?.homeSeeMonthsGames ?? 'Ver los juegos del mes',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            constraints: const BoxConstraints(minHeight: 250),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFF111827), Color(0xFF1B2340)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0B1020).withOpacity(0.16),
                  blurRadius: 20,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  if (featuredGame != null && featuredGame.backgroundImage != null)
                    Positioned.fill(
                      child: Hero(
                        tag: 'game_image_${featuredGame.id}',
                        child: Image.network(
                          featuredGame.backgroundImage!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                        ),
                      ),
                    ),
                  // Gradiente superpuesto para garantizar la legibilidad del texto
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            const Color(0xFF111827).withOpacity(0.95),
                          ],
                          stops: const [0.3, 1.0],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -20,
                    top: -10,
                    child: Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppConfig.primaryColor.withOpacity(0.22),
                            Colors.transparent
                          ],
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _buildGameTopLabel(context, featuredGame),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        featuredGame?.name ?? 'Starlight Echoes',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _buildGameSummary(context, featuredGame),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.72),
                          height: 1.45,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 14),
                      ElevatedButton(
                        onPressed: () {
                          if (featuredGame != null) {
                            _navigateTo(
                              context,
                              GameDetailScreen(
                                gameId: featuredGame.id,
                                gameName: featuredGame.name,
                              ),
                              section: AppSection.videojuegos,
                            );
                            return;
                          }
                          _navigateTo(
                            context,
                            const GamesSearchScreen(),
                            section: AppSection.videojuegos,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF111827),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 12),
                        ),
                        child: Text(
                          l10n?.homeFullAnalysisBtn ?? 'Análisis completo',
                        ),
                      ),
                    ],
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

  Widget _buildGameFeatureShimmer(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[850]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.dividerColor.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  l10n?.homeGameOfTheWeek ?? 'Juego de la semana',
                  style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
                ),
              ),
              TextButton(
                onPressed: null, // Botón desactivado mientras carga
                child: Text(
                  l10n?.homeSeeMonthsGames ?? 'Ver los juegos del mes',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              constraints: const BoxConstraints(minHeight: 250),
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? AppConfig.cardDark : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 120, height: 14, color: Colors.white),
                  const SizedBox(height: 10),
                  Container(width: 220, height: 28, color: Colors.white),
                  const SizedBox(height: 10),
                  Container(width: double.infinity, height: 14, color: Colors.white),
                  const SizedBox(height: 6),
                  Container(width: double.infinity, height: 14, color: Colors.white),
                  const SizedBox(height: 6),
                  Container(width: 180, height: 14, color: Colors.white),
                  const SizedBox(height: 14),
                  Container(width: 140, height: 40, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdatesPanel(
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.dividerColor.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n?.homeLatestUpdatesTitle ?? 'Últimas actualizaciones',
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),
          Consumer<ForumProvider>(
            builder: (context, forumProvider, child) {
              if (forumProvider.isPostsLoading) {
                return _buildUpdatesShimmer(context);
              }

              final posts = forumProvider.posts;
              final items = <_CommunityUpdateItem>[
                _createCommunityUpdateItem(
                  context,
                  sectionId: ForumSections.general.id,
                  icon: Icons.forum_outlined,
                  tint: const Color(0xFF3B82F6),
                  title: l10n?.forumSectionGeneral ?? 'General',
                  latest: _getLatestPostBySectionId(
                      posts, ForumSections.general.id),
                ),
                _createCommunityUpdateItem(
                  context,
                  sectionId: ForumSections.news.id,
                  icon: Icons.newspaper_outlined,
                  tint: const Color(0xFFF59E0B),
                  title: l10n?.forumSectionNews ?? 'Noticias',
                  latest:
                      _getLatestPostBySectionId(posts, ForumSections.news.id),
                ),
                _createCommunityUpdateItem(
                  context,
                  sectionId: ForumSections.qna.id,
                  icon: Icons.help_outline,
                  tint: const Color(0xFF10B981),
                  title: l10n?.forumSectionQnA ?? 'Preguntas y respuestas',
                  latest:
                      _getLatestPostBySectionId(posts, ForumSections.qna.id),
                ),
              ];

              return Column(
                children: [
                  for (final item in items) ...[
                    _buildUpdateTile(context, item),
                    const SizedBox(height: 12),
                  ],
                ],
              );
            },
          ),
          const SizedBox(height: 6),
          OutlinedButton(
            onPressed: () {
              if (_requireLogin(context)) {
                _navigateTo(context, const ForumListScreen());
              }
            },
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(46),
            side: BorderSide(color: theme.dividerColor.withOpacity(0.5)),
            ),
            child: Text(
              l10n?.homeGoToCommunityBtn ?? 'Accede a la comunidad',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateTile(BuildContext context, _CommunityUpdateItem item) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withOpacity(0.7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.dividerColor.withOpacity(0.35)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: item.tint.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(item.icon, color: item.tint, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 12.5, height: 1.25),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.meta,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 11.5,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdatesShimmer(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[850]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return Column(
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withOpacity(0.7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.dividerColor.withOpacity(0.35)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: double.infinity, height: 14, color: Colors.white),
                        const SizedBox(height: 6),
                        Container(width: 150, height: 12, color: Colors.white),
                        const SizedBox(height: 8),
                        Container(width: 80, height: 11, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBadge(
      {required String text,
      required Color background,
      required Color foreground}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: foreground,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }

  void _handleMenuAction(
      BuildContext context, AuthProvider authProvider, String value) {
    switch (value) {
      case 'profile':
        _navigateTo(context, const EditProfileScreen());
        break;
      case 'my_terms':
        _navigateTo(context, const MyProposedTermsScreen());
        break;
      case 'moderation':
        if (authProvider.isModerator) {
          _navigateTo(context, const ModerationScreen());
        }
        break;
      case 'users_management':
        if (authProvider.isAdmin) {
          _navigateTo(context, const UsersManagementScreen());
        }
        break;
      case 'logout':
        if (context.mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        }
        authProvider.signOut();
        break;
    }
  }

  void _navigateTo(
    BuildContext context,
    Widget screen, {
    AppSection? section,
  }) {
    final previousSection = PersistentFrameScope.activeSectionOf(context);
    if (section != null) {
      PersistentFrameScope.setSection(context, section);
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => screen),
    ).then((_) {
      if (context.mounted && section != null && previousSection != null) {
        PersistentFrameScope.setSection(context, previousSection);
      }
    });
  }

  String _buildGameSummary(BuildContext context, Game? game) {
    final l10n = AppLocalizations.of(context);
    if (game == null) {
      return l10n?.homeGameSummaryEmpty ?? 'No hay juego destacado esta semana. Consulta los juegos del mes para ver las novedades.';
    }

    final released = game.released != null && game.released!.isNotEmpty
        ? (l10n?.homeGameSummaryReleased(game.released!) ?? 'Salida: ${game.released}')
        : (l10n?.homeGameSummaryReleasedEmpty ?? 'Salida: no disponible');
    final rating = game.rating > 0
        ? (l10n?.homeGameSummaryRating(game.rating.toStringAsFixed(1)) ?? 'Rating: ${game.rating.toStringAsFixed(1)}')
        : (l10n?.homeGameSummaryRatingEmpty ?? 'Rating: sin datos');
    final genre = game.genres.isNotEmpty
        ? game.genres.first
        : (l10n?.homeGameSummaryNoGenre ?? 'Sin género');
    final ageRating = game.pegiRating != null
        ? 'PEGI ${game.pegiRating}+'
        : (game.esrbRating?.isNotEmpty == true
            ? 'ESRB ${game.esrbRating}'
            : (l10n?.homeGameSummaryRatingPending ?? 'Clasificación pendiente'));
    return l10n?.homeGameSummaryFull(genre, released, rating, ageRating) ?? 'Género: $genre · $released · $rating · $ageRating';
  }

  String _buildGameTopLabel(BuildContext context, Game? game) {
    final l10n = AppLocalizations.of(context);
    if (game == null) {
      return l10n?.homeGameTopLabelWeekly ?? 'Selección semanal';
    }

    final genreText = game.genres.isNotEmpty
        ? game.genres.first
        : (l10n?.homeGameSummaryNoGenre ?? 'Sin género');
    final ageRating = game.pegiRating != null
        ? 'PEGI ${game.pegiRating}+'
        : (game.esrbRating?.isNotEmpty == true
            ? 'ESRB ${game.esrbRating}'
            : (l10n?.homeGameTopLabelUnrated ?? 'Sin clasificación'));

    return '$ageRating  ·  $genreText';
  }

  ForumPost? _getLatestPostBySectionId(
      List<ForumPost> posts, String sectionId) {
    for (final post in posts) {
      if (post.effectiveSectionId == sectionId) {
        return post;
      }
    }
    return null;
  }

  _CommunityUpdateItem _createCommunityUpdateItem(
    BuildContext context, {
    required String sectionId,
    required String title,
    required IconData icon,
    required Color tint,
    required ForumPost? latest,
  }) {
    final l10n = AppLocalizations.of(context);
    return _CommunityUpdateItem(
      title: title,
      subtitle: latest?.title ?? (l10n?.homeUpdateNoNews ?? 'Sin novedades recientes en esta sección.'),
      meta: latest != null ? (l10n?.homeUpdateThreadUpdated ?? 'Hilo actualizado recientemente') : (l10n?.homeUpdateCommunity ?? 'Comunidad'),
      icon: icon,
      tint: tint,
      onTap: () {
        if (_requireLogin(context)) {
          _navigateTo(context, ForumCategoryPostsScreen(section: ForumSections.byId(sectionId)));
        }
      },
    );
  }

  String _getCommunityLevel(
    BuildContext context,
    UserModel? user,
    int? messagesCount,
  ) {
    final l10n = AppLocalizations.of(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    if (authProvider.isAdmin) {
      return l10n?.roleAdmin ?? 'Administrador';
    }
    if (authProvider.isModerator) {
      return l10n?.roleModerator ?? 'Moderador';
    }

    if (messagesCount == null) {
      return l10n?.commonLoading ?? 'Cargando...';
    }

    // Sube 1 nivel por cada 10 mensajes en la comunidad.
    final level = 1 + (messagesCount / 10).floor();
    return l10n?.userLevel(level) ?? 'Nivel $level';
  }
}

class _QuickActionData {
  const _QuickActionData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.tint,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color tint;
  final VoidCallback onTap;
}

class _CommunityUpdateItem {
  const _CommunityUpdateItem({
    required this.title,
    required this.subtitle,
    required this.meta,
    required this.icon,
    required this.tint,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String meta;
  final IconData icon;
  final Color tint;
  final VoidCallback onTap;
}
