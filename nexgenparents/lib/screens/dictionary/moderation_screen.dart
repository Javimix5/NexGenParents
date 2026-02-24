import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/dictionary_provider.dart';
import '../../config/app_config.dart';
import '../../config/app_theme.dart';

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
        appBar: AppBar(title: Text('Acceso Denegado')),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(AppConfig.paddingLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.block,
                  size: 80,
                  color: AppConfig.errorColor,
                ),
                SizedBox(height: AppConfig.paddingMedium),
                Text(
                  'No tienes permisos para acceder a esta sección',
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppConfig.paddingSmall),
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
        title: Text('Panel de Moderación'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
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
            return Center(
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
                padding: EdgeInsets.all(AppConfig.paddingLarge),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 80,
                      color: AppConfig.accentColor,
                    ),
                    SizedBox(height: AppConfig.paddingMedium),
                    Text(
                      '¡Todo revisado!',
                      style: Theme.of(context).textTheme.displayLarge,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppConfig.paddingSmall),
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
                padding: EdgeInsets.all(AppConfig.paddingMedium),
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
                    Icon(Icons.pending_actions, color: AppConfig.warningColor),
                    SizedBox(width: AppConfig.paddingSmall),
                    Text(
                      '${pendingTerms.length} términos pendientes de revisión',
                      style: TextStyle(
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
                  padding: EdgeInsets.all(AppConfig.paddingMedium),
                  itemCount: pendingTerms.length,
                  itemBuilder: (context, index) {
                    final term = pendingTerms[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: AppConfig.paddingMedium),
                      child: ExpansionTile(
                        leading: CircleAvatar(
                          backgroundColor: AppConfig.primaryColor,
                          child: Icon(Icons.article, color: Colors.white),
                        ),
                        title: Text(
                          term.term,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppConfig.fontSizeBody,
                          ),
                        ),
                        subtitle: Text(
                          term.categoryDisplayName,
                          style: TextStyle(
                            fontSize: AppConfig.fontSizeCaption,
                            color: AppConfig.textSecondaryColor,
                          ),
                        ),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(AppConfig.paddingMedium),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Definición
                                Text(
                                  'Definición:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppConfig.fontSizeBody,
                                  ),
                                ),
                                SizedBox(height: AppConfig.paddingSmall / 2),
                                Container(
                                  padding: EdgeInsets.all(AppConfig.paddingSmall),
                                  decoration: BoxDecoration(
                                    color: AppConfig.backgroundColor,
                                    borderRadius: BorderRadius.circular(
                                      AppConfig.borderRadiusSmall,
                                    ),
                                  ),
                                  child: Text(
                                    term.definition,
                                    style: TextStyle(fontSize: AppConfig.fontSizeBody),
                                  ),
                                ),
                                SizedBox(height: AppConfig.paddingMedium),

                                // Ejemplo de uso
                                if (term.example.isNotEmpty) ...[
                                  Text(
                                    'Ejemplo de uso:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppConfig.fontSizeBody,
                                    ),
                                  ),
                                  SizedBox(height: AppConfig.paddingSmall / 2),
                                  Container(
                                    padding: EdgeInsets.all(AppConfig.paddingSmall),
                                    decoration: BoxDecoration(
                                      color: AppConfig.accentColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(
                                        AppConfig.borderRadiusSmall,
                                      ),
                                    ),
                                    child: Text(
                                      '"${term.example}"',
                                      style: TextStyle(
                                        fontSize: AppConfig.fontSizeBody,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: AppConfig.paddingMedium),
                                ],

                                // Información adicional
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 14,
                                      color: AppConfig.textSecondaryColor,
                                    ),
                                    SizedBox(width: AppConfig.paddingSmall / 2),
                                    Text(
                                      'Propuesto el ${_formatDate(term.createdAt)}',
                                      style: TextStyle(
                                        fontSize: AppConfig.fontSizeCaption,
                                        color: AppConfig.textSecondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: AppConfig.paddingMedium),

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
                                        icon: Icon(Icons.cancel),
                                        label: Text('Rechazar'),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: AppConfig.errorColor,
                                          side: BorderSide(
                                            color: AppConfig.errorColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: AppConfig.paddingMedium),
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: () => _approveTerm(
                                          context,
                                          term.id,
                                          term.term,
                                        ),
                                        icon: Icon(Icons.check_circle),
                                        label: Text('Aprobar'),
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
        title: Row(
          children: [
            Icon(Icons.check_circle, color: AppConfig.accentColor),
            SizedBox(width: AppConfig.paddingSmall),
            Text('Aprobar término'),
          ],
        ),
        content: Text(
          '¿Estás seguro de que deseas aprobar el término "$termName"?\n\n'
          'Será visible para todos los usuarios.',
          style: TextStyle(fontSize: AppConfig.fontSizeBody),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConfig.accentColor,
            ),
            child: Text('Aprobar'),
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
        title: Row(
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
              style: TextStyle(fontSize: AppConfig.fontSizeBody),
            ),
            SizedBox(height: AppConfig.paddingMedium),
            TextField(
              controller: reasonController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Escribe el motivo del rechazo...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: AppConfig.paddingSmall),
            Text(
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
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (reasonController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
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
            child: Text('Rechazar'),
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
}