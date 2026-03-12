import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/dictionary_provider.dart';
import '../../config/app_config.dart';
import '../../config/app_theme.dart';
import 'term_detail_screen.dart';

class MyProposedTermsScreen extends StatefulWidget {
  const MyProposedTermsScreen({super.key});

  @override
  State<MyProposedTermsScreen> createState() => _MyProposedTermsScreenState();
}

class _MyProposedTermsScreenState extends State<MyProposedTermsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final dictionaryProvider = Provider.of<DictionaryProvider>(context, listen: false);
      
      if (authProvider.currentUser != null) {
        print('🔍 Cargando términos del usuario: ${authProvider.currentUser!.id}');
        dictionaryProvider.loadUserProposedTerms(authProvider.currentUser!.id);
      } else{
        print('❌ No hay usuario autenticado');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Términos Propuestos'),
      ),
      body: Consumer<DictionaryProvider>(
        builder: (context, dictionaryProvider, child) {
          if (dictionaryProvider.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: AppConfig.paddingMedium),
                  Text('Cargando tus términos...'),
                ],
              ),
            );
          }

          final terms = dictionaryProvider.userProposedTerms;
          print('📝 Términos cargados: ${terms.length}');
          if (terms.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppConfig.paddingLarge),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.article_outlined,
                      size: 80,
                      color: AppConfig.textSecondaryColor,
                    ),
                    const SizedBox(height: AppConfig.paddingMedium),
                    Text(
                      'No has propuesto términos aún',
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppConfig.paddingSmall),
                    Text(
                      'Contribuye al diccionario proponiendo nuevos términos',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          if (terms.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppConfig.paddingLarge),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.article_outlined,
                      size: 80,
                      color: AppConfig.textSecondaryColor,
                    ),
                    const SizedBox(height: AppConfig.paddingMedium),
                    Text(
                      'No has propuesto términos aún',
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppConfig.paddingSmall),
                    Text(
                      'Contribuye al diccionario proponiendo nuevos términos',
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
              // Header con estadísticas
              Container(
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
                  children: [
                    Text(
                      '${terms.length}',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Términos propuestos',
                      style: TextStyle(
                        fontSize: AppConfig.fontSizeBody,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: AppConfig.paddingMedium),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildStatChip(
                          'Aprobados',
                          user?.termsApproved ?? 0,
                          AppConfig.accentColor,
                        ),
                        const SizedBox(width: AppConfig.paddingSmall),
                        _buildStatChip(
                          'Pendientes',
                          terms.where((t) => t.status == 'pending').length,
                          AppConfig.warningColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Lista de términos
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(AppConfig.paddingMedium),
                  itemCount: terms.length,
                  itemBuilder: (context, index) {
                    final term = terms[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: AppConfig.paddingMedium),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => TermDetailScreen(termId: term.id),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
                        child: Padding(
                          padding: const EdgeInsets.all(AppConfig.paddingMedium),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      term.term,
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  _buildStatusChip(term.status),
                                ],
                              ),
                              const SizedBox(height: AppConfig.paddingSmall),
                              Text(
                                term.definition,
                                style: Theme.of(context).textTheme.bodyMedium,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: AppConfig.paddingSmall),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.category,
                                    size: 14,
                                    color: AppConfig.textSecondaryColor,
                                  ),
                                  const SizedBox(width: AppConfig.paddingSmall / 2),
                                  Text(
                                    term.categoryDisplayName,
                                    style: const TextStyle(
                                      fontSize: AppConfig.fontSizeCaption,
                                      color: AppConfig.textSecondaryColor,
                                    ),
                                  ),
                                  const Spacer(),
                                  if (term.rejectionReason != null) ...[
                                    const Icon(
                                      Icons.info_outline,
                                      size: 14,
                                      color: AppConfig.errorColor,
                                    ),
                                    const SizedBox(width: AppConfig.paddingSmall / 2),
                                    const Text(
                                      'Ver motivo',
                                      style: TextStyle(
                                        fontSize: AppConfig.fontSizeCaption,
                                        color: AppConfig.errorColor,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              if (term.rejectionReason != null) ...[
                                const SizedBox(height: AppConfig.paddingSmall),
                                Container(
                                  padding: const EdgeInsets.all(AppConfig.paddingSmall),
                                  decoration: BoxDecoration(
                                    color: AppConfig.errorColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(AppConfig.borderRadiusSmall),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.block,
                                        size: 16,
                                        color: AppConfig.errorColor,
                                      ),
                                      const SizedBox(width: AppConfig.paddingSmall / 2),
                                      Expanded(
                                        child: Text(
                                          term.rejectionReason!,
                                          style: const TextStyle(
                                            fontSize: AppConfig.fontSizeCaption,
                                            color: AppConfig.errorColor,
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
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatChip(String label, int count, Color color) {
    return Container(
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
          Text(
            '$count',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: AppConfig.fontSizeBody,
            ),
          ),
          const SizedBox(width: AppConfig.paddingSmall / 2),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: AppConfig.fontSizeCaption,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    String text;
    IconData icon;

    switch (status) {
      case 'approved':
        color = AppConfig.accentColor;
        text = 'Aprobado';
        icon = Icons.check_circle;
        break;
      case 'pending':
        color = AppConfig.warningColor;
        text = 'Pendiente';
        icon = Icons.schedule;
        break;
      case 'rejected':
        color = AppConfig.errorColor;
        text = 'Rechazado';
        icon = Icons.cancel;
        break;
      default:
        color = AppConfig.textSecondaryColor;
        text = status;
        icon = Icons.help;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConfig.paddingSmall,
        vertical: AppConfig.paddingSmall / 2,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusSmall),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: AppConfig.paddingSmall / 2),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: AppConfig.fontSizeCaption,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}