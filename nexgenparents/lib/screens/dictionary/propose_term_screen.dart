import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/dictionary_provider.dart';
import '../../config/app_config.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/translation_helper.dart';

class ProposeTermScreen extends StatefulWidget {
  const ProposeTermScreen({super.key});

  @override
  State<ProposeTermScreen> createState() => _ProposeTermScreenState();
}

class _ProposeTermScreenState extends State<ProposeTermScreen> {
  final _formKey = GlobalKey<FormState>();
  final _termController = TextEditingController();
  final _definitionController = TextEditingController();
  final _exampleController = TextEditingController();
  
  String _selectedCategory = AppConfig.dictionaryCategories[0];

  @override
  void dispose() {
    _termController.dispose();
    _definitionController.dispose();
    _exampleController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final l10n = AppLocalizations.of(context)!;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final dictionaryProvider = Provider.of<DictionaryProvider>(context, listen: false);

    final userId = authProvider.currentUser?.id;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.dictProposeErrorAuth),
          backgroundColor: AppConfig.errorColor,
        ),
      );
      return;
    }

    final success = await dictionaryProvider.proposeNewTerm(
      term: _termController.text.trim(),
      definition: _definitionController.text.trim(),
      example: _exampleController.text.trim(),
      category: _selectedCategory,
      userId: userId,
    );

    if (success && mounted) {
      // Mostrar mensaje de éxito
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.check_circle, color: AppConfig.accentColor, size: 30),
              const SizedBox(width: AppConfig.paddingSmall),
              Text(l10n.dictProposeSuccessTitle),
            ],
          ),
          content: Text(
            l10n.dictProposeSuccessMessage,
            style: const TextStyle(fontSize: AppConfig.fontSizeBody),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar diálogo
                Navigator.of(context).pop(); // Volver a pantalla anterior
              },
              child: Text(l10n.dictProposeUnderstoodBtn),
            ),
          ],
        ),
      );
    } else if (mounted) {
      // Mostrar error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            TranslationHelper.translateDynamicKey(context, dictionaryProvider.errorMessage, fallback: l10n.dictProposeErrorGeneric),
          ),
          backgroundColor: AppConfig.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dictProposeTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConfig.paddingMedium),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Información introductoria
              Container(
                padding: const EdgeInsets.all(AppConfig.paddingMedium),
                decoration: BoxDecoration(
                  color: AppConfig.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
                  border: Border.all(color: AppConfig.primaryColor),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lightbulb_outline, color: AppConfig.primaryColor),
                    const SizedBox(width: AppConfig.paddingSmall),
                    Expanded(
                      child: Text(
                        l10n.dictProposeHelpText,
                        style: const TextStyle(
                          fontSize: AppConfig.fontSizeBody,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppConfig.paddingLarge),

              // Campo: Término
              Text(
                l10n.dictProposeFieldTerm,
                style: const TextStyle(
                  fontSize: AppConfig.fontSizeBody,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppConfig.paddingSmall),
              TextFormField(
                controller: _termController,
                textCapitalization: TextCapitalization.none,
                decoration: InputDecoration(
                  hintText: l10n.dictProposeFieldTermHint,
                  prefixIcon: const Icon(Icons.text_fields),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.dictProposeErrorTermEmpty;
                  }
                  if (value.length < 2) {
                    return l10n.dictProposeErrorTermLength;
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppConfig.paddingMedium),

              // Campo: Categoría
              Text(
                l10n.dictProposeFieldCategory,
                style: const TextStyle(
                  fontSize: AppConfig.fontSizeBody,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppConfig.paddingSmall),
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.category),
                ),
                items: AppConfig.dictionaryCategories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(_getCategoryDisplayName(category, l10n)),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                },
              ),
              const SizedBox(height: AppConfig.paddingMedium),

              // Campo: Definición
              Text(
                l10n.dictProposeFieldDefinition,
                style: const TextStyle(
                  fontSize: AppConfig.fontSizeBody,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppConfig.paddingSmall),
              TextFormField(
                controller: _definitionController,
                maxLines: 4,
                maxLength: 200,
                decoration: InputDecoration(
                  hintText: l10n.dictProposeFieldDefinitionHint,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: Icon(Icons.description),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.dictProposeErrorDefinitionEmpty;
                  }
                  if (value.length < 10) {
                    return l10n.dictProposeErrorDefinitionLength;
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppConfig.paddingMedium),

              // Campo: Ejemplo de uso
              Text(
                l10n.dictProposeFieldExample,
                style: const TextStyle(
                  fontSize: AppConfig.fontSizeBody,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppConfig.paddingSmall),
              TextFormField(
                controller: _exampleController,
                maxLines: 3,
                maxLength: 150,
                decoration: InputDecoration(
                  hintText: l10n.dictProposeFieldExampleHint,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Icon(Icons.format_quote),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.dictProposeErrorExampleEmpty;
                  }
                  if (value.length < 10) {
                    return l10n.dictProposeErrorExampleLength;
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppConfig.paddingLarge),

              // Información sobre el proceso de validación
              Container(
                padding: const EdgeInsets.all(AppConfig.paddingMedium),
                decoration: BoxDecoration(
                  color: AppConfig.warningColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.info_outline, color: AppConfig.warningColor, size: 20),
                    const SizedBox(width: AppConfig.paddingSmall),
                    Expanded(
                      child: Text(
                        l10n.dictProposeWarningText,
                        style: const TextStyle(
                          fontSize: AppConfig.fontSizeCaption,
                          color: AppConfig.textPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppConfig.paddingLarge),

              // Botón de enviar
              Consumer<DictionaryProvider>(
                builder: (context, dictionaryProvider, child) {
                  return ElevatedButton.icon(
                    onPressed: dictionaryProvider.isLoading ? null : _handleSubmit,
                    icon: dictionaryProvider.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Icon(Icons.send),
                    label: Text(
                      dictionaryProvider.isLoading ? l10n.dictProposeSendingBtn : l10n.dictProposeSubmitBtn,
                      style: const TextStyle(fontSize: AppConfig.fontSizeBody),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: AppConfig.paddingMedium),
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

  String _getCategoryDisplayName(String category, AppLocalizations l10n) {
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