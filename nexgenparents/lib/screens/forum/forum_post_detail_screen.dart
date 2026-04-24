import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_config.dart';
import '../../models/forum_post_model.dart';
import '../../models/forum_reply_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/forum_provider.dart';

class ForumPostDetailScreen extends StatefulWidget {
  final ForumPost post;
  const ForumPostDetailScreen({super.key, required this.post});

  @override
  State<ForumPostDetailScreen> createState() => _ForumPostDetailScreenState();
}

class _ForumPostDetailScreenState extends State<ForumPostDetailScreen> {
  final _replyController = TextEditingController();

  void _sendReply() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final forumProvider = Provider.of<ForumProvider>(context, listen: false);
    final user = authProvider.currentUser;

    if (_replyController.text.trim().isEmpty || user == null) {
      return;
    }

    final newReply = ForumReply(
      id: '',
      postId: widget.post.id,
      content: _replyController.text.trim(),
      authorId: user.id,
      authorName: user.displayName,
      createdAt: DateTime.now(),
    );

    forumProvider.addReply(newReply);
    _replyController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final forumProvider = Provider.of<ForumProvider>(context, listen: false);
    final authProvider = context.watch<AuthProvider>();
    final isAdmin = authProvider.isAdmin;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
        actions: [
          if (isAdmin)
            IconButton(
              tooltip: 'Eliminar publicación',
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _confirmDeletePost(context, forumProvider),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                // Contenido de la publicación original
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConfig.paddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.post.title,
                            style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: AppConfig.paddingSmall),
                        Text('por ${widget.post.authorName}',
                            style: Theme.of(context).textTheme.bodySmall),
                        const Divider(height: AppConfig.paddingLarge),
                        Text(widget.post.content,
                            style: Theme.of(context).textTheme.bodyLarge),
                        const Divider(height: AppConfig.paddingLarge),
                        Text('Respuestas',
                            style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                  ),
                ),
                // Lista de respuestas
                StreamBuilder<List<ForumReply>>(
                  stream: forumProvider.getRepliesStream(widget.post.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator()));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(AppConfig.paddingMedium),
                          child:
                              Center(child: Text('No hay respuestas todavía.')),
                        ),
                      );
                    }
                    final replies = snapshot.data!;
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final reply = replies[index];
                          return ListTile(
                            title: Text(reply.content),
                            subtitle: Text('por ${reply.authorName}'),
                            trailing: isAdmin
                                ? IconButton(
                                    tooltip: 'Eliminar respuesta',
                                    icon: const Icon(Icons.delete_outline,
                                        color: AppConfig.errorColor),
                                    onPressed: () => _confirmDeleteReply(
                                        context, forumProvider, reply),
                                  )
                                : null,
                          );
                        },
                        childCount: replies.length,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // Campo para escribir una nueva respuesta
          _buildReplyInput(),
        ],
      ),
    );
  }

  Future<void> _confirmDeletePost(
      BuildContext context, ForumProvider forumProvider) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Eliminar publicación'),
        content: const Text(
            '¿Quieres eliminar esta publicación y todas sus respuestas?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Eliminar',
                style: TextStyle(color: AppConfig.errorColor)),
          ),
        ],
      ),
    );

    if (shouldDelete != true) return;

    final success = await forumProvider.deletePost(widget.post.id);
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(forumProvider.errorMessage ??
              (success
                  ? 'Publicación eliminada'
                  : 'No se pudo eliminar la publicación'))),
    );

    if (success && context.mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _confirmDeleteReply(
    BuildContext context,
    ForumProvider forumProvider,
    ForumReply reply,
  ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Eliminar respuesta'),
        content: const Text('¿Quieres eliminar esta respuesta?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Eliminar',
                style: TextStyle(color: AppConfig.errorColor)),
          ),
        ],
      ),
    );

    if (shouldDelete != true) return;

    final success = await forumProvider.deleteReply(
        replyId: reply.id, postId: reply.postId);
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(forumProvider.errorMessage ??
              (success
                  ? 'Respuesta eliminada'
                  : 'No se pudo eliminar la respuesta'))),
    );
  }

  Widget _buildReplyInput() {
    return Container(
      padding: const EdgeInsets.all(AppConfig.paddingSmall),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _replyController,
                decoration: const InputDecoration(
                  hintText: 'Escribe una respuesta...',
                  border: InputBorder.none,
                ),
                maxLines: null,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: AppConfig.accentColor),
              onPressed: _sendReply,
            ),
          ],
        ),
      ),
    );
  }
}
