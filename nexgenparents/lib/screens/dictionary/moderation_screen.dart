import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/dictionary_provider.dart';
import '../../models/dictionary_term_model.dart';
import '../../config/app_config.dart';

class ModerationScreen extends StatefulWidget {
  const ModerationScreen({super.key});

  @override
  State<ModerationScreen> createState() => _ModerationScreenState();
}

class _ModerationScreenState extends State<ModerationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DictionaryProvider>(context, listen: false).loadPendingTerms();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    // Verificar permisos de moderador
    if (!authProvider.isModerator) {
      return Scaffold(
        appBar: AppBar(title: const Text('Acceso Denegado')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppConfig.paddingLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.block,
                  size: 80,
                  color: AppConfig.errorColor,
                ),
                const SizedBox(height: AppConfig.paddingMedium),
                Text(
                  'No tienes permisos para acceder a esta sección',
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConfig.paddingSmall),
                Text(
                  'Solo los moderadores pueden revisar términos propuestos',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de Moderación'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Provider.of<DictionaryProvider>(context, listen: false)
                  .loadPendingTerms();
            },
            tooltip: 'Actualizar',
          ),
        ],
      ),
      body: Consumer<DictionaryProvider>(
        builder: (context, dictionaryProvider, child) {
          if (dictionaryProvider.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: AppConfig.paddingMedium),
                  Text('Cargando términos pendientes...'),
                ],
              ),
            );
          }

          final pendingTerms = dictionaryProvider.pendingTerms;

          if (pendingTerms.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppConfig.paddingLarge),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      size: 80,
                      color: AppConfig.accentColor,
                    ),
                    const SizedBox(height: AppConfig.paddingMedium),
                    Text(
                      '¡Todo revisado!',
                      style: Theme.of(context).textTheme.displayLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppConfig.paddingSmall),
                    Text(
                      'No hay términos pendientes de revisar',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return Column(
            children: [
              // Header con contador
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppConfig.paddingMedium),
                decoration: BoxDecoration(
                  color: AppConfig.warningColor.withOpacity(0.1),
                  border: Border(
                    bottom: BorderSide(
                      color: AppConfig.warningColor.withOpacity(0.3),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.pending_actions, color: AppConfig.warningColor),
                    const SizedBox(width: AppConfig.paddingSmall),
                    Text(
                      '${pendingTerms.length} términos pendientes de revisión',
                      style: const TextStyle(
                        fontSize: AppConfig.fontSizeBody,
                        fontWeight: FontWeight.bold,
                        color: AppConfig.warningColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Lista de términos pendientes
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(AppConfig.paddingMedium),
                  itemCount: pendingTerms.length,
                  itemBuilder: (context, index) {
                    final term = pendingTerms[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: AppConfig.paddingMedium),
                      child: ExpansionTile(
                        leading: const CircleAvatar(
                          backgroundColor: AppConfig.primaryColor,
                          child: Icon(Icons.article, color: Colors.white),
                        ),
                        title: Text(
                          term.term,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppConfig.fontSizeBody,
                          ),
                        ),
                        subtitle: Text(
                          term.categoryDisplayName,
                          style: const TextStyle(
                            fontSize: AppConfig.fontSizeCaption,
                            color: AppConfig.textSecondaryColor,
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(AppConfig.paddingMedium),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Definición
                                const Text(
                                  'Definición:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppConfig.fontSizeBody,
                                  ),
                                ),
                                const SizedBox(height: AppConfig.paddingSmall / 2),
                                Container(
                                  padding: const EdgeInsets.all(AppConfig.paddingSmall),
                                  decoration: BoxDecoration(
                                    color: AppConfig.backgroundLight,
                                    borderRadius: BorderRadius.circular(
                                      AppConfig.borderRadiusSmall,
                                    ),
                                  ),
                                  child: Text(
                                    term.definition,
                                    style: const TextStyle(fontSize: AppConfig.fontSizeBody),
                                  ),
                                ),
                                const SizedBox(height: AppConfig.paddingMedium),

                                // Ejemplo de uso
                                if (term.example.isNotEmpty) ...[
                                  const Text(
                                    'Ejemplo de uso:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppConfig.fontSizeBody,
                                    ),
                                  ),
                                  const SizedBox(height: AppConfig.paddingSmall / 2),
                                  Container(
                                    padding: const EdgeInsets.all(AppConfig.paddingSmall),
                                    decoration: BoxDecoration(
                                      color: AppConfig.accentColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(
                                        AppConfig.borderRadiusSmall,
                                      ),
                                    ),
                                    child: Text(
                                      '"${term.example}"',
                                      style: const TextStyle(
                                        fontSize: AppConfig.fontSizeBody,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: AppConfig.paddingMedium),
                                ],

                                // Información adicional
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today,
                                      size: 14,
                                      color: AppConfig.textSecondaryColor,
                                    ),
                                    const SizedBox(width: AppConfig.paddingSmall / 2),
                                    Text(
                                      'Propuesto el ${_formatDate(term.createdAt)}',
                                      style: const TextStyle(
                                        fontSize: AppConfig.fontSizeCaption,
                                        color: AppConfig.textSecondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppConfig.paddingMedium),

                                if (authProvider.isAdmin) ...[
                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton.icon(
                                      onPressed: () => _showEditTermDialog(context, term),
                                      icon: const Icon(Icons.edit),
                                      label: const Text('Editar término'),
                                    ),
                                  ),
                                  const SizedBox(height: AppConfig.paddingMedium),
                                ],

                                // Botones de acción
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        onPressed: () => _showRejectDialog(
                                          context,
                                          term.id,
                                          term.term,
                                        ),
                                        icon: const Icon(Icons.cancel),
                                        label: const Text('Rechazar'),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: AppConfig.errorColor,
                                          side: const BorderSide(
                                            color: AppConfig.errorColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: AppConfig.paddingMedium),
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: () => _approveTerm(
                                          context,
                                          term.id,
                                          term.term,
                                        ),
                                        icon: const Icon(Icons.check_circle),
                                        label: const Text('Aprobar'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppConfig.accentColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _approveTerm(BuildContext context, String termId, String termName) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final dictionaryProvider = Provider.of<DictionaryProvider>(context, listen: false);

    // Mostrar diálogo de confirmación
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: AppConfig.accentColor),
            SizedBox(width: AppConfig.paddingSmall),
            Text('Aprobar término'),
          ],
        ),
        content: Text(
          '¿Estás seguro de que deseas aprobar el término "$termName"?\n\n'
          'Será visible para todos los usuarios.',
          style: const TextStyle(fontSize: AppConfig.fontSizeBody),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConfig.accentColor,
            ),
            child: const Text('Aprobar'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final success = await dictionaryProvider.approveTerm(
      termId: termId,
      moderatorId: authProvider.currentUser!.id,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? '✓ Término "$termName" aprobado correctamente'
                : '✗ Error al aprobar el término',
          ),
          backgroundColor: success ? AppConfig.accentColor : AppConfig.errorColor,
        ),
      );
    }
  }

  Future<void> _showRejectDialog(
    BuildContext context,
    String termId,
    String termName,
  ) async {
    final reasonController = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.cancel, color: AppConfig.errorColor),
            SizedBox(width: AppConfig.paddingSmall),
            Text('Rechazar término'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '¿Por qué rechazas el término "$termName"?',
              style: const TextStyle(fontSize: AppConfig.fontSizeBody),
            ),
            const SizedBox(height: AppConfig.paddingMedium),
            TextField(
              controller: reasonController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Escribe el motivo del rechazo...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppConfig.paddingSmall),
            const Text(
              'El usuario verá este motivo en sus términos propuestos',
              style: TextStyle(
                fontSize: AppConfig.fontSizeCaption,
                color: AppConfig.textSecondaryColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (reasonController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Debes indicar un motivo para rechazar'),
                    backgroundColor: AppConfig.errorColor,
                  ),
                );
                return;
              }
              Navigator.of(context).pop(true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConfig.errorColor,
            ),
            child: const Text('Rechazar'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final dictionaryProvider = Provider.of<DictionaryProvider>(context, listen: false);

    final success = await dictionaryProvider.rejectTerm(
      termId: termId,
      reason: reasonController.text.trim(),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? '✓ Término "$termName" rechazado'
                : '✗ Error al rechazar el término',
          ),
          backgroundColor: success ? AppConfig.warningColor : AppConfig.errorColor,
        ),
      );
    }
  }

  Future<void> _showEditTermDialog(
    BuildContext context,
    DictionaryTerm term,
  ) async {
    final termController = TextEditingController(text: term.term);
    final definitionController = TextEditingController(text: term.definition);
    final exampleController = TextEditingController(text: term.example);
    String selectedCategory = term.category;

    final updated = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) => AlertDialog(
            title: const Text('Editar término'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: termController,
                    decoration: const InputDecoration(
                      labelText: 'Término',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: AppConfig.paddingMedium),
                  TextField(
                    controller: definitionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Definición',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: AppConfig.paddingMedium),
                  TextField(
                    controller: exampleController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Ejemplo (opcional)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: AppConfig.paddingMedium),
                  DropdownButtonFormField<String>(
                    initialValue: selectedCategory,
                    decoration: const InputDecoration(
                      labelText: 'Categoría',
                      border: OutlineInputBorder(),
                    ),
                    items: AppConfig.dictionaryCategories
                        .map(
                          (category) => DropdownMenuItem<String>(
                            value: category,
                            child: Text(_getCategoryLabel(category)),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setDialogState(() {
                        selectedCategory = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (termController.text.trim().isEmpty ||
                      definitionController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Término y definición son obligatorios'),
                        backgroundColor: AppConfig.errorColor,
                      ),
                    );
                    return;
                  }

                  final dictionaryProvider =
                      Provider.of<DictionaryProvider>(context, listen: false);

                  final success = await dictionaryProvider.updateTerm(
                    termId: term.id,
                    term: termController.text.trim(),
                    definition: definitionController.text.trim(),
                    example: exampleController.text.trim(),
                    category: selectedCategory,
                  );

                  if (!mounted) return;

                  if (success) {
                    Navigator.of(dialogContext).pop(true);
                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        dictionaryProvider.errorMessage ??
                            'No se pudo actualizar el término',
                      ),
                      backgroundColor: AppConfig.errorColor,
                    ),
                  );
                },
                child: const Text('Guardar cambios'),
              ),
            ],
          ),
        );
      },
    );

    if (updated == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✓ Término actualizado correctamente'),
          backgroundColor: AppConfig.accentColor,
        ),
      );
    }
  }

  String _getCategoryLabel(String category) {
    switch (category) {
      case 'jerga_gamer':
        return 'Jerga Gamer';
      case 'mecánicas_juego':
        return 'Mecánicas de Juego';
      case 'plataformas':
        return 'Plataformas';
      default:
        return category;
    }
  }
}