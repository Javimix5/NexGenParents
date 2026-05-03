import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_config.dart';
import '../../providers/forum_provider.dart';
import 'create_post_screen.dart';
import '../../widgets/common/app_footer.dart';
import 'forum_categories_grid.dart';
import 'forum_platforms_section.dart';
import 'forum_sidebar.dart';
import '../../l10n/app_localizations.dart';

class ForumListScreen extends StatefulWidget {
  final String? topicFilter;

  const ForumListScreen({super.key, this.topicFilter});

  @override
  State<ForumListScreen> createState() => _ForumListScreenState();
}

class _ForumListScreenState extends State<ForumListScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;
      if (_scrollController.offset >= 300 && !_showBackToTopButton) {
        setState(() => _showBackToTopButton = true);
      } else if (_scrollController.offset < 300 && _showBackToTopButton) {
        setState(() => _showBackToTopButton = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0F0F1A) : const Color(0xFFF0F4FF),
      body: Consumer<ForumProvider>(
        builder: (context, forumProvider, child) {
          if (forumProvider.isPostsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final allPosts = forumProvider.posts;
          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 600));
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 120),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 700;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Contenido principal ──
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ForumCategoriesGrid(
                                allPosts: allPosts,
                                  initialTopicFilter: widget.topicFilter,
                              ),
                              const SizedBox(height: 24),
                              ForumPlatformsSection(
                                isDark: isDark,
                              ),
                              const SizedBox(height: 24),
                              const AppFooter(),
                            ],
                          ),
                        ),
                        if (isWide) ...[
                          const SizedBox(width: 16),
                          // ── Sidebar derecho ──
                          SizedBox(
                            width: 220,
                            child: ForumSidebar(isDark: isDark),
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (_showBackToTopButton) ...[
            FloatingActionButton.small(
              heroTag: 'forum_list_back_to_top_btn',
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
              child: const Icon(Icons.arrow_upward),
            ),
            const SizedBox(height: 16),
          ],
          FloatingActionButton.extended(
            heroTag: 'forum_list_create_post_btn',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CreatePostScreen()),
              );
            },
            label: Text(l10n?.forumNewPostBtn ?? 'Nuevo Hilo'),
            icon: const Icon(Icons.add),
            backgroundColor: AppConfig.accentColor,
          ),
        ],
      ),
    );
  }
}