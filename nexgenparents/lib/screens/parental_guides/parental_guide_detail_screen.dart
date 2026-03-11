import 'package:flutter/material.dart';
import '../../config/app_config.dart';
import '../../models/parental_guide_model.dart';

class ParentalGuideDetailScreen extends StatefulWidget {
  final ParentalGuide guide;

  const ParentalGuideDetailScreen({
    super.key,
    required this.guide,
  });

  @override
  State<ParentalGuideDetailScreen> createState() => _ParentalGuideDetailScreenState();
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
          _buildProgressIndicator(),
          Expanded(
            child: SingleChildScrollView(
              child: _buildStepContent(),
            ),
          ),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: EdgeInsets.all(AppConfig.paddingMedium),
      decoration: BoxDecoration(
        color: AppConfig.primaryColor.withValues(alpha: 0.1),
        border: Border(
          bottom: BorderSide(
            color: AppConfig.primaryColor.withValues(alpha: 0.3),
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
            backgroundColor: AppConfig.textSecondaryColor.withValues(alpha: 0.2),
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

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 980),
        child: Padding(
          padding: EdgeInsets.all(AppConfig.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Container(
                padding: EdgeInsets.all(AppConfig.paddingMedium),
                decoration: BoxDecoration(
                  color: AppConfig.accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
                  border: Border.all(
                    color: AppConfig.accentColor.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: AppConfig.accentColor, size: 24),
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
              Text(
                'Captura de pantalla:',
                style: TextStyle(
                  fontSize: AppConfig.fontSizeHeading,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppConfig.paddingMedium),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 860),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppConfig.textSecondaryColor.withValues(alpha: 0.3),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
                      ),
                      child: Image.network(
                        step.imageUrl,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;

                          return Container(
                            height: 300,
                            color: AppConfig.textSecondaryColor.withValues(alpha: 0.1),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircularProgressIndicator(),
                                  SizedBox(height: AppConfig.paddingMedium),
                                  Text(
                                    'Cargando imagen...',
                                    style: TextStyle(color: AppConfig.textSecondaryColor),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 300,
                            color: AppConfig.errorColor.withValues(alpha: 0.1),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image_not_supported, size: 60, color: AppConfig.errorColor),
                                  SizedBox(height: AppConfig.paddingMedium),
                                  Text(
                                    'Imagen no disponible',
                                    style: TextStyle(
                                      color: AppConfig.errorColor,
                                      fontSize: AppConfig.fontSizeBody,
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
                ),
              ),
              if (_currentStep == widget.guide.steps.length - 1) ...[
                SizedBox(height: AppConfig.paddingLarge),
                Container(
                  padding: EdgeInsets.all(AppConfig.paddingMedium),
                  decoration: BoxDecoration(
                    color: AppConfig.accentColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
                    border: Border.all(color: AppConfig.accentColor, width: 2),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: AppConfig.accentColor, size: 30),
                      SizedBox(width: AppConfig.paddingMedium),
                      Expanded(
                        child: Text(
                          '¡Configuración completada! Ahora tu hijo puede jugar de forma segura con las restricciones configuradas.',
                          style: TextStyle(
                            fontSize: AppConfig.fontSizeCaption,
                            color: AppConfig.textPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
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
            color: AppConfig.textSecondaryColor.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _currentStep--;
                  });
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Anterior'),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: AppConfig.paddingMedium),
                ),
              ),
            ),
          if (_currentStep > 0 && _currentStep < widget.guide.steps.length - 1)
            SizedBox(width: AppConfig.paddingMedium),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                if (_currentStep < widget.guide.steps.length - 1) {
                  setState(() {
                    _currentStep++;
                  });
                } else {
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
                padding: EdgeInsets.symmetric(vertical: AppConfig.paddingMedium),
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
      builder: (context) => AlertDialog(
        title: const Text('¡Guía completada!'),
        content: const Text(
          'Has completado todos los pasos de esta guía de control parental.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Volver'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _currentStep = 0;
              });
            },
            child: const Text('Repetir'),
          ),
        ],
      ),
    );
  }
}
