import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/dictionary_provider.dart';
import '../../config/app_config.dart';
import '../../widgets/common/app_empty_state.dart';
import '../../widgets/common/app_loading_state.dart';
import 'term_detail_screen.dart';
import '../../l10n/app_localizations.dart';

class MyProposedTermsScreen extends StatefulWidget {
  const MyProposedTermsScreen({super.key});

  @override
  State<MyProposedTermsScreen> createState() => _MyProposedTermsScreenState();
}

class _MyProposedTermsScreenState extends State<MyProposedTermsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final dictionaryProvider =
          Provider.of<DictionaryProvider>(context, listen: false);

      if (authProvider.currentUser != null) {
        dictionaryProvider.loadUserProposedTerms(authProvider.currentUser!.id);
      }
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.myTermsTitle),
      ),
      body: Consumer<DictionaryProvider>(
        builder: (context, dictionaryProvider, child) {
          if (dictionaryProvider.isLoading) {
            return AppLoadingState(
              message: l10n.myTermsLoading,
            );
          }

          final terms = dictionaryProvider.userProposedTerms;
          if (terms.isEmpty) {
            return AppEmptyState(
              icon: Icons.article_outlined,
              title: l10n.myTermsEmptyTitle,
              message: l10n.myTermsEmptyMessage,
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
                      l10n.myTermsProposedCount,
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
                          l10n.myTermsApproved,
                          user?.termsApproved ?? 0,
                          AppConfig.accentColor,
                        ),
                        const SizedBox(width: AppConfig.paddingSmall),
                        _buildStatChip(
                          l10n.myTermsPending,
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
                child: RefreshIndicator(
                  onRefresh: () async {
                    final authProvider = Provider.of<AuthProvider>(context, listen: false);
                    final dictionaryProvider = Provider.of<DictionaryProvider>(context, listen: false);
                    if (authProvider.currentUser != null) {
                      dictionaryProvider.loadUserProposedTerms(authProvider.currentUser!.id);
                    }
                    await Future.delayed(const Duration(milliseconds: 600));
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(AppConfig.paddingMedium),
                    itemCount: terms.length,
                    itemBuilder: (context, index) {
                      final term = terms[index];
                      return Card(
                        margin: const EdgeInsets.only(
                            bottom: AppConfig.paddingMedium),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => TermDetailScreen(termId: term.id),
                              ),
                            );
                          },
                          borderRadius:
                              BorderRadius.circular(AppConfig.borderRadiusMedium),
                          child: Padding(
                            padding:
                                const EdgeInsets.all(AppConfig.paddingMedium),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        term.term,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                    _buildStatusChip(term.status, l10n),
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
                                    const SizedBox(
                                        width: AppConfig.paddingSmall / 2),
                                    Text(
                                      _getCategoryLabel(term.category, l10n),
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
                                      const SizedBox(
                                          width: AppConfig.paddingSmall / 2),
                                      Text(
                                        l10n.myTermsViewReason,
                                        style: const TextStyle(
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
                                    padding: const EdgeInsets.all(
                                        AppConfig.paddingSmall),
                                    decoration: BoxDecoration(
                                      color:
                                          AppConfig.errorColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(
                                          AppConfig.borderRadiusSmall),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.block,
                                          size: 16,
                                          color: AppConfig.errorColor,
                                        ),
                                        const SizedBox(
                                            width: AppConfig.paddingSmall / 2),
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
              ),
            ],
          );
        },
      ),
      floatingActionButton: _showBackToTopButton
          ? FloatingActionButton.small(
              heroTag: 'my_terms_back_to_top_btn',
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
            )
          : null,
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

  Widget _buildStatusChip(String status, AppLocalizations l10n) {
    Color color;
    String text;
    IconData icon;

    switch (status) {
      case 'approved':
        color = AppConfig.accentColor;
        text = l10n.dictStatusApproved;
        icon = Icons.check_circle;
        break;
      case 'pending':
        color = AppConfig.warningColor;
        text = l10n.dictStatusPending;
        icon = Icons.schedule;
        break;
      case 'rejected':
        color = AppConfig.errorColor;
        text = l10n.dictStatusRejected;
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

  String _getCategoryLabel(String category, AppLocalizations l10n) {
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
