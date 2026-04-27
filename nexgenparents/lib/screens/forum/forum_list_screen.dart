import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_config.dart';
import '../../models/forum_post_model.dart';
import '../../models/forum_section.dart';
import '../../providers/auth_provider.dart';
import '../../providers/forum_provider.dart';
import '../../widgets/common/app_empty_state.dart';
import 'create_post_screen.dart';
import 'forum_post_detail_screen.dart';

class ForumListScreen extends StatefulWidget {
  final String? topicFilter;

  const ForumListScreen({super.key, this.topicFilter});

  @override
  State<ForumListScreen> createState() => _ForumListScreenState();
}

class _ForumListScreenState extends State<ForumListScreen> {
  String? _selectedSectionId;

  @override
  void initState() {
    super.initState();
    _selectedSectionId = widget.topicFilter == null
        ? null
        : ForumSections.idFromLegacyTopic(widget.topicFilter);
  }

  @override
  Widget build(BuildContext context) {
    final forumProvider = Provider.of<ForumProvider>(context, listen: false);
    final authProvider = context.watch<AuthProvider>();
    final isAdmin = authProvider.isAdmin;
    final languageCode = Localizations.localeOf(context).languageCode;
    final titleText = _selectedSectionId == null
        ? 'Comunidad'
        : 'Comunidad · ${ForumSections.byId(_selectedSectionId).localizedName(languageCode)}';

    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
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
            return const AppEmptyState(
              icon: Icons.forum_outlined,
              title: 'No hay publicaciones todavía',
              message: 'Sé el primero en abrir un hilo.',
            );
          }

          final allPosts = snapshot.data!;
          final posts = _selectedSectionId == null
              ? allPosts
              : allPosts
                  .where(
                      (post) => post.effectiveSectionId == _selectedSectionId)
                  .toList();

          return Column(
            children: [
              _buildSectionPicker(languageCode),
              Expanded(
                child: posts.isEmpty
                    ? AppEmptyState(
                        icon: Icons.forum_outlined,
                        title: 'No hay publicaciones en esta sección',
                        message: _selectedSectionId == null
                            ? 'Sé el primero en abrir un hilo.'
                            : 'Todavía no hay novedades en esta sección.',
                      )
                    : ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          final sectionLabel =
                              ForumSections.byId(post.effectiveSectionId)
                                  .localizedName(languageCode);

                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: AppConfig.paddingMedium,
                              vertical: AppConfig.paddingSmall,
                            ),
                            child: ListTile(
                              title: Text(
                                post.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'por ${post.authorName} • ${post.replyCount} respuestas • $sectionLabel',
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (isAdmin)
                                    IconButton(
                                      tooltip: 'Eliminar publicación',
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: AppConfig.errorColor,
                                      ),
                                      onPressed: () => _confirmDeletePost(
                                        context,
                                        forumProvider,
                                        post,
                                      ),
                                    ),
                                  const Icon(Icons.arrow_forward_ios, size: 16),
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ForumPostDetailScreen(
                                      post: post,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
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

  Widget _buildSectionPicker(String languageCode) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(
        AppConfig.paddingMedium,
        AppConfig.paddingSmall,
        AppConfig.paddingMedium,
        AppConfig.paddingSmall,
      ),
      child: Row(
        children: [
          ChoiceChip(
            label: const Text('Todas'),
            selected: _selectedSectionId == null,
            onSelected: (_) {
              setState(() {
                _selectedSectionId = null;
              });
            },
          ),
          const SizedBox(width: 8),
          for (final section in ForumSections.all) ...[
            ChoiceChip(
              label: Text(section.localizedName(languageCode)),
              selected: _selectedSectionId == section.id,
              onSelected: (_) {
                setState(() {
                  _selectedSectionId = section.id;
                });
              },
            ),
            const SizedBox(width: 8),
          ],
        ],
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
        content:
            Text('¿Quieres eliminar "${post.title}" y todas sus respuestas?'),
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

    final success = await forumProvider.deletePost(post.id);
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(forumProvider.errorMessage ??
              (success
                  ? 'Publicación eliminada'
                  : 'No se pudo eliminar la publicación'))),
    );
  }
}
