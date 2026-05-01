import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/app_config.dart';
import '../../../models/forum_post_model.dart';
import '../../../models/forum_section.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/forum_provider.dart';
import '../../../widgets/common/app_empty_state.dart';
import '../../../screens/forum/forum_post_detail_screen.dart';

class ForumCategoriesGrid extends StatefulWidget {
  final List<ForumPost> allPosts;
  final String? initialTopicFilter;

  const ForumCategoriesGrid({
    super.key,
    required this.allPosts,
    this.initialTopicFilter,
  });

  @override
  State<ForumCategoriesGrid> createState() => _ForumCategoriesGridState();
}

class _ForumCategoriesGridState extends State<ForumCategoriesGrid> {
  String? _selectedSectionId;
  bool _isGridView = true;

  static const Map<String, String> _sectionImages = {
    'welcome': 'https://images.unsplash.com/photo-1511512578047-dfb367046420?w=400',
    'general': 'https://images.unsplash.com/photo-1493711662062-fa541adb3fc8?w=400',
    'news': 'https://images.unsplash.com/photo-1585829365295-ab7cd400c167?w=400',
    'qa': 'https://images.unsplash.com/photo-1606761568499-6d2451b23c66?w=400',
    'guides': 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?w=400',
    'offtopic': 'https://images.unsplash.com/photo-1560419015-7c427e8ae5ba?w=400',
  };

  @override
  void initState() {
    super.initState();
    _selectedSectionId = widget.initialTopicFilter == null
        ? null
        : ForumSections.idFromLegacyTopic(widget.initialTopicFilter);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final forumProvider = context.read<ForumProvider>();
    final isAdmin = authProvider.isAdmin;
    final languageCode = Localizations.localeOf(context).languageCode;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header con título y "View All"
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'General Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            TextButton.icon(
              onPressed: () => setState(() => _selectedSectionId = null),
              icon: Text(
                'View All',
                style: TextStyle(
                  color: isDark ? const Color(0xFF8B5CF6) : const Color(0xFF6366F1),
                  fontWeight: FontWeight.w600,
                ),
              ),
              label: Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: isDark ? const Color(0xFF8B5CF6) : const Color(0xFF6366F1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

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
                childAspectRatio: 0.85,
              ),
              itemCount: ForumSections.all.length,
              itemBuilder: (context, index) {
                final section = ForumSections.all[index];
                final sectionPosts = widget.allPosts
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
                  isSelected: _selectedSectionId == section.id,
                  onTap: () => setState(() => _selectedSectionId = section.id),
                );
              },
            );
          },
        ),

        // Lista de posts de la sección seleccionada
        if (_selectedSectionId != null) ...[
          const SizedBox(height: 16),
          _buildPostsList(
            context,
            widget.allPosts.where((p) => p.effectiveSectionId == _selectedSectionId).toList(),
            languageCode,
            isDark,
            isAdmin,
            forumProvider,
          ),
        ],
      ],
    );
  }

  Widget _buildPostsList(BuildContext context, List<ForumPost> posts, String languageCode, bool isDark, bool isAdmin, ForumProvider forumProvider) {
    if (posts.isEmpty) {
      return AppEmptyState(
        icon: Icons.forum_outlined,
        title: 'No hay publicaciones en esta sección',
        message: 'Todavía no hay novedades aquí.',
      );
    }

    final cardColor = isDark ? const Color(0xFF1A1A2E) : Colors.white;
    final subtitleColor = isDark ? Colors.white60 : Colors.black54;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ForumSections.byId(_selectedSectionId!).localizedName(languageCode),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.grid_view, color: _isGridView ? AppConfig.accentColor : subtitleColor),
                  onPressed: () => setState(() => _isGridView = true),
                  iconSize: 20,
                ),
                IconButton(
                  icon: Icon(Icons.list, color: !_isGridView ? AppConfig.accentColor : subtitleColor),
                  onPressed: () => setState(() => _isGridView = false),
                  iconSize: 20,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...posts.map((post) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isDark ? Colors.white10 : Colors.black.withOpacity(0.08)),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: CircleAvatar(
                  backgroundColor: AppConfig.accentColor.withOpacity(0.2),
                  child: Text(
                    post.authorName.isNotEmpty ? post.authorName[0].toUpperCase() : '?',
                    style: const TextStyle(color: AppConfig.accentColor, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(
                  post.title,
                  style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87, fontSize: 14),
                ),
                subtitle: Text(
                  'por ${post.authorName} • ${post.replyCount} respuestas',
                  style: TextStyle(color: subtitleColor, fontSize: 12),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isAdmin)
                      IconButton(
                        tooltip: 'Eliminar',
                        icon: const Icon(Icons.delete_outline, color: AppConfig.errorColor, size: 18),
                        onPressed: () => _confirmDeletePost(context, forumProvider, post),
                      ),
                    Icon(Icons.arrow_forward_ios, size: 14, color: isDark ? Colors.white38 : Colors.black38),
                  ],
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ForumPostDetailScreen(post: post))),
              ),
            )),
      ],
    );
  }

  Future<void> _confirmDeletePost(BuildContext context, ForumProvider forumProvider, ForumPost post) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Eliminar publicación'),
        content: Text('¿Quieres eliminar "${post.title}" y todas sus respuestas?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: const Text('Cancelar')),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Eliminar', style: TextStyle(color: AppConfig.errorColor)),
          ),
        ],
      ),
    );

    if (shouldDelete != true) return;
    final success = await forumProvider.deletePost(post.id);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(forumProvider.errorMessage ?? (success ? 'Publicación eliminada' : 'No se pudo eliminar la publicación')),
    ));
  }
}

class _SectionCard extends StatelessWidget {
  final ForumSectionDefinition section;
  final String languageCode;
  final String imageUrl;
  final int postCount;
  final int replyCount;
  final bool isDark;
  final bool isSelected;
  final VoidCallback onTap;

  const _SectionCard({required this.section, required this.languageCode, required this.imageUrl, required this.postCount, required this.replyCount, required this.isDark, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A1A2E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? const Color(0xFF8B5CF6) : (isDark ? Colors.white10 : Colors.black.withOpacity(0.08)), width: isSelected ? 2 : 1),
          boxShadow: [BoxShadow(color: isDark ? Colors.black.withOpacity(0.3) : Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(15)), child: Image.network(imageUrl, height: 100, width: double.infinity, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(height: 100, color: isDark ? const Color(0xFF252540) : Colors.grey[200], child: Icon(Icons.image_outlined, color: isDark ? Colors.white24 : Colors.black26, size: 32)))),
            Expanded(child: Padding(padding: const EdgeInsets.all(10), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(section.localizedName(languageCode), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isDark ? Colors.white : Colors.black87), maxLines: 1, overflow: TextOverflow.ellipsis), const SizedBox(height: 4), Text(section.localizedDescription(languageCode), style: TextStyle(fontSize: 11, color: isDark ? Colors.white54 : Colors.black54), maxLines: 2, overflow: TextOverflow.ellipsis), const Spacer(), Row(children: [Icon(Icons.chat_bubble_outline, size: 11, color: isDark ? Colors.white38 : Colors.black38), const SizedBox(width: 3), Text(postCount.toString(), style: TextStyle(fontSize: 10, color: isDark ? Colors.white38 : Colors.black38)), const SizedBox(width: 8), Icon(Icons.people_outline, size: 11, color: isDark ? Colors.white38 : Colors.black38), const SizedBox(width: 3), Text(replyCount.toString(), style: TextStyle(fontSize: 10, color: isDark ? Colors.white38 : Colors.black38))])]))),
          ],
        ),
      ),
    );
  }
}