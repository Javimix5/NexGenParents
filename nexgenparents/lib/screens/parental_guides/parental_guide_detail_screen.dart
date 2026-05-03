import 'package:flutter/material.dart';
import '../../config/app_config.dart';
import '../../l10n/app_localizations.dart';
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

  String _resolveClosureOrString(BuildContext context, dynamic value) {
    if (value is Function) {
      try {
        return value(AppLocalizations.of(context)!).toString();
      } catch (_) {}
    }
    return value.toString();
  }

  String _sanitizeUrl(String url) {
    if (url.isEmpty || url.contains('tu-usuario') || url.contains('tu-repositorio')) {
      return ''; // Evita el 404 en URLs del tutorial
    }
    return url;
  }

  String _getTranslatedPlatform(BuildContext context) {
    final platformDisplay = _resolveClosureOrString(context, widget.guide.platformDisplayName);
    final platform = widget.guide.platform.toLowerCase();
    
    if (platform == 'ps' || platform == 'playstation') return 'PlayStation';
    if (platform == 'xbox') return 'Xbox';
    if (platform == 'nintendo') return 'Nintendo';
    if (platform == 'steam') return 'Steam';
    if (platform == 'ios') return 'iOS';
    if (platform == 'android') return 'Android';
    return platformDisplay;
  }

  String _getTranslatedInstruction(BuildContext context, int stepIndex) {
    final l10n = AppLocalizations.of(context)!;
    final step = widget.guide.steps[stepIndex];
    final instructionStr = _resolveClosureOrString(context, step.instruction);
    
    final platform = widget.guide.platform.toLowerCase();
    final title = _resolveClosureOrString(context, widget.guide.title).toLowerCase();
    final type = widget.guide.type.toLowerCase();
    final sNum = stepIndex + 1;

    if (platform == 'ps' || platform == 'playstation' || title.contains('playstation')) {
      if (type == 'disable' || title.contains('disable') || title.contains('deshabilitar')) {
        if (sNum == 1) return l10n.psDisableGuideStep1;
        if (sNum == 2) return l10n.psDisableGuideStep2;
        if (sNum == 3) return l10n.psDisableGuideStep3;
        if (sNum == 4) return l10n.psDisableGuideStep4;
        if (sNum == 5) return l10n.psDisableGuideStep5;
      } else {
        if (sNum == 1) return l10n.psEnableGuideStep1;
        if (sNum == 2) return l10n.psEnableGuideStep2;
        if (sNum == 3) return l10n.psEnableGuideStep3;
        if (sNum == 4) return l10n.psEnableGuideStep4;
        if (sNum == 5) return l10n.psEnableGuideStep5;
        if (sNum == 6) return l10n.psEnableGuideStep6;
      }
    }
    if (platform == 'nintendo' || title.contains('nintendo')) {
      if (type == 'app' || title.contains('app')) {
        if (sNum == 2) return l10n.nintendoAppGuideStep2;
        if (sNum == 3) return l10n.nintendoAppGuideStep3;
        if (sNum == 4) return l10n.nintendoAppGuideStep4;
        if (sNum == 5) return l10n.nintendoAppGuideStep5;
        if (sNum == 6) return l10n.nintendoAppGuideStep6;
        if (sNum == 7) return l10n.nintendoAppGuideStep7;
        if (sNum == 8) return l10n.nintendoAppGuideStep8;
      } else {
        if (sNum == 1) return l10n.nintendoGuideStep1;
        if (sNum == 2) return l10n.nintendoGuideStep2;
        if (sNum == 3) return l10n.nintendoGuideStep3;
        if (sNum == 4) return l10n.nintendoGuideStep4;
        if (sNum == 5) return l10n.nintendoGuideStep5;
      }
    }
    if (platform == 'steam' || title.contains('steam')) {
      if (sNum == 1) return l10n.steamGuideStep1;
      if (sNum == 2) return l10n.steamGuideStep2;
      if (sNum == 3) return l10n.steamGuideStep3;
      if (sNum == 4) return l10n.steamGuideStep4;
      if (sNum == 5) return l10n.steamGuideStep5;
    }
    if (platform == 'ios' || title.contains('ios')) {
      if (sNum == 1) return l10n.iosGuideStep1;
      if (sNum == 2) return l10n.iosGuideStep2;
      if (sNum == 3) return l10n.iosGuideStep3;
      if (sNum == 4) return l10n.iosGuideStep4;
    }
    if (platform == 'xbox' || title.contains('xbox')) {
      if (type == 'time' || title.contains('time') || title.contains('tiempo')) {
        if (sNum == 1) return l10n.xboxTimeGuideStep1;
        if (sNum == 2) return l10n.xboxTimeGuideStep2;
        if (sNum == 3) return l10n.xboxTimeGuideStep3;
        if (sNum == 4) return l10n.xboxTimeGuideStep4;
        if (sNum == 5) return l10n.xboxTimeGuideStep5;
      } else {
        if (sNum == 1) return l10n.xboxGuideStep1;
        if (sNum == 2) return l10n.xboxGuideStep2;
        if (sNum == 3) return l10n.xboxGuideStep3;
        if (sNum == 4) return l10n.xboxGuideStep4;
        if (sNum == 5) return l10n.xboxGuideStep5;
      }
    }

    return instructionStr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTranslatedPlatform(context)),
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
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppConfig.paddingMedium),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.1),
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
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
                l10n?.parentalGuidesStepProgress(_currentStep + 1, widget.guide.steps.length) ?? 'Paso ${_currentStep + 1} de ${widget.guide.steps.length}',
                style: TextStyle(
                  fontSize: AppConfig.fontSizeBody,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              Text(
                '${((_currentStep + 1) / widget.guide.steps.length * 100).toInt()}%',
                style: TextStyle(
                  fontSize: AppConfig.fontSizeBody,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          LinearProgressIndicator(
            value: (_currentStep + 1) / widget.guide.steps.length,
            backgroundColor: theme.colorScheme.onSurface.withValues(alpha: 0.2),
            valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
            minHeight: 8,
            borderRadius: BorderRadius.circular(AppConfig.borderRadiusSmall),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final step = widget.guide.steps[_currentStep];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 980),
        child: Padding(
          padding: const EdgeInsets.all(AppConfig.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${step.stepNumber}',
                    style: const TextStyle(
                      fontSize: AppConfig.fontSizeTitle,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppConfig.paddingLarge),
              Container(
                padding: const EdgeInsets.all(AppConfig.paddingMedium),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
                  border: Border.all(
                    color: theme.colorScheme.secondary.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: theme.colorScheme.secondary, size: 24),
                    const SizedBox(width: AppConfig.paddingSmall),
                    Expanded(
                      child: Text(
                        _getTranslatedInstruction(context, _currentStep),
                        style: const TextStyle(
                          fontSize: AppConfig.fontSizeBody,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppConfig.paddingLarge),
              Text(
                l10n?.parentalGuidesScreenshot ?? 'Captura de pantalla:',
                style: const TextStyle(
                  fontSize: AppConfig.fontSizeHeading,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppConfig.paddingMedium),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 860),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.dividerColor.withValues(alpha: 0.3),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
                      ),
                      child: Image.network(
                        _sanitizeUrl(step.imageUrl),
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;

                          return Container(
                            height: 300,
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircularProgressIndicator(),
                                  const SizedBox(height: AppConfig.paddingMedium),
                                  Text(
                                    l10n?.parentalGuidesLoadingImage ?? 'Cargando imagen...',
                                    style: TextStyle(color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7)),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 300,
                            color: theme.colorScheme.error.withValues(alpha: 0.1),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image_not_supported, size: 60, color: theme.colorScheme.error),
                                  const SizedBox(height: AppConfig.paddingMedium),
                                  Text(
                                    l10n?.parentalGuidesImageNotAvailable ?? 'Imagen no disponible',
                                    style: TextStyle(
                                      color: theme.colorScheme.error,
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
                const SizedBox(height: AppConfig.paddingLarge),
                Container(
                  padding: const EdgeInsets.all(AppConfig.paddingMedium),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
                    border: Border.all(color: theme.colorScheme.secondary, width: 2),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: theme.colorScheme.secondary, size: 30),
                      const SizedBox(width: AppConfig.paddingMedium),
                      Expanded(
                        child: Text(
                          l10n?.parentalGuidesSetupComplete ?? '¡Configuración completada! Ahora tu hijo puede jugar de forma segura con las restricciones configuradas.',
                          style: const TextStyle(
                            fontSize: AppConfig.fontSizeCaption,
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
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppConfig.paddingMedium),
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border(
          top: BorderSide(
            color: theme.dividerColor.withValues(alpha: 0.2),
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
                label: Text(l10n?.parentalGuidesPreviousBtn ?? 'Anterior'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppConfig.paddingMedium),
                ),
              ),
            ),
          if (_currentStep > 0 && _currentStep < widget.guide.steps.length - 1)
            const SizedBox(width: AppConfig.paddingMedium),
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
                    ? (l10n?.parentalGuidesNextBtn ?? 'Siguiente')
                    : (l10n?.parentalGuidesFinishBtn ?? 'Finalizar'),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: AppConfig.paddingMedium),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCompletionDialog() {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n?.parentalGuidesCompletedTitle ?? '¡Guía completada!'),
        content: Text(
          l10n?.parentalGuidesCompletedDesc ?? 'Has completado todos los pasos de esta guía de control parental.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(l10n?.dictBackBtn ?? 'Volver'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _currentStep = 0;
              });
            },
            child: Text(l10n?.parentalGuidesRepeatBtn ?? 'Repetir'),
          ),
        ],
      ),
    );
  }
}
