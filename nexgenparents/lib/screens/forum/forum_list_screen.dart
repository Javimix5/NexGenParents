import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/app_config.dart';
import '../../../models/forum_post_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/forum_provider.dart';
import 'create_post_screen.dart';
import 'forum_post_detail_screen.dart';

class ForumListScreen extends StatelessWidget {
  const ForumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final forumProvider = Provider.of<ForumProvider>(context, listen: false);
    final authProvider = context.watch<AuthProvider>();
    final isAdmin = authProvider.isAdmin;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comunidad'),
      ),
      body: StreamBuilder<List<ForumPost>>(
        stream: forumProvider.postsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No hay publicaciones todavía. ¡Sé el primero!'),
            );
          }

          final posts = snapshot.data!;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: AppConfig.paddingMedium,
                  vertical: AppConfig.paddingSmall,
                ),
                child: ListTile(
                  title: Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('por ${post.authorName} • ${post.replyCount} respuestas'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isAdmin)
                        IconButton(
                          tooltip: 'Eliminar publicación',
                          icon: const Icon(Icons.delete_outline, color: AppConfig.errorColor),
                          onPressed: () => _confirmDeletePost(context, forumProvider, post),
                        ),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ForumPostDetailScreen(post: post),
                      ),
                    );
                  },
                ),
              );
            },
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

  Future<void> _confirmDeletePost(
    BuildContext context,
    ForumProvider forumProvider,
    ForumPost post,
  ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Eliminar publicación'),
        content: Text('¿Quieres eliminar "${post.title}" y todas sus respuestas?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancelar'),
          ),
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(forumProvider.errorMessage ?? (success ? 'Publicación eliminada' : 'No se pudo eliminar la publicación'))),
    );
  }
}