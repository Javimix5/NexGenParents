import 'package:flutter/material.dart';
import '../../config/app_config.dart';
import '../../l10n/app_localizations.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.contactUsTitle ?? 'Contáctanos'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n?.contactUsSubtitle ?? '¡Nos encantaría escucharte!',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n?.contactUsDescription ?? '¿Tienes alguna duda sobre nuestras guías, quieres proponer una mejora o necesitas ayuda técnica con la aplicación? Ponte en contacto con nosotros.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.email, color: AppConfig.primaryColor),
                    title: Text(l10n?.contactUsEmailLabel ?? 'Correo electrónico'),
                    subtitle: const Text('soporte@nexgenparents.com'),
                    onTap: () {
                      // Aquí podrías usar url_launcher para abrir el email (ej: mailto:)
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.language, color: AppConfig.primaryColor),
                    title: Text(l10n?.contactUsWebLabel ?? 'Sitio Web'),
                    subtitle: const Text('www.nexgenparents.com'),
                    onTap: () {
                      // Aquí podrías usar url_launcher para abrir la web
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(l10n?.contactUsForumHint ?? 'También puedes participar activamente dejando tus dudas en nuestro Foro Comunitario de la app.', textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}