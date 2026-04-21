import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/dictionary_provider.dart';
import '../../models/dictionary_term_model.dart';
import '../../config/app_config.dart';
import '../../config/app_theme.dart';

class TermDetailScreen extends StatefulWidget {
  final String termId;

  const TermDetailScreen({
    super.key,
    required this.termId,
  });

  @override
  State<TermDetailScreen> createState() => _TermDetailScreenState();
}

class _TermDetailScreenState extends State<TermDetailScreen> {
  bool _hasVoted = false;

  @override
  void initState() {
    super.initState();
    // Cargar detalles del término
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DictionaryProvider>(context, listen: false)
          .loadTermDetail(widget.termId);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos el rol del usuario actual desde el AuthProvider
    final currentUser = Provider.of<AuthProvider>(context).currentUser;
    final dictionaryProvider = Provider.of<DictionaryProvider>(context);
    final isModeratorOrAdmin =
        ['moderator', 'admin'].contains(currentUser?.role);
    final isAdmin = currentUser?.isAdmin ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Término'),
        actions: [
          // Mostramos los botones solo si el usuario tiene el rol adecuado
          if (isModeratorOrAdmin && dictionaryProvider.selectedTerm != null)
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Editar Término',
              onPressed: () =>
                  _showEditTermDialog(context, dictionaryProvider.selectedTerm!),
            ),
          if (isAdmin && dictionaryProvider.selectedTerm != null)
            IconButton(
              icon: const Icon(Icons.delete, color: AppConfig.errorColor),
              tooltip: 'Eliminar Término',
              onPressed: () => _showDeleteConfirmationDialog(
                  context, dictionaryProvider.selectedTerm!.id),
            ),
        ],
      ),
      body: _buildBody(context, dictionaryProvider),
    );
  }

  Widget _buildBody(BuildContext context, DictionaryProvider dictionaryProvider) {
    if (dictionaryProvider.isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: AppConfig.paddingMedium),
            Text('Cargando término...'),
          ],
        ),
      );
    }

    final term = dictionaryProvider.selectedTerm;

    if (term == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 60,
              color: AppConfig.errorColor,
            ),
            const SizedBox(height: AppConfig.paddingMedium),
            const Text('No se pudo cargar el término'),
            const SizedBox(height: AppConfig.paddingMedium),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Volver'),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con el término y categoría
          _buildHeader(term),

          const Divider(height: 1),

          // Definición
          _buildDefinitionSection(term),

          const Divider(height: 1),

          // Ejemplo de uso
          _buildExampleSection(term),

          const Divider(height: 1),

          // Estadísticas y votos
          _buildStatsSection(term, dictionaryProvider),

          const Divider(height: 1),

          // Información adicional
          _buildAdditionalInfo(term),

          const SizedBox(height: AppConfig.paddingLarge * 2),
        ],
      ),
    );
  }

  Widget _buildHeader(DictionaryTerm term) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConfig.paddingLarge),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppConfig.primaryColor,
            AppConfig.secondaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Término principal
          Text(
            term.term,
            style: const TextStyle(
              fontSize: AppConfig.fontSizeTitle + 4,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppConfig.paddingSmall),

          // Categoría
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConfig.paddingMedium,
              vertical: AppConfig.paddingSmall,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppConfig.borderRadiusLarge),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getCategoryIcon(term.category),
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: AppConfig.paddingSmall / 2),
                Text(
                  term.categoryDisplayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: AppConfig.fontSizeCaption,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefinitionSection(DictionaryTerm term) {
    return Padding(
      padding: const EdgeInsets.all(AppConfig.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.description, color: AppConfig.primaryColor),
              SizedBox(width: AppConfig.paddingSmall),
              Text(
                'Definición',
                style: TextStyle(
                  fontSize: AppConfig.fontSizeHeading,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConfig.paddingMedium),
          Text(
            term.definition,
            style: const TextStyle(
              fontSize: AppConfig.fontSizeBody,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleSection(DictionaryTerm term) {
    if (term.example.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConfig.paddingLarge),
      color: AppConfig.accentColor.withOpacity(0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.format_quote, color: AppConfig.accentColor),
              SizedBox(width: AppConfig.paddingSmall),
              Text(
                'Ejemplo de uso',
                style: TextStyle(
                  fontSize: AppConfig.fontSizeHeading,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConfig.paddingMedium),
          Container(
            padding: const EdgeInsets.all(AppConfig.paddingMedium),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
              border: Border.all(
                color: AppConfig.accentColor.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Text(
              '"${term.example}"',
              style: const TextStyle(
                fontSize: AppConfig.fontSizeBody,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(DictionaryTerm term, DictionaryProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(AppConfig.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '¿Te ha sido útil este término?',
            style: TextStyle(
              fontSize: AppConfig.fontSizeHeading,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConfig.paddingMedium),

          // Botón de votar
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _hasVoted
                      ? null
                      : () async {
                          await provider.voteForTerm(term.id);
                          setState(() {
                            _hasVoted = true;
                          });
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('¡Gracias por tu voto!'),
                                backgroundColor: AppConfig.accentColor,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                  icon: Icon(_hasVoted ? Icons.check_circle : Icons.thumb_up),
                  label: Text(
                    _hasVoted ? 'Voto registrado' : 'Sí, me ha ayudado',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _hasVoted ? AppConfig.accentColor : AppConfig.primaryColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppConfig.paddingMedium,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConfig.paddingMedium),

          // Estadísticas
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatCard(
                icon: Icons.thumb_up,
                label: 'Votos útiles',
                value: '${term.votes}',
                color: AppConfig.accentColor,
              ),
              _buildStatCard(
                icon: Icons.visibility,
                label: 'Visualizaciones',
                value: '${term.viewCount}',
                color: AppConfig.primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConfig.paddingMedium),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: AppConfig.paddingSmall / 2),
          Text(
            value,
            style: TextStyle(
              fontSize: AppConfig.fontSizeHeading,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: AppConfig.paddingSmall / 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: AppConfig.fontSizeCaption,
              color: AppConfig.textSecondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfo(DictionaryTerm term) {
    return Padding(
      padding: const EdgeInsets.all(AppConfig.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Información adicional',
            style: TextStyle(
              fontSize: AppConfig.fontSizeHeading,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConfig.paddingMedium),

          _buildInfoRow(
            icon: Icons.calendar_today,
            label: 'Añadido el',
            value: _formatDate(term.createdAt),
          ),
          const SizedBox(height: AppConfig.paddingSmall),

          _buildInfoRow(
            icon: Icons.update,
            label: 'Última actualización',
            value: _formatDate(term.updatedAt),
          ),
          const SizedBox(height: AppConfig.paddingSmall),

          _buildInfoRow(
            icon: Icons.verified,
            label: 'Estado',
            value: _getStatusText(term.status),
            valueColor: AppTheme.getStatusColor(term.status),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppConfig.textSecondaryColor),
        const SizedBox(width: AppConfig.paddingSmall),
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: AppConfig.fontSizeBody,
            color: AppConfig.textSecondaryColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: AppConfig.fontSizeBody,
            fontWeight: FontWeight.w600,
            color: valueColor ?? AppConfig.textPrimaryColor,
          ),
        ),
      ],
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'jerga_gamer':
        return Icons.chat_bubble_outline;
      case 'mecánicas_juego':
        return Icons.sports_esports;
      case 'plataformas':
        return Icons.devices;
      default:
        return Icons.category;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'approved':
        return 'Aprobado';
      case 'pending':
        return 'Pendiente';
      case 'rejected':
        return 'Rechazado';
      default:
        return status;
    }
  }

  // Diálogo para editar el término (solo para Admin/Moderator)
  void _showEditTermDialog(BuildContext context, DictionaryTerm currentTerm) {
    final formKey = GlobalKey<FormState>();
    final termController = TextEditingController(text: currentTerm.term);
    final definitionController =
        TextEditingController(text: currentTerm.definition);
    final exampleController = TextEditingController(text: currentTerm.example);
    String selectedCategory = currentTerm.category;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Término'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: termController,
                    decoration: const InputDecoration(labelText: 'Término'),
                    validator: (value) =>
                        value!.isEmpty ? 'El término no puede estar vacío' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: definitionController,
                    decoration: const InputDecoration(labelText: 'Definición'),
                    maxLines: 3,
                    validator: (value) => value!.isEmpty
                        ? 'La definición no puede estar vacía'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: exampleController,
                    decoration:
                        const InputDecoration(labelText: 'Ejemplo (opcional)'),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: selectedCategory,
                    items: AppConfig.dictionaryCategories.map((category) {
                      return DropdownMenuItem(
                          value: category, child: Text(category));
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        selectedCategory = value;
                      }
                    },
                    decoration: const InputDecoration(labelText: 'Categoría'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  final dictionaryProvider =
                      Provider.of<DictionaryProvider>(context, listen: false);
                  final success = await dictionaryProvider.updateTerm(
                    termId: currentTerm.id,
                    term: termController.text,
                    definition: definitionController.text,
                    example: exampleController.text,
                    category: selectedCategory,
                  );

                  Navigator.of(context).pop(); // Cierra el diálogo

                  if (context.mounted) {
                    if (success) {
                      _showSnackBar(
                        context,
                        'Término actualizado correctamente',
                        AppConfig.accentColor,
                      );
                    } else {
                      _showSnackBar(
                        context,
                        dictionaryProvider.errorMessage ??
                            'Error al actualizar el término',
                        AppConfig.errorColor,
                      );
                    }
                  }
                }
              },
              child: const Text('Guardar Cambios'),
            ),
          ],
        );
      },
    );
  }

  // Diálogo de confirmación para eliminar (solo para Admin)
  void _showDeleteConfirmationDialog(BuildContext context, String termId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar Eliminación'),
          content: const Text(
              '¿Estás seguro de que quieres eliminar este término de forma permanente? Esta acción no se puede deshacer.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppConfig.errorColor),
              onPressed: () async {
                final dictionaryProvider =
                    Provider.of<DictionaryProvider>(context, listen: false);
                final success = await dictionaryProvider.deleteTerm(termId);

                // Cierra el diálogo de confirmación
                Navigator.of(context).pop();

                if (context.mounted) {
                  // Cierra la pantalla de detalle y vuelve a la lista
                  Navigator.of(context).pop();

                  if (success) {
                    _showSnackBar(
                      context,
                      'Término eliminado correctamente',
                      AppConfig.accentColor,
                    );
                  } else {
                    _showSnackBar(
                      context,
                      dictionaryProvider.errorMessage ??
                          'Error al eliminar el término',
                      AppConfig.errorColor,
                    );
                  }
                }
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}