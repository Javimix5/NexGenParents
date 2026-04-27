import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/app_config.dart';
import '../../models/forum_post_model.dart';
import '../../models/forum_section.dart';
import '../../models/user_model.dart';
import '../../models/game_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/dictionary_provider.dart';
import '../../providers/forum_provider.dart';
import '../../providers/games_provider.dart';
import '../../viewmodels/home_view_model.dart';
import '../../widgets/common/app_footer.dart';
import '../../widgets/common/app_header.dart';
import '../../widgets/common/user_avatar.dart';
import '../admin/users_management_screen.dart';
import '../auth/login_screen.dart';
import '../dictionary/dictionary_list_screen.dart';
import '../dictionary/moderation_screen.dart';
import '../dictionary/my_proposed_terms_screen.dart';
import '../forum/forum_list_screen.dart';
import '../games/game_detail_screen.dart';
import '../games/games_search_screen.dart';
import '../info/pegi_info_screen.dart';
import '../parental_guides/parental_guides_list_screen.dart';
import '../profile/edit_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _homeViewModel = HomeViewModel();
  Future<int>? _userMessagesCountFuture;
  String? _lastUserId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dictionaryProvider =
          Provider.of<DictionaryProvider>(context, listen: false);
      final gamesProvider = Provider.of<GamesProvider>(context, listen: false);
      final forumProvider = Provider.of<ForumProvider>(context, listen: false);
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      _homeViewModel.initialize(
        authProvider: authProvider,
        dictionaryProvider: dictionaryProvider,
        gamesProvider: gamesProvider,
        forumProvider: forumProvider,
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authProvider = Provider.of<AuthProvider>(context);
    final forumProvider = Provider.of<ForumProvider>(context, listen: false);
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
    _homeViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;
    final dictionaryProvider = Provider.of<DictionaryProvider>(context);
    final gamesProvider = Provider.of<GamesProvider>(context);
    final approvedTerms = dictionaryProvider.approvedTerms;
    final popularGames = gamesProvider.popularGames;
    final featuredGame = gamesProvider.weeklyTopGame ??
        (popularGames.isNotEmpty ? popularGames.first : null);
    final userName = user?.displayName;
    final displayName =
        userName != null && userName.trim().isNotEmpty ? userName : 'Usuario';
    final approvedTermsCount = user?.termsApproved ?? 0;
    final proposedTermsCount = user?.termsProposed ?? 0;
    final totalActiveTerms = approvedTerms.length;

    return AnimatedBuilder(
      animation: _homeViewModel,
      builder: (context, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? const [Color(0xFF0A0F1E), Color(0xFF141B2E)]
                    : const [Color(0xFFF7F8FC), Color(0xFFFFFFFF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  AppHeader(
                    activeSection: AppSection.inicio,
                    avatarUrl: user?.photoUrl,
                    proposedTermsCount: proposedTermsCount,
                    isModerator: authProvider.isModerator,
                    isAdmin: authProvider.isAdmin,
                    onSearchSubmitted: (_) =>
                        _navigateTo(context, const GamesSearchScreen()),
                    onNavigate: (section) {
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
                          _navigateTo(
                              context, const ParentalGuidesListScreen());
                          break;
                        case AppSection.comunidad:
                          _navigateTo(context, const ForumListScreen());
                          break;
                      }
                    },
                    onMenuSelected: (value) =>
                        _handleMenuAction(context, authProvider, value),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1180),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              FutureBuilder<int>(
                                future: _userMessagesCountFuture,
                                builder: (context, snapshot) {
                                  final messagesCount = snapshot.data;
                                  final userLevel =
                                      _getCommunityLevel(user, messagesCount);

                                  return _buildHero(
                                    context,
                                    userName: displayName,
                                    approvedTermsCount: approvedTermsCount,
                                    proposedTermsCount: proposedTermsCount,
                                    userLevel: userLevel,
                                    totalActiveTerms: totalActiveTerms,
                                    avatarUrl: user?.photoUrl,
                                  );
                                },
                              ),
                              const SizedBox(height: 28),
                              _buildSectionHeader(
                                context,
                                title: 'Acceso rápido',
                                subtitle:
                                    'Acceso a las zonas de la web más usadas',
                              ),
                              const SizedBox(height: 16),
                              _buildQuickActions(context),
                              const SizedBox(height: 28),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  if (constraints.maxWidth < 960) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        _buildGameFeature(
                                            context, featuredGame),
                                        const SizedBox(height: 20),
                                        _buildUpdatesPanel(context),
                                      ],
                                    );
                                  }

                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: _buildGameFeature(
                                            context, featuredGame),
                                      ),
                                      const SizedBox(width: 24),
                                      Expanded(
                                        flex: 2,
                                        child: _buildUpdatesPanel(context),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(height: 28),
                              AppFooter(
                                onPrivacyTap: () => _navigateTo(
                                    context, const PegiInfoScreen()),
                                onAboutTap: () => _navigateTo(
                                    context, const PegiInfoScreen()),
                                onContactTap: () => _navigateTo(
                                  context,
                                  const ParentalGuidesListScreen(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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

    return Container(
      padding: const EdgeInsets.all(28),
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final vertical = constraints.maxWidth < 760;
          return Flex(
            direction: vertical ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment:
                vertical ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: [
              UserAvatar(photoUrl: avatarUrl, size: 70),
              SizedBox(width: vertical ? 0 : 18, height: vertical ? 18 : 0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bienvenido, $userName!',
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                              ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Tienes $approvedTermsCount términos aprobados y $proposedTermsCount términos propuestos.',
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
                          text: '$totalActiveTerms términos activos',
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
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      _QuickActionData(
        title: 'Buscar juegos por edad',
        subtitle: 'Busca los juegos adecuados según la edad de tu hijo',
        icon: Icons.visibility_outlined,
        tint: const Color(0xFF22C1DC),
        onTap: () => _navigateTo(context, const GamesSearchScreen()),
      ),
      _QuickActionData(
        title: 'Busca términos en el diccionario',
        subtitle:
            'Descubre qué significan las palabras que usa tu hijo cuando juega',
        icon: Icons.translate_outlined,
        tint: const Color(0xFFA855F7),
        onTap: () => _navigateTo(context, const DictionaryListScreen()),
      ),
      _QuickActionData(
        title: 'Configurar Control Parental',
        subtitle: 'Configura los límites de edad y uso según la plataforma',
        icon: Icons.tune_outlined,
        tint: const Color(0xFF0EA5E9),
        onTap: () => _navigateTo(context, const ParentalGuidesListScreen()),
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

        return Row(
          children: [
            for (var index = 0; index < actions.length; index++) ...[
              Expanded(child: _buildQuickActionCard(context, actions[index])),
              if (index < actions.length - 1) const SizedBox(width: 16),
            ],
          ],
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
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                action.subtitle,
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
        Column(
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
      ],
    );
  }

  Widget _buildGameFeature(BuildContext context, Game? featuredGame) {
    final theme = Theme.of(context);

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
              const Text(
                'Juego de la semana',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
              ),
              TextButton(
                onPressed: () async {
                  final gamesProvider =
                      Provider.of<GamesProvider>(context, listen: false);
                  await gamesProvider.loadCurrentMonthGames();
                  if (!context.mounted) return;
                  _navigateTo(context, const GamesSearchScreen());
                },
                child: const Text('Ver los juegos del mes'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            height: 250,
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
            child: Stack(
              children: [
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
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        _buildGameTopLabel(featuredGame),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        featuredGame?.name ?? 'Starlight Echoes',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _buildGameSummary(featuredGame),
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
                            );
                            return;
                          }
                          _navigateTo(context, const GamesSearchScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF111827),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 12),
                        ),
                        child: const Text('Análisis completo'),
                      ),
                    ],
                  ),
                ),
              ],
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
    final forumProvider = Provider.of<ForumProvider>(context, listen: false);

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
          const Text(
            'Últimas actualizaciones',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),
          StreamBuilder<List<ForumPost>>(
            stream: forumProvider.postsStream,
            builder: (context, snapshot) {
              final languageCode = Localizations.localeOf(context).languageCode;
              final posts = snapshot.data ?? const <ForumPost>[];
              final items = <_CommunityUpdateItem>[
                _createCommunityUpdateItem(
                  context,
                  sectionId: ForumSections.general.id,
                  icon: Icons.forum_outlined,
                  tint: const Color(0xFF3B82F6),
                  title: ForumSections.general.localizedName(languageCode),
                  latest: _getLatestPostBySectionId(
                      posts, ForumSections.general.id),
                ),
                _createCommunityUpdateItem(
                  context,
                  sectionId: ForumSections.news.id,
                  icon: Icons.newspaper_outlined,
                  tint: const Color(0xFFF59E0B),
                  title: ForumSections.news.localizedName(languageCode),
                  latest:
                      _getLatestPostBySectionId(posts, ForumSections.news.id),
                ),
                _createCommunityUpdateItem(
                  context,
                  sectionId: ForumSections.qna.id,
                  icon: Icons.help_outline,
                  tint: const Color(0xFF10B981),
                  title: ForumSections.qna.localizedName(languageCode),
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
            onPressed: () => _navigateTo(context, const ForumListScreen()),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(46),
              side: BorderSide(color: theme.dividerColor.withOpacity(0.5)),
            ),
            child: const Text('Accede a la comunidad'),
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
        authProvider.signOut().then((_) {
          if (context.mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          }
        });
        break;
    }
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  String _buildGameSummary(Game? game) {
    if (game == null) {
      return 'No hay juego destacado esta semana. Consulta los juegos del mes para ver las novedades.';
    }

    final released = game.released != null && game.released!.isNotEmpty
        ? 'Salida: ${game.released}'
        : 'Salida: no disponible';
    final rating = game.rating > 0
        ? 'Rating: ${game.rating.toStringAsFixed(1)}'
        : 'Rating: sin datos';
    final genre = game.genres.isNotEmpty ? game.genres.first : 'Sin género';
    final ageRating = game.pegiRating != null
        ? 'PEGI ${game.pegiRating}+'
        : (game.esrbRating?.isNotEmpty == true
            ? 'ESRB ${game.esrbRating}'
            : 'Clasificación pendiente');
    return 'Género: $genre · $released · $rating · $ageRating';
  }

  String _buildGameTopLabel(Game? game) {
    if (game == null) {
      return 'Selección semanal';
    }

    final genreText = game.genres.isNotEmpty ? game.genres.first : 'Sin género';
    final ageRating = game.pegiRating != null
        ? 'PEGI ${game.pegiRating}+'
        : (game.esrbRating?.isNotEmpty == true
            ? 'ESRB ${game.esrbRating}'
            : 'Sin clasificación');

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
    return _CommunityUpdateItem(
      title: title,
      subtitle: latest?.title ?? 'Sin novedades recientes en esta sección.',
      meta: latest != null ? 'Hilo actualizado recientemente' : 'Comunidad',
      icon: icon,
      tint: tint,
      onTap: () =>
          _navigateTo(context, ForumListScreen(topicFilter: sectionId)),
    );
  }

  String _getCommunityLevel(UserModel? user, int? messagesCount) {
    if (user?.isAdmin ?? false) {
      return 'Administrador';
    }
    if (user?.isModerator ?? false) {
      return 'Moderador';
    }

    if (messagesCount == null) {
      return 'Cargando...';
    }

    // Sube 1 nivel por cada 10 mensajes en la comunidad.
    final level = 1 + (messagesCount / 10).floor();
    return 'Nivel $level';
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
