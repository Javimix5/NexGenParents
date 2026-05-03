import 'package:flutter/material.dart';
import '../../../models/forum_post_model.dart';
import '../../../models/forum_section.dart';
import 'forum_category_posts_screen.dart';
import '../../l10n/app_localizations.dart';

class ForumCategoriesGrid extends StatelessWidget {
  final List<ForumPost> allPosts;
  final String? initialTopicFilter;

  const ForumCategoriesGrid({
    super.key,
    required this.allPosts,
    this.initialTopicFilter,
  });

  static const Map<String, String> _sectionImages = {
    'welcome': 'https://images.unsplash.com/photo-1511512578047-dfb367046420?w=400',
    'general': 'https://images.unsplash.com/photo-1493711662062-fa541adb3fc8?w=400',
    'news': 'https://images.unsplash.com/photo-1585829365295-ab7cd400c167?w=400',
    'qa': 'https://images.unsplash.com/photo-1606761568499-6d2451b23c66?w=400',
    'guides': 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?w=400',
    'offtopic': 'https://images.unsplash.com/photo-1560419015-7c427e8ae5ba?w=400',
  };

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n?.forumMainCategoriesTitle ?? 'Categorías Principales',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 16),

        // Grid de secciones
        LayoutBuilder(
          builder: (context, constraints) {
            final crossCount = constraints.maxWidth > 500 ? 3 : 2;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: constraints.maxWidth > 800 
                    ? 1.6 
                    : (constraints.maxWidth > 500 
                        ? 1.05 
                        : 0.85), // Proporción más vertical para móviles
              ),
              itemCount: ForumSections.all.length,
              itemBuilder: (context, index) {
                final section = ForumSections.all[index];
                final sectionPosts = allPosts
                    .where((p) => p.effectiveSectionId == section.id)
                    .toList();
                final postCount = sectionPosts.length;
                final replyCount = sectionPosts.fold<int>(0, (s, p) => s + p.replyCount);
                final imageUrl = _sectionImages[section.id] ?? _sectionImages['general']!;

                return _SectionCard(
                  section: section,
                  languageCode: languageCode,
                  imageUrl: imageUrl,
                  postCount: postCount,
                  replyCount: replyCount,
                  isDark: isDark,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ForumCategoryPostsScreen(section: section),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final ForumSectionDefinition section;
  final String languageCode;
  final String imageUrl;
  final int postCount;
  final int replyCount;
  final bool isDark;
  final VoidCallback onTap;

  const _SectionCard({required this.section, required this.languageCode, required this.imageUrl, required this.postCount, required this.replyCount, required this.isDark, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A1A2E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDark ? Colors.white10 : Colors.black.withOpacity(0.08)),
          boxShadow: [BoxShadow(color: isDark ? Colors.black.withOpacity(0.3) : Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(15)), child: Image.network(imageUrl, height: 70, width: double.infinity, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(height: 70, color: isDark ? const Color(0xFF252540) : Colors.grey[200], child: Icon(Icons.image_outlined, color: isDark ? Colors.white24 : Colors.black26, size: 32)))),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section.localizedName(languageCode),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isDark ? Colors.white : Colors.black87),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: Text(
                        section.localizedDescription(languageCode),
                        style: TextStyle(fontSize: 11, color: isDark ? Colors.white54 : Colors.black54),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.chat_bubble_outline, size: 11, color: isDark ? Colors.white38 : Colors.black38), const SizedBox(width: 3), Text(postCount.toString(), style: TextStyle(fontSize: 10, color: isDark ? Colors.white38 : Colors.black38)), const SizedBox(width: 8), Icon(Icons.people_outline, size: 11, color: isDark ? Colors.white38 : Colors.black38), const SizedBox(width: 3), Text(replyCount.toString(), style: TextStyle(fontSize: 10, color: isDark ? Colors.white38 : Colors.black38))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}