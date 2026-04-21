import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/app_config.dart';
import '../../models/dictionary_term_model.dart';
import '../../models/game_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/dictionary_provider.dart';
import '../../providers/games_provider.dart';
import '../admin/users_management_screen.dart';
import '../auth/login_screen.dart';
import '../dictionary/dictionary_list_screen.dart';
import '../dictionary/moderation_screen.dart';
import '../dictionary/my_proposed_terms_screen.dart';
import '../forum/forum_list_screen.dart';
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
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dictionaryProvider = Provider.of<DictionaryProvider>(context, listen: false);
      final gamesProvider = Provider.of<GamesProvider>(context, listen: false);
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      
      dictionaryProvider.loadApprovedTerms();
      gamesProvider.loadPopularGames();
      
      // Cargar términos propuestos del usuario al iniciar la pantalla
      if (authProvider.currentUser != null) {
        dictionaryProvider.loadUserProposedTerms(authProvider.currentUser!.id);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;
    final dictionaryProvider = Provider.of<DictionaryProvider>(context);
    final gamesProvider = Provider.of<GamesProvider>(context);
    final approvedTerms = dictionaryProvider.approvedTerms;
    final userTerms = dictionaryProvider.userProposedTerms;
    final popularGames = gamesProvider.popularGames;
    final featuredGame = popularGames.isNotEmpty ? popularGames.first : null;
    final secondaryGame = popularGames.length > 1 ? popularGames[1] : null;
    final userName = user?.displayName;
    final displayName = userName != null && userName.trim().isNotEmpty ? userName : 'Alex';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF7F8FC), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildTopBar(context, authProvider),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1180),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildHero(context, displayName, approvedTerms.length, userTerms.length),
                          const SizedBox(height: 28),
                          _buildSectionHeader(
                            context,
                            title: 'Quick Actions',
                            subtitle: 'Shortcuts to the areas parents use most.',
                          ),
                          const SizedBox(height: 16),
                          _buildQuickActions(context),
                          const SizedBox(height: 28),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth < 960) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    _buildGameFeature(context, featuredGame),
                                    const SizedBox(height: 20),
                                    _buildUpdatesPanel(context, secondaryGame, approvedTerms, userTerms),
                                  ],
                                );
                              }

                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(flex: 3, child: _buildGameFeature(context, featuredGame)),
                                  const SizedBox(width: 24),
                                  Expanded(flex: 2, child: _buildUpdatesPanel(context, secondaryGame, approvedTerms, userTerms)),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 28),
                          _buildFooter(context),
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
  }

  Widget _buildTopBar(BuildContext context, AuthProvider authProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Container(
        height: 58,
        decoration: BoxDecoration(
          color: const Color(0xFF0B1020),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0B1020).withOpacity(0.2),
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
                color: AppConfig.primaryColor.withOpacity(0.18),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppConfig.primaryColor.withOpacity(0.35)),
              ),
              child: const Icon(Icons.videogame_asset_outlined, size: 18, color: Colors.white),
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
                      _buildNavLink('Home', true, () {}),
                      _buildNavLink('Dictionary', false, () => _navigateTo(context, const DictionaryListScreen())),
                      _buildNavLink('Game Search', false, () => _navigateTo(context, const GamesSearchScreen())),
                      _buildNavLink('Parental Control', false, () => _navigateTo(context, const ParentalGuidesListScreen())),
                      _buildNavLink('Community', false, () => _navigateTo(context, const ForumListScreen())),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              width: 290,
              child: TextField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _navigateTo(context, const GamesSearchScreen()),
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Search forum...',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.45), fontSize: 14),
                  prefixIcon: Icon(Icons.search, size: 18, color: Colors.white.withOpacity(0.55)),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.05),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: AppConfig.primaryColor.withOpacity(0.8)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            PopupMenuButton<String>(
              icon: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person_rounded, color: Colors.white, size: 20),
              ),
              onSelected: (value) => _handleMenuAction(context, authProvider, value),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'profile',
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Editar perfil'),
                  ),
                ),
                PopupMenuItem(
                  value: 'my_terms',
                  child: ListTile(
                    leading: const Icon(Icons.article_outlined),
                    title: const Text('Mis términos propuestos'),
                    subtitle: Text('${Provider.of<DictionaryProvider>(context, listen: false).userProposedTerms.length} términos'),
                  ),
                ),
                if (authProvider.isModerator)
                  const PopupMenuItem(
                    value: 'moderation',
                    child: ListTile(
                      leading: Icon(Icons.admin_panel_settings),
                      title: Text('Moderación'),
                    ),
                  ),
                if (authProvider.isAdmin)
                  const PopupMenuItem(
                    value: 'users_management',
                    child: ListTile(
                      leading: Icon(Icons.people),
                      title: Text('Gestión de usuarios'),
                    ),
                  ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: 'logout',
                  child: ListTile(
                    leading: Icon(Icons.logout, color: AppConfig.errorColor),
                    title: Text('Cerrar sesión'),
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

  Widget _buildHero(BuildContext context, String userName, int approvedTermsCount, int userTermsCount) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE7EAF3)),
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
            crossAxisAlignment: vertical ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7E8DB),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(Icons.person_outline, size: 38, color: Color(0xFFB96A3D)),
              ),
              SizedBox(width: vertical ? 0 : 18, height: vertical ? 18 : 0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back, $userName!',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: AppConfig.textPrimaryColor,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Tienes $approvedTermsCount términos aprobados y $userTermsCount propuestas en seguimiento hoy.',
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
                          text: 'Premium Member',
                          background: const Color(0xFFF3E8FF),
                          foreground: const Color(0xFF8B5CF6),
                        ),
                        _buildBadge(
                          text: '${approvedTermsCount + userTermsCount} active items',
                          background: const Color(0xFFEAFBF3),
                          foreground: const Color(0xFF059669),
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
        title: 'Search Games by Age',
        subtitle: 'Find age-appropriate titles for your kids',
        icon: Icons.visibility_outlined,
        tint: const Color(0xFF22C1DC),
        onTap: () => _navigateTo(context, const GamesSearchScreen()),
      ),
      _QuickActionData(
        title: 'Browse Gamer Slang',
        subtitle: 'Decode what your kids are saying in-game',
        icon: Icons.translate_outlined,
        tint: const Color(0xFFA855F7),
        onTap: () => _navigateTo(context, const DictionaryListScreen()),
      ),
      _QuickActionData(
        title: 'Set Up Parental Controls',
        subtitle: 'Configure limits and content filters',
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
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: action.onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          constraints: const BoxConstraints(minHeight: 132),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE9ECF5)),
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
                      color: AppConfig.textPrimaryColor,
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

  Widget _buildSectionHeader(BuildContext context, {required String title, required String subtitle}) {
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
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13.5),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGameFeature(BuildContext context, Game? featuredGame) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE9ECF5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Game of the Week',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: AppConfig.textPrimaryColor),
              ),
              TextButton(
                onPressed: () => _navigateTo(context, const GamesSearchScreen()),
                child: const Text('See past picks'),
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
                        colors: [AppConfig.primaryColor.withOpacity(0.22), Colors.transparent],
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
                        'E for Everyone  Adventure / Puzzle',
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
                        onPressed: () => _navigateTo(context, const GamesSearchScreen()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF111827),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                        ),
                        child: const Text('Read Full Review'),
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
    Game? secondaryGame,
    List<DictionaryTerm> approvedTerms,
    List<DictionaryTerm> userTerms,
  ) {
    final items = <_UpdateItem>[
      _UpdateItem(
        title: 'New Roblox Safety Features',
        subtitle: 'Understanding the new chat filters and privacy settings.',
        meta: '2 hours ago',
        icon: Icons.security_update_outlined,
        tint: const Color(0xFFF4A261),
      ),
      _UpdateItem(
        title: secondaryGame?.name ?? 'How much screen time?',
        subtitle: secondaryGame != null
            ? 'A quick look at whether it is a good fit for family play.'
            : 'Expert advice on balancing gaming and schoolwork.',
        meta: secondaryGame != null ? '${secondaryGame.rating.toStringAsFixed(1)} rating' : 'Featured guide',
        icon: Icons.videogame_asset_outlined,
        tint: const Color(0xFF7C83FD),
      ),
      _UpdateItem(
        title: 'Dictionary Pulse',
        subtitle: '${approvedTerms.length} approved terms and ${userTerms.length} personal drafts.',
        meta: 'Community activity',
        icon: Icons.auto_graph_outlined,
        tint: const Color(0xFF10B981),
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE9ECF5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Latest Updates',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: AppConfig.textPrimaryColor),
          ),
          const SizedBox(height: 16),
          for (final item in items) ...[
            _buildUpdateTile(context, item),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 6),
          OutlinedButton(
            onPressed: () => _navigateTo(context, const ForumListScreen()),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(46),
              foregroundColor: AppConfig.textPrimaryColor,
              side: const BorderSide(color: Color(0xFFD8DDEA)),
            ),
            child: const Text('View Community Forum'),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateTile(BuildContext context, _UpdateItem item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFD),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8EBF4)),
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
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12.5, height: 1.25),
                ),
                const SizedBox(height: 6),
                Text(
                  item.meta,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 11.5,
                        color: AppConfig.textSecondaryColor.withOpacity(0.9),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1020),
        borderRadius: BorderRadius.circular(22),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final stacked = constraints.maxWidth < 760;
          final textStyle = TextStyle(color: Colors.white.withOpacity(0.78), fontSize: 13);

          if (stacked) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFooterBrand(),
                const SizedBox(height: 16),
                Text('Empowering families to make informed gaming decisions.', style: textStyle),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 18,
                  runSpacing: 10,
                  children: [
                    _buildFooterLink('Privacy Policy', () => _navigateTo(context, const PegiInfoScreen())),
                    _buildFooterLink('Terms of Service', () => _navigateTo(context, const PegiInfoScreen())),
                    _buildFooterLink('Support', () => _navigateTo(context, const ParentalGuidesListScreen())),
                  ],
                ),
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
                    Text('Empowering families to make informed gaming decisions.', style: textStyle),
                  ],
                ),
              ),
              Wrap(
                spacing: 24,
                children: [
                  _buildFooterLink('Privacy Policy', () => _navigateTo(context, const PegiInfoScreen())),
                  _buildFooterLink('Terms of Service', () => _navigateTo(context, const PegiInfoScreen())),
                  _buildFooterLink('Support', () => _navigateTo(context, const ParentalGuidesListScreen())),
                ],
              ),
            ],
          );
        },
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
          child: const Icon(Icons.videogame_asset_outlined, color: Colors.white, size: 16),
        ),
        const SizedBox(width: 10),
        const Text(
          AppConfig.appName,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildFooterLink(String label, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(foregroundColor: Colors.white),
      child: Text(label, style: TextStyle(color: Colors.white.withOpacity(0.78))),
    );
  }

  Widget _buildBadge({required String text, required Color background, required Color foreground}) {
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

  Widget _buildNavLink(String label, bool active, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : Colors.white.withOpacity(0.78),
            fontSize: 13,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void _handleMenuAction(BuildContext context, AuthProvider authProvider, String value) {
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
      return 'A beautiful co-op adventure that teaches problem solving and communication. Perfect for ages 7-12.';
    }

    final released = game.released != null && game.released!.isNotEmpty ? 'Released ${game.released}' : 'Featured pick';
    final rating = game.rating > 0 ? 'Rating ${game.rating.toStringAsFixed(1)}' : 'Curated family pick';
    final pegi = game.pegiRating != null ? 'PEGI ${game.pegiRating}+' : 'Age guidance available';
    return '$released  $rating  $pegi';
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

class _UpdateItem {
  const _UpdateItem({
    required this.title,
    required this.subtitle,
    required this.meta,
    required this.icon,
    required this.tint,
  });

  final String title;
  final String subtitle;
  final String meta;
  final IconData icon;
  final Color tint;
}