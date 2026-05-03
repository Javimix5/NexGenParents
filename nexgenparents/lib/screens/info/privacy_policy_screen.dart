import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.privacyPolicyTitle ?? 'Política de Privacidad'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n?.privacyPolicySubtitle ?? 'Política de Privacidad de NexGen Parents',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n?.privacyPolicyLastUpdate ?? 'Última actualización: Mayo 2026',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 24),
            Text(
              '${l10n?.privacyPolicyS1Title ?? "1. Recopilación de Información"}\n'
              '${l10n?.privacyPolicyS1Text ?? "En NexGen Parents nos tomamos muy en serio tu privacidad."}\n\n'
              '${l10n?.privacyPolicyS2Title ?? "2. Uso de los Datos"}\n'
              '${l10n?.privacyPolicyS2Text ?? "Los datos proporcionados se utilizan exclusivamente."}\n\n'
              '${l10n?.privacyPolicyS3Title ?? "3. Protección y Seguridad"}\n'
              '${l10n?.privacyPolicyS3Text ?? "Tus datos están protegidos."}\n\n'
              '${l10n?.privacyPolicyS4Title ?? "4. Tus Derechos"}\n'
              '${l10n?.privacyPolicyS4Text ?? "Puedes solicitar en cualquier momento la eliminación total."}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}