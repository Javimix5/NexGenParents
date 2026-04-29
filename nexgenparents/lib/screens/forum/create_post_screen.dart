import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_config.dart';
import '../../models/forum_section.dart';
import '../../providers/auth_provider.dart';
import '../../providers/forum_provider.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String _selectedSectionId = ForumSections.general.id;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final forumProvider = Provider.of<ForumProvider>(context, listen: false);

    final user = authProvider.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes iniciar sesión para publicar')),
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
      Navigator.of(context).pop();
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(forumProvider.errorMessage ?? 'Error desconocido')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(title: const Text('Crear Nuevo Hilo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConfig.paddingMedium),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'El título es obligatorio'
                    : null,
              ),
              const SizedBox(height: AppConfig.paddingMedium),
              DropdownButtonFormField<String>(
                initialValue: _selectedSectionId,
                decoration: const InputDecoration(labelText: 'Sección'),
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
                decoration: const InputDecoration(
                  labelText: 'Contenido',
                  alignLabelWithHint: true,
                ),
                maxLines: 8,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'El contenido es obligatorio'
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
                        Text(provider.isLoading ? 'Publicando...' : 'Publicar'),
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
    );
  }
}
