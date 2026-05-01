import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/dictionary_provider.dart';
import '../../models/dictionary_term_model.dart';
import '../../config/app_config.dart';
import '../../widgets/common/back_to_top_scaffold.dart';
import '../../l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;

    // Verificar permisos de moderador
    if (!authProvider.isModerator) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.dictModAccessDeniedTitle)),
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
                l10n.dictModAccessDeniedMessage,
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConfig.paddingSmall),
                Text(
                l10n.dictModAccessDeniedSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return BackToTopScaffold(
      heroTag: 'moderation_back_to_top_btn',
      appBar: AppBar(
        title: Text(l10n.dictModTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Provider.of<DictionaryProvider>(context, listen: false)
                  .loadPendingTerms();
            },
            tooltip: l10n.dictModRefreshTooltip,
          ),
        ],
      ),
      builder: (context, scrollController) {
        return Consumer<DictionaryProvider>(
        builder: (context, dictionaryProvider, child) {
          if (dictionaryProvider.isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: AppConfig.paddingMedium),
                  Text(l10n.dictModLoading),
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
                    l10n.dictModAllReviewedTitle,
                      style: Theme.of(context).textTheme.displayLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppConfig.paddingSmall),
                    Text(
                    l10n.dictModAllReviewedMessage,
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
                      l10n.dictModPendingCount(pendingTerms.length),
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
                child: RefreshIndicator(
                  onRefresh: () async {
                    Provider.of<DictionaryProvider>(context, listen: false).loadPendingTerms();
                    await Future.delayed(const Duration(milliseconds: 600));
                  },
                  child: ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(AppConfig.paddingMedium),
                    itemCount: pendingTerms.length,
                    itemBuilder: (context, index) {
                      final term = pendingTerms[index];
                      return Dismissible(
                        key: Key(term.id),
                        direction: DismissDirection.horizontal,
                        background: Container(
                          color: AppConfig.accentColor,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.check_circle, color: Colors.white, size: 30),
                        ),
                        secondaryBackground: Container(
                          color: AppConfig.errorColor,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.cancel, color: Colors.white, size: 30),
                        ),
                        confirmDismiss: (direction) async {
                          HapticFeedback.selectionClick();
                          if (direction == DismissDirection.startToEnd) {
                            await _approveTerm(context, term.id, term.term);
                          } else {
                            await _showRejectDialog(context, term.id, term.term);
                          }
                          // Devolvemos false porque el Stream actualizará y eliminará la tarjeta sola
                          return false;
                        },
                        child: Card(
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
                                Text(
                                  l10n.dictModDefinitionLabel,
                                  style: const TextStyle(
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
                                  Text(
                                    l10n.dictModExampleLabel,
                                    style: const TextStyle(
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
                                      l10n.dictModProposedOn(_formatDate(term.createdAt)),
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
                                      label: Text(l10n.dictModEditBtn),
                                        ),
                                      ),
                                      const SizedBox(height: AppConfig.paddingMedium),
                                    ],

                                    // Pista visual para Swipe
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.swipe_left, size: 16, color: AppConfig.textSecondaryColor),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Desliza para aprobar o rechazar',
                                          style: TextStyle(
                                            fontSize: AppConfig.fontSizeCaption,
                                            color: AppConfig.textSecondaryColor,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(Icons.swipe_right, size: 16, color: AppConfig.textSecondaryColor),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ); },
    );
  }


  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<bool> _approveTerm(BuildContext context, String termId, String termName) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final dictionaryProvider = Provider.of<DictionaryProvider>(context, listen: false);
    final l10n = AppLocalizations.of(context)!;

    // Mostrar diálogo de confirmación
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.check_circle, color: AppConfig.accentColor),
            const SizedBox(width: AppConfig.paddingSmall),
            Text(l10n.dictModApproveTitle),
          ],
        ),
        content: Text(
          l10n.dictModApproveConfirm(termName),
          style: const TextStyle(fontSize: AppConfig.fontSizeBody),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.dictModCancelBtn),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConfig.accentColor,
            ),
            child: Text(l10n.dictModApproveBtn),
          ),
        ],
      ),
    );

    if (confirm != true) return false;

    final success = await dictionaryProvider.approveTerm(
      termId: termId,
      moderatorId: authProvider.currentUser!.id,
    );

    if (success) HapticFeedback.lightImpact();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? l10n.dictModApproveSuccess(termName)
                : l10n.dictModApproveError,
          ),
          backgroundColor: success ? AppConfig.accentColor : AppConfig.errorColor,
        ),
      );
    }

    return success;
  }

  Future<bool> _showRejectDialog(
    BuildContext context,
    String termId,
    String termName,
  ) async {
    final reasonController = TextEditingController();
    final l10n = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.cancel, color: AppConfig.errorColor),
            const SizedBox(width: AppConfig.paddingSmall),
            Text(l10n.dictModRejectTitle),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.dictModRejectReasonTitle(termName),
              style: const TextStyle(fontSize: AppConfig.fontSizeBody),
            ),
            const SizedBox(height: AppConfig.paddingMedium),
            TextField(
              controller: reasonController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: l10n.dictModRejectHint,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppConfig.paddingSmall),
            Text(
              l10n.dictModRejectWarning,
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
            child: Text(l10n.dictModCancelBtn),
          ),
          ElevatedButton(
            onPressed: () {
              if (reasonController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.dictModRejectErrorEmpty),
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
            child: Text(l10n.dictModRejectBtn),
          ),
        ],
      ),
    );

    if (confirmed != true) return false;

    final dictionaryProvider = Provider.of<DictionaryProvider>(context, listen: false);

    final success = await dictionaryProvider.rejectTerm(
      termId: termId,
      reason: reasonController.text.trim(),
    );

    if (success) HapticFeedback.lightImpact();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? l10n.dictModRejectSuccess(termName)
                : l10n.dictModRejectError,
          ),
          backgroundColor: success ? AppConfig.warningColor : AppConfig.errorColor,
        ),
      );
    }

    return success;
  }

  Future<void> _showEditTermDialog(
    BuildContext context,
    DictionaryTerm term,
  ) async {
    final termController = TextEditingController(text: term.term);
    final definitionController = TextEditingController(text: term.definition);
    final exampleController = TextEditingController(text: term.example);
    String selectedCategory = term.category;
    final l10n = AppLocalizations.of(context)!;

    final updated = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) => AlertDialog(
            title: Text(l10n.dictModEditTitle),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: termController,
                    decoration: InputDecoration(
                      labelText: l10n.dictModEditFieldTerm,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: AppConfig.paddingMedium),
                  TextField(
                    controller: definitionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: l10n.dictModEditFieldDef,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: AppConfig.paddingMedium),
                  TextField(
                    controller: exampleController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: l10n.dictModEditFieldEx,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: AppConfig.paddingMedium),
                  DropdownButtonFormField<String>(
                    initialValue: selectedCategory,
                    decoration: InputDecoration(
                      labelText: l10n.dictModEditFieldCat,
                      border: const OutlineInputBorder(),
                    ),
                    items: AppConfig.dictionaryCategories
                        .map(
                          (category) => DropdownMenuItem<String>(
                            value: category,
                            child: Text(_getCategoryLabel(category, l10n)),
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
                child: Text(l10n.dictModCancelBtn),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (termController.text.trim().isEmpty ||
                      definitionController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.dictModEditErrorEmpty),
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
                            l10n.dictModEditErrorGeneric,
                      ),
                      backgroundColor: AppConfig.errorColor,
                    ),
                  );
                },
                child: Text(l10n.dictModEditSaveBtn),
              ),
            ],
          ),
        );
      },
    );

    if (updated == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.dictModEditSuccess),
          backgroundColor: AppConfig.accentColor,
        ),
      );
    }
  }

  String _getCategoryLabel(String category, AppLocalizations l10n) {
    switch (category) {
      case 'jerga_gamer':
        return l10n.dictCategoryJerga;
      case 'mecánicas_juego':
        return l10n.dictCategoryMechanics;
      case 'plataformas':
        return l10n.dictCategoryPlatforms;
      default:
        return category;
    }
  }
}