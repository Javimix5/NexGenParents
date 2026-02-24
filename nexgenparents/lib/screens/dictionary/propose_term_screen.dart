import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/dictionary_provider.dart';
import '../../config/app_config.dart';

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

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final dictionaryProvider = Provider.of<DictionaryProvider>(context, listen: false);

    final userId = authProvider.currentUser?.id;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: Usuario no autenticado'),
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
              Icon(Icons.check_circle, color: AppConfig.accentColor, size: 30),
              SizedBox(width: AppConfig.paddingSmall),
              Text('¡Término enviado!'),
            ],
          ),
          content: Text(
            'Tu término ha sido propuesto correctamente y será revisado por un moderador. '
            'Te notificaremos cuando sea aprobado.',
            style: TextStyle(fontSize: AppConfig.fontSizeBody),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar diálogo
                Navigator.of(context).pop(); // Volver a pantalla anterior
              },
              child: Text('Entendido'),
            ),
          ],
        ),
      );
    } else if (mounted) {
      // Mostrar error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            dictionaryProvider.errorMessage ?? 'Error al proponer término',
          ),
          backgroundColor: AppConfig.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proponer Término'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppConfig.paddingMedium),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Información introductoria
              Container(
                padding: EdgeInsets.all(AppConfig.paddingMedium),
                decoration: BoxDecoration(
                  color: AppConfig.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
                  border: Border.all(color: AppConfig.primaryColor),
                ),
                child: Row(
                  children: [
                    Icon(Icons.lightbulb_outline, color: AppConfig.primaryColor),
                    SizedBox(width: AppConfig.paddingSmall),
                    Expanded(
                      child: Text(
                        'Ayuda a otros padres añadiendo términos que conozcas',
                        style: TextStyle(
                          fontSize: AppConfig.fontSizeBody,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppConfig.paddingLarge),

              // Campo: Término
              Text(
                'Término o palabra',
                style: TextStyle(
                  fontSize: AppConfig.fontSizeBody,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppConfig.paddingSmall),
              TextFormField(
                controller: _termController,
                textCapitalization: TextCapitalization.none,
                decoration: InputDecoration(
                  hintText: 'Ej: GG, Nerf, Farming',
                  prefixIcon: Icon(Icons.text_fields),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce el término';
                  }
                  if (value.length < 2) {
                    return 'El término debe tener al menos 2 caracteres';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppConfig.paddingMedium),

              // Campo: Categoría
              Text(
                'Categoría',
                style: TextStyle(
                  fontSize: AppConfig.fontSizeBody,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppConfig.paddingSmall),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.category),
                ),
                items: AppConfig.dictionaryCategories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(_getCategoryDisplayName(category)),
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
              SizedBox(height: AppConfig.paddingMedium),

              // Campo: Definición
              Text(
                'Definición',
                style: TextStyle(
                  fontSize: AppConfig.fontSizeBody,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppConfig.paddingSmall),
              TextFormField(
                controller: _definitionController,
                maxLines: 4,
                maxLength: 200,
                decoration: InputDecoration(
                  hintText: 'Explica qué significa este término de forma clara y sencilla',
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: Icon(Icons.description),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce la definición';
                  }
                  if (value.length < 10) {
                    return 'La definición debe tener al menos 10 caracteres';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppConfig.paddingMedium),

              // Campo: Ejemplo de uso
              Text(
                'Ejemplo de uso',
                style: TextStyle(
                  fontSize: AppConfig.fontSizeBody,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppConfig.paddingSmall),
              TextFormField(
                controller: _exampleController,
                maxLines: 3,
                maxLength: 150,
                decoration: InputDecoration(
                  hintText: 'Ej: "Los niños dicen GG al final de cada partida"',
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Icon(Icons.format_quote),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce un ejemplo de uso';
                  }
                  if (value.length < 10) {
                    return 'El ejemplo debe tener al menos 10 caracteres';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppConfig.paddingLarge),

              // Información sobre el proceso de validación
              Container(
                padding: EdgeInsets.all(AppConfig.paddingMedium),
                decoration: BoxDecoration(
                  color: AppConfig.warningColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: AppConfig.warningColor, size: 20),
                    SizedBox(width: AppConfig.paddingSmall),
                    Expanded(
                      child: Text(
                        'Tu término será revisado por un moderador antes de aparecer en el diccionario. '
                        'Esto ayuda a mantener la calidad del contenido.',
                        style: TextStyle(
                          fontSize: AppConfig.fontSizeCaption,
                          color: AppConfig.textPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppConfig.paddingLarge),

              // Botón de enviar
              Consumer<DictionaryProvider>(
                builder: (context, dictionaryProvider, child) {
                  return ElevatedButton.icon(
                    onPressed: dictionaryProvider.isLoading ? null : _handleSubmit,
                    icon: dictionaryProvider.isLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Icon(Icons.send),
                    label: Text(
                      dictionaryProvider.isLoading ? 'Enviando...' : 'Proponer término',
                      style: TextStyle(fontSize: AppConfig.fontSizeBody),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: AppConfig.paddingMedium),
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

  String _getCategoryDisplayName(String category) {
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