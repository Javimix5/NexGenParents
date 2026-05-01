import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/dictionary_provider.dart';
import '../../models/dictionary_term_model.dart';
import '../../config/app_config.dart';
import '../../config/app_theme.dart';
import '../../l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dictDetailTitle),
        actions: [
          // Mostramos los botones solo si el usuario tiene el rol adecuado
          if (isModeratorOrAdmin && dictionaryProvider.selectedTerm != null)
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: l10n.dictEditTooltip,
              onPressed: () =>
                  _showEditTermDialog(context, dictionaryProvider.selectedTerm!),
            ),
          if (isAdmin && dictionaryProvider.selectedTerm != null)
            IconButton(
              icon: const Icon(Icons.delete, color: AppConfig.errorColor),
              tooltip: l10n.dictDeleteTooltip,
              onPressed: () => _showDeleteConfirmationDialog(
                  context, dictionaryProvider.selectedTerm!.id),
            ),
        ],
      ),
      body: _buildBody(context, dictionaryProvider),
    );
  }

  Widget _buildBody(BuildContext context, DictionaryProvider dictionaryProvider) {
    final l10n = AppLocalizations.of(context)!;
    if (dictionaryProvider.isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: AppConfig.paddingMedium),
            Text(l10n.dictLoadingTerm),
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
            Text(l10n.dictErrorLoadingTerm),
            const SizedBox(height: AppConfig.paddingMedium),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.dictBackBtn),
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
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(AppConfig.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.description, color: AppConfig.primaryColor),
              const SizedBox(width: AppConfig.paddingSmall),
              Text(
                l10n.dictDefinitionLabel,
                style: const TextStyle(
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

    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConfig.paddingLarge),
      color: AppConfig.accentColor.withOpacity(0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.format_quote, color: AppConfig.accentColor),
              const SizedBox(width: AppConfig.paddingSmall),
              Text(
                l10n.dictExampleLabel,
                style: const TextStyle(
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
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(AppConfig.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.dictUsefulQuestion,
            style: const TextStyle(
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
                              SnackBar(
                                content: Text(l10n.dictVoteThanks),
                                backgroundColor: AppConfig.accentColor,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                  icon: Icon(_hasVoted ? Icons.check_circle : Icons.thumb_up),
                  label: Text(
                    _hasVoted ? l10n.dictVoteRegistered : l10n.dictVoteBtn,
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
                label: l10n.dictUsefulVotes,
                value: '${term.votes}',
                color: AppConfig.accentColor,
              ),
              _buildStatCard(
                icon: Icons.visibility,
                label: l10n.dictViews,
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
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(AppConfig.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.dictAdditionalInfo,
            style: const TextStyle(
              fontSize: AppConfig.fontSizeHeading,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConfig.paddingMedium),

          _buildInfoRow(
            icon: Icons.calendar_today,
            label: l10n.dictAddedOn,
            value: _formatDate(term.createdAt),
          ),
          const SizedBox(height: AppConfig.paddingSmall),

          _buildInfoRow(
            icon: Icons.update,
            label: l10n.dictLastUpdate,
            value: _formatDate(term.updatedAt),
          ),
          const SizedBox(height: AppConfig.paddingSmall),

          _buildInfoRow(
            icon: Icons.verified,
            label: l10n.dictStatusLabel,
            value: _getStatusText(term.status, l10n),
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

  String _getStatusText(String status, AppLocalizations l10n) {
    switch (status) {
      case 'approved':
        return l10n.dictStatusApproved;
      case 'pending':
        return l10n.dictStatusPending;
      case 'rejected':
        return l10n.dictStatusRejected;
      default:
        return status;
    }
  }

  // Diálogo para editar el término (solo para Admin/Moderator)
  void _showEditTermDialog(BuildContext context, DictionaryTerm currentTerm) {
    final l10n = AppLocalizations.of(context)!;
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
          title: Text(l10n.dictEditDialogTitle),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: termController,
                    decoration: InputDecoration(labelText: l10n.dictEditFieldTerm),
                    validator: (value) =>
                        value!.isEmpty ? l10n.dictEditErrorTerm : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: definitionController,
                    decoration: InputDecoration(labelText: l10n.dictEditFieldDefinition),
                    maxLines: 3,
                    validator: (value) => value!.isEmpty
                        ? l10n.dictEditErrorDefinition
                        : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: exampleController,
                    decoration: InputDecoration(labelText: l10n.dictEditFieldExample),
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
                    decoration: InputDecoration(labelText: l10n.dictEditFieldCategory),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.dictCancelBtn),
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
                        l10n.dictUpdateSuccess,
                        AppConfig.accentColor,
                      );
                    } else {
                      _showSnackBar(
                        context,
                        dictionaryProvider.errorMessage ??
                            l10n.dictUpdateError,
                        AppConfig.errorColor,
                      );
                    }
                  }
                }
              },
              child: Text(l10n.dictSaveChangesBtn),
            ),
          ],
        );
      },
    );
  }

  // Diálogo de confirmación para eliminar (solo para Admin)
  void _showDeleteConfirmationDialog(BuildContext context, String termId) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.dictDeleteConfirmTitle),
          content: Text(l10n.dictDeleteConfirmContent),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.dictCancelBtn),
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
                      l10n.dictDeleteSuccess,
                      AppConfig.accentColor,
                    );
                  } else {
                    _showSnackBar(
                      context,
                      dictionaryProvider.errorMessage ??
                          l10n.dictDeleteError,
                      AppConfig.errorColor,
                    );
                  }
                }
              },
              child: Text(l10n.dictDeleteBtn),
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