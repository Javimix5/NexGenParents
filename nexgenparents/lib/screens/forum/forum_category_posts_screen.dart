import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/app_config.dart';
import '../../../models/forum_post_model.dart';
import '../../../models/forum_section.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/forum_provider.dart';
import '../../../widgets/common/app_empty_state.dart';
import 'forum_post_detail_screen.dart';
import 'create_post_screen.dart';
import '../../../l10n/app_localizations.dart';

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
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 300 && !_showBackToTopButton) {
        setState(() => _showBackToTopButton = true);
      } else if (_scrollController.offset < 300 && _showBackToTopButton) {
        setState(() => _showBackToTopButton = false);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final isAdmin = authProvider.isAdmin;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final languageCode = Localizations.localeOf(context).languageCode;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.section.localizedName(languageCode)),
      ),
      body: Consumer<ForumProvider>(
        builder: (context, forumProvider, child) {
          if (forumProvider.isPostsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final allPosts = forumProvider.posts;
                final sectionPosts = allPosts.where((p) {
            final matchesSection = p.effectiveSectionId == widget.section.id;
            final matchesSearch = p.title.toLowerCase().contains(_searchQuery.toLowerCase());
            return matchesSection && matchesSearch;
          }).toList();

          final cardColor = isDark ? const Color(0xFF1A1A2E) : Colors.white;
          final subtitleColor = isDark ? Colors.white60 : Colors.black54;

          return Column(
            children: [
              // Buscador integrado
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                      hintText: l10n.forumSearchHint,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: isDark ? Colors.white10 : Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  onChanged: (value) => setState(() => _searchQuery = value),
                ),
              ),
              
              // Lista de resultados
              Expanded(
                child: sectionPosts.isEmpty
                    ? AppEmptyState(
                        icon: _searchQuery.isNotEmpty ? Icons.search_off : Icons.forum_outlined,
                        title: _searchQuery.isNotEmpty ? l10n.forumEmptySearchTitle : l10n.forumEmptyCategoryTitle,
                        message: _searchQuery.isNotEmpty 
                            ? l10n.forumEmptySearchMessage 
                            : l10n.forumEmptyCategoryMessage,
                      )
                    : ListView.builder(
                        controller: _scrollController,
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
                                l10n.forumPostSubtitle(post.authorName, post.replyCount),
                                style: TextStyle(color: subtitleColor, fontSize: 12),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (isAdmin)
                                    IconButton(
                                      tooltip: l10n.forumDeleteTooltip,
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
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (_showBackToTopButton) ...[
            FloatingActionButton.small(
              heroTag: 'back_to_top_btn',
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              backgroundColor: isDark ? Colors.grey[800] : Colors.white,
              foregroundColor: isDark ? Colors.white : Colors.black87,
              child: const Icon(Icons.arrow_upward),
            ),
            const SizedBox(height: 16),
          ],
          FloatingActionButton.extended(
            heroTag: 'create_post_btn',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => CreatePostScreen(initialSectionId: widget.section.id)),
              );
            },
            label: Text(l10n.forumNewPostBtn),
            icon: const Icon(Icons.add),
            backgroundColor: AppConfig.accentColor,
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDeletePost(BuildContext context, ForumProvider forumProvider, ForumPost post) async {
    final l10n = AppLocalizations.of(context)!;
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.forumDeletePostTitle),
        content: Text(l10n.forumDeletePostContent(post.title)),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: Text(l10n.forumCancelBtn)),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.forumDeleteBtn, style: const TextStyle(color: AppConfig.errorColor)),
          ),
        ],
      ),
    );

    if (shouldDelete != true) return;
    final success = await forumProvider.deletePost(post.id);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(forumProvider.errorMessage ?? (success ? l10n.forumPostDeletedSuccess : l10n.forumPostDeletedError)),
    ));
  }
}