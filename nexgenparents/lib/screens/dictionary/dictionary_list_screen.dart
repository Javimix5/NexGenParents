import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/dictionary_provider.dart';
import '../../providers/auth_provider.dart';
import '../../config/app_config.dart';
import '../../widgets/common/app_empty_state.dart';
import 'propose_term_screen.dart';
import 'term_detail_screen.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/common/app_footer.dart';
import '../auth/login_screen.dart';

class DictionaryListScreen extends StatefulWidget {
  const DictionaryListScreen({super.key});

  @override
  State<DictionaryListScreen> createState() => _DictionaryListScreenState();
}

class _DictionaryListScreenState extends State<DictionaryListScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    // Cargar términos aprobados
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DictionaryProvider>(context, listen: false)
          .loadApprovedTerms();
    });
    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;
      if (_scrollController.offset >= 300 && !_showBackToTopButton) {
        setState(() => _showBackToTopButton = true);
      } else if (_scrollController.offset < 300 && _showBackToTopButton) {
        setState(() => _showBackToTopButton = false);
      }
    });
  }

  // Validación de acceso
  bool _requireLogin(BuildContext context, {String? customMessage}) {
    final user = Provider.of<AuthProvider>(context, listen: false).currentUser;
    if (user == null) {
      final l10n = AppLocalizations.of(context);
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l10n?.dictModAccessDeniedTitle ?? 'Acceso restringido'),
          content: Text(customMessage ??
              l10n?.dictRequireLoginDefault ??
              'Debes iniciar sesión para acceder a esta función.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n?.adminCancelBtn ?? 'Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
              child: Text(l10n?.loginBtn ?? 'Iniciar sesión'),
            ),
          ],
        ),
      );
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Scaffold(
      body: Consumer<DictionaryProvider>(
        builder: (context, dictionaryProvider, child) {
          if (dictionaryProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          var terms = dictionaryProvider.approvedTerms;
          final totalTerms = terms.length;

          // Si el usuario no está logueado, mostramos 10 palabras de forma aleatoria
          if (user == null && terms.isNotEmpty) {
            // Creamos un seed basado en la fecha actual para que cambie cada día
            final now = DateTime.now();
            final dailySeed = now.year * 10000 + now.month * 100 + now.day;
            final random = Random(dailySeed);
            final shuffled = terms.toList()..shuffle(random);
            terms = shuffled.take(10).toList();
          }

          if (terms.isEmpty) {
            return AppEmptyState(
              icon: Icons.book_outlined,
              title: l10n.dictListEmptyTitle,
              message: l10n.dictListEmptyMessage,
            );
          }

          return ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(AppConfig.paddingMedium),
            itemCount: terms.length + 1,
            itemBuilder: (context, index) {
              if (index == terms.length) {
                if (user == null) {
                  return Column(
                    children: [
                      const SizedBox(height: 24),
                      Card(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const Icon(Icons.lock_outline, size: 48),
                              const SizedBox(height: 12),
                              Text(
                                l10n.dictGuestLockMessage(totalTerms),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer, // Ajuste de color para modo claro
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const LoginScreen())),
                                child: Text(l10n.loginBtn),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: AppConfig.paddingLarge),
                        child: AppFooter(),
                      ),
                      const SizedBox(height: 80), // Espacio adicional para evitar superposición
                    ],
                  );
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: AppConfig.paddingLarge),
                      child: const AppFooter(),
                    ),
                    const SizedBox(height: 80), // Espacio adicional para evitar superposición
                  ],
                );
              }
              final term = terms[index];
              return Card(
                child: ListTile(
                  title: Text(
                    term.term,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  subtitle: Text(
                    term.definition,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Chip(
                    label: Text(term.categoryDisplayName),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => TermDetailScreen(termId: term.id),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (_showBackToTopButton) ...[
            SizedBox(
                height: AppConfig
                    .paddingLarge), // Añadido para evitar superposición con los iconos de redes sociales
            FloatingActionButton.small(
              heroTag: 'dictionary_list_back_to_top_btn',
              onPressed: () {
                if (_scrollController.hasClients) {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
              backgroundColor: AppConfig.primaryColor,
              foregroundColor: Colors.white,
              child: const Icon(Icons.arrow_upward),
            ),
            const SizedBox(height: AppConfig.paddingMedium),
          ],
          FloatingActionButton.extended(
            heroTag: 'dictionary_propose_btn',
            onPressed: () {
              if (_requireLogin(context,
                  customMessage: l10n.dictRequireLoginPropose)) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ProposeTermScreen(),
                  ),
                );
              }
            },
            icon: const Icon(Icons.add),
            label: Text(l10n.dictListProposeBtn),
          ),
        ],
      ),
    );
  }
}
