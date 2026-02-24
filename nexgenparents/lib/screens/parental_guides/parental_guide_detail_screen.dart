import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/parental_guide_model.dart';
import '../../config/app_config.dart';

class ParentalGuideDetailScreen extends StatefulWidget {
  final ParentalGuide guide;

  const ParentalGuideDetailScreen({
    super.key,
    required this.guide,
  });

  @override
  State<ParentalGuideDetailScreen> createState() =>
      _ParentalGuideDetailScreenState();
}

class _ParentalGuideDetailScreenState extends State<ParentalGuideDetailScreen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.guide.platformDisplayName),
      ),
      body: Column(
        children: [
          // Indicador de progreso
          _buildProgressIndicator(),

          // Contenido del paso actual
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildStepContent(),
                  SizedBox(height: AppConfig.paddingLarge * 2),
                ],
              ),
            ),
          ),

          // Botones de navegación
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: EdgeInsets.all(AppConfig.paddingMedium),
      decoration: BoxDecoration(
        color: AppConfig.primaryColor.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            color: AppConfig.primaryColor.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Paso ${_currentStep + 1} de ${widget.guide.steps.length}',
                style: TextStyle(
                  fontSize: AppConfig.fontSizeBody,
                  fontWeight: FontWeight.bold,
                  color: AppConfig.primaryColor,
                ),
              ),
              Text(
                '${((_currentStep + 1) / widget.guide.steps.length * 100).toInt()}%',
                style: TextStyle(
                  fontSize: AppConfig.fontSizeBody,
                  fontWeight: FontWeight.bold,
                  color: AppConfig.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: AppConfig.paddingSmall),
          LinearProgressIndicator(
            value: (_currentStep + 1) / widget.guide.steps.length,
            backgroundColor: AppConfig.textSecondaryColor.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(AppConfig.primaryColor),
            minHeight: 8,
            borderRadius: BorderRadius.circular(AppConfig.borderRadiusSmall),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    final step = widget.guide.steps[_currentStep];

    return Padding(
      padding: EdgeInsets.all(AppConfig.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Número del paso
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppConfig.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${step.stepNumber}',
                style: TextStyle(
                  fontSize: AppConfig.fontSizeTitle,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: AppConfig.paddingLarge),

          // Instrucción del paso
          Container(
            padding: EdgeInsets.all(AppConfig.paddingMedium),
            decoration: BoxDecoration(
              color: AppConfig.accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
              border: Border.all(
                color: AppConfig.accentColor.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppConfig.accentColor,
                  size: 24,
                ),
                SizedBox(width: AppConfig.paddingSmall),
                Expanded(
                  child: Text(
                    step.instruction,
                    style: TextStyle(
                      fontSize: AppConfig.fontSizeBody,
                      height: 1.6,
                      color: AppConfig.textPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppConfig.paddingLarge),

          // Imagen ilustrativa del paso
          Text(
            'Captura de pantalla:',
            style: TextStyle(
              fontSize: AppConfig.fontSizeHeading,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppConfig.paddingMedium),

          ClipRRect(
            borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppConfig.textSecondaryColor.withOpacity(0.3),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
              ),
              child: CachedNetworkImage(
                imageUrl: step.imageUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) => Container(
                  height: 300,
                  color: AppConfig.textSecondaryColor.withOpacity(0.1),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: AppConfig.paddingMedium),
                        Text(
                          'Cargando imagen...',
                          style: TextStyle(
                            color: AppConfig.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 300,
                  color: AppConfig.errorColor.withOpacity(0.1),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_not_supported,
                          size: 60,
                          color: AppConfig.errorColor,
                        ),
                        SizedBox(height: AppConfig.paddingMedium),
                        Text(
                          'Imagen no disponible',
                          style: TextStyle(
                            color: AppConfig.errorColor,
                            fontSize: AppConfig.fontSizeBody,
                          ),
                        ),
                        SizedBox(height: AppConfig.paddingSmall),
                        Text(
                          'Por favor, verifica tu conexión',
                          style: TextStyle(
                            color: AppConfig.textSecondaryColor,
                            fontSize: AppConfig.fontSizeCaption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Consejo adicional (si es el último paso)
          if (_currentStep == widget.guide.steps.length - 1) ...[
            SizedBox(height: AppConfig.paddingLarge),
            Container(
              padding: EdgeInsets.all(AppConfig.paddingMedium),
              decoration: BoxDecoration(
                color: AppConfig.accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
                border: Border.all(
                  color: AppConfig.accentColor,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: AppConfig.accentColor,
                    size: 30,
                  ),
                  SizedBox(width: AppConfig.paddingMedium),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '¡Configuración completada!',
                          style: TextStyle(
                            fontSize: AppConfig.fontSizeBody,
                            fontWeight: FontWeight.bold,
                            color: AppConfig.accentColor,
                          ),
                        ),
                        SizedBox(height: AppConfig.paddingSmall / 2),
                        Text(
                          'Ahora tu hijo puede jugar de forma segura con las restricciones configuradas.',
                          style: TextStyle(
                            fontSize: AppConfig.fontSizeCaption,
                            color: AppConfig.textPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: EdgeInsets.all(AppConfig.paddingMedium),
      decoration: BoxDecoration(
        color: AppConfig.backgroundColor,
        border: Border(
          top: BorderSide(
            color: AppConfig.textSecondaryColor.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Botón Anterior
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _currentStep--;
                  });
                },
                icon: Icon(Icons.arrow_back),
                label: Text('Anterior'),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: AppConfig.paddingMedium,
                  ),
                ),
              ),
            ),

          if (_currentStep > 0 && _currentStep < widget.guide.steps.length - 1)
            SizedBox(width: AppConfig.paddingMedium),

          // Botón Siguiente/Finalizar
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                if (_currentStep < widget.guide.steps.length - 1) {
                  setState(() {
                    _currentStep++;
                  });
                } else {
                  // Último paso - mostrar diálogo de finalización
                  _showCompletionDialog();
                }
              },
              icon: Icon(
                _currentStep < widget.guide.steps.length - 1
                    ? Icons.arrow_forward
                    : Icons.check_circle,
              ),
              label: Text(
                _currentStep < widget.guide.steps.length - 1
                    ? 'Siguiente'
                    : 'Finalizar',
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: AppConfig.paddingMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.celebration, color: AppConfig.accentColor, size: 30),
            SizedBox(width: AppConfig.paddingSmall),
            Text('¡Enhorabuena!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Has completado la configuración del control parental en ${widget.guide.platformDisplayName}.',
              style: TextStyle(fontSize: AppConfig.fontSizeBody),
            ),
            SizedBox(height: AppConfig.paddingMedium),
            Text(
              'Recuerda revisar periódicamente estas configuraciones y ajustarlas según la edad de tus hijos.',
              style: TextStyle(
                fontSize: AppConfig.fontSizeCaption,
                color: AppConfig.textSecondaryColor,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar diálogo
              Navigator.of(context).pop(); // Volver a lista de guías
            },
            child: Text('Ver otras guías'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar diálogo
              Navigator.of(context).popUntil((route) => route.isFirst); // Volver al Home
            },
            child: Text('Ir al inicio'),
          ),
        ],
      ),
    );
  }
}