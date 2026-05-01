import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_config.dart';
import '../../models/forum_post_model.dart';
import '../../providers/forum_provider.dart';
import 'create_post_screen.dart';
import '../../widgets/common/app_footer.dart';
import '../info/pegi_info_screen.dart';
import '../parental_guides/parental_guides_list_screen.dart';
import '../../widgets/forum/forum_categories_grid.dart';
import '../../widgets/forum/forum_platforms_section.dart';
import '../../widgets/forum/forum_sidebar.dart';

class ForumListScreen extends StatelessWidget {
  final String? topicFilter;

  const ForumListScreen({super.key, this.topicFilter});

  @override
  Widget build(BuildContext context) {
    final forumProvider = context.read<ForumProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0F0F1A) : const Color(0xFFF0F4FF),
      body: StreamBuilder<List<ForumPost>>(
        stream: forumProvider.postsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final allPosts = snapshot.data ?? [];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
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
                              initialTopicFilter: topicFilter,
                            ),
                            const SizedBox(height: 24),
                            ForumPlatformsSection(
                              isDark: isDark,
                            ),
                            const SizedBox(height: 24),
                            AppFooter(
                              onPrivacyTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => const PegiInfoScreen()),
                              ),
                              onAboutTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => const PegiInfoScreen()),
                              ),
                              onContactTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const ParentalGuidesListScreen()),
                              ),
                            ),
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const CreatePostScreen()),
          );
        },
        label: const Text('Nuevo Hilo'),
        icon: const Icon(Icons.add),
        backgroundColor: AppConfig.accentColor,
      ),
    );
  }
}