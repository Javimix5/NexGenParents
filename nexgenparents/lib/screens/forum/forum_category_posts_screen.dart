import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/app_config.dart';
import '../../../models/forum_post_model.dart';
import '../../../models/forum_section.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/forum_provider.dart';
import '../../../widgets/common/app_empty_state.dart';
import 'forum_post_detail_screen.dart';

class ForumCategoryPostsScreen extends StatefulWidget {
  final ForumSectionDefinition section;

  const ForumCategoryPostsScreen({
    super.key,
    required this.section,
  });

  @override
  State<ForumCategoryPostsScreen> createState() => _ForumCategoryPostsScreenState();
}

class _ForumCategoryPostsScreenState extends State<ForumCategoryPostsScreen> {
  bool _isGridView = false; // Por defecto lo mostramos como lista que queda mejor

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final forumProvider = context.watch<ForumProvider>();
    final isAdmin = authProvider.isAdmin;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final languageCode = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.section.localizedName(languageCode)),
        actions: [
          IconButton(
            icon: Icon(Icons.grid_view, color: _isGridView ? AppConfig.accentColor : null),
            onPressed: () => setState(() => _isGridView = true),
          ),
          IconButton(
            icon: Icon(Icons.list, color: !_isGridView ? AppConfig.accentColor : null),
            onPressed: () => setState(() => _isGridView = false),
          ),
        ],
      ),
      // Leemos directamente del stream para que la lista se actualice en tiempo real
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
          final sectionPosts = allPosts.where((p) => p.effectiveSectionId == widget.section.id).toList();

          if (sectionPosts.isEmpty) {
            return const AppEmptyState(
              icon: Icons.forum_outlined,
              title: 'No hay publicaciones en esta categoría',
              message: 'Todavía no hay novedades en esta sección. ¡Anímate y publica algo!',
            );
          }

          final cardColor = isDark ? const Color(0xFF1A1A2E) : Colors.white;
          final subtitleColor = isDark ? Colors.white60 : Colors.black54;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sectionPosts.length,
            itemBuilder: (context, index) {
              final post = sectionPosts[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isDark ? Colors.white10 : Colors.black.withOpacity(0.08)),
                  boxShadow: [
                    BoxShadow(color: isDark ? Colors.black.withOpacity(0.1) : Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))
                  ],
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
              );
            },
          );
        },
      ),
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