import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../config/app_config.dart';
import '../../models/forum_section.dart';
import '../../providers/auth_provider.dart';
import '../../providers/forum_provider.dart';
import '../../l10n/app_localizations.dart';

class CreatePostScreen extends StatefulWidget {
  final String? initialSectionId;

  const CreatePostScreen({super.key, this.initialSectionId});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  late String _selectedSectionId;
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    _selectedSectionId = widget.initialSectionId ?? ForumSections.general.id;
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
    _titleController.dispose();
    _contentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final l10n = AppLocalizations.of(context)!;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final forumProvider = Provider.of<ForumProvider>(context, listen: false);

    final user = authProvider.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.forumCreateLoginRequired)),
      );
      return;
    }

    final success = await forumProvider.createPost(
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      authorId: user.id,
      authorName: user.displayName,
      sectionId: _selectedSectionId,
    );

    if (success && mounted) {
      HapticFeedback.lightImpact();
      Navigator.of(context).pop();
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(forumProvider.errorMessage ?? l10n.forumCreateUnknownError)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.forumCreateTitle)),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(AppConfig.paddingMedium),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: l10n.forumCreateFieldTitle),
                validator: (value) => (value == null || value.isEmpty)
                    ? l10n.forumCreateErrorTitle
                    : null,
              ),
              const SizedBox(height: AppConfig.paddingMedium),
              DropdownButtonFormField<String>(
                initialValue: _selectedSectionId,
                decoration: InputDecoration(labelText: l10n.forumCreateFieldSection),
                items: [
                  for (final section in ForumSections.all)
                    DropdownMenuItem(
                      value: section.id,
                      child: Text(section.localizedName(languageCode)),
                    ),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedSectionId = value;
                  });
                },
              ),
              const SizedBox(height: AppConfig.paddingMedium),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(
                  labelText: l10n.forumCreateFieldContent,
                  alignLabelWithHint: true,
                ),
                maxLines: 8,
                validator: (value) => (value == null || value.isEmpty)
                    ? l10n.forumCreateErrorContent
                    : null,
              ),
              const SizedBox(height: AppConfig.paddingLarge),
              Consumer<ForumProvider>(
                builder: (context, provider, child) {
                  return ElevatedButton.icon(
                    onPressed: provider.isLoading ? null : _handleSubmit,
                    icon: provider.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2))
                        : const Icon(Icons.send),
                    label:
                        Text(provider.isLoading ? l10n.forumCreatePublishingBtn : l10n.forumCreatePublishBtn),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppConfig.paddingMedium),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _showBackToTopButton
          ? FloatingActionButton.small(
              heroTag: 'create_post_back_to_top_btn',
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
}
