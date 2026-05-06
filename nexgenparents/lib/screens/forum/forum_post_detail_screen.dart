import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../config/app_config.dart';
import '../../models/forum_post_model.dart';
import '../../models/forum_reply_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/forum_provider.dart';
import '../../l10n/app_localizations.dart';

class ForumPostDetailScreen extends StatefulWidget {
  final ForumPost post;
  const ForumPostDetailScreen({super.key, required this.post});

  @override
  State<ForumPostDetailScreen> createState() => _ForumPostDetailScreenState();
}

class _ForumPostDetailScreenState extends State<ForumPostDetailScreen> {
  final _replyController = TextEditingController();
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
    _replyController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
        actions: [
          if (isAdmin)
            IconButton(
              tooltip: l10n.forumDeleteTooltip,
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _confirmDeletePost(context, forumProvider),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
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
                        Text(l10n.forumPostByAuthor(widget.post.authorName),
                            style: Theme.of(context).textTheme.bodySmall),
                        const Divider(height: AppConfig.paddingLarge),
                        Text(widget.post.content,
                            style: Theme.of(context).textTheme.bodyLarge),
                        const Divider(height: AppConfig.paddingLarge),
                        Text(l10n.forumDetailRepliesTitle,
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
                      return _buildRepliesShimmer(context);
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding:
                              const EdgeInsets.all(AppConfig.paddingMedium),
                          child:
                              Center(child: Text(l10n.forumDetailEmptyReplies)),
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
                            subtitle:
                                Text(l10n.forumPostByAuthor(reply.authorName)),
                            trailing: isAdmin
                                ? IconButton(
                                    tooltip: l10n.forumDeleteReplyTooltip,
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
      floatingActionButton: _showBackToTopButton
          ? FloatingActionButton.small(
              heroTag: 'forum_post_back_to_top_btn',
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
            )
          : null,
    );
  }

  Future<void> _confirmDeletePost(
      BuildContext context, ForumProvider forumProvider) async {
    final l10n = AppLocalizations.of(context)!;
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.forumDeletePostTitle),
        content: Text(l10n.forumDeletePostContent(widget.post.title)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.forumCancelBtn),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.forumDeleteBtn,
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
                  ? l10n.forumPostDeletedSuccess
                  : l10n.forumPostDeletedError))),
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
    final l10n = AppLocalizations.of(context)!;
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.forumDeleteReplyTitle),
        content: Text(l10n.forumDeleteReplyContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.forumCancelBtn),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.forumDeleteBtn,
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
                  ? l10n.forumReplyDeletedSuccess
                  : l10n.forumReplyDeletedError))),
    );
  }

  Widget _buildReplyInput() {
    final l10n = AppLocalizations.of(context)!;
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
                decoration: InputDecoration(
                  hintText: l10n.forumDetailReplyInputHint,
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

  Widget _buildRepliesShimmer(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[850]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 14, width: double.infinity, color: Colors.white),
                  const SizedBox(height: 4),
                  Container(height: 14, width: 200, color: Colors.white),
                  const SizedBox(height: 8),
                ],
              ),
              subtitle: Container(height: 12, width: 100, color: Colors.white),
            ),
          );
        },
        childCount: 4, // Simulamos que están cargando 4 respuestas
      ),
    );
  }
}
