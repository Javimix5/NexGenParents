import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/dictionary_provider.dart';
import '../../config/app_config.dart';
import '../../widgets/common/app_empty_state.dart';
import 'propose_term_screen.dart';
import 'term_detail_screen.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/common/app_footer.dart';
import '../info/pegi_info_screen.dart';
import '../parental_guides/parental_guides_list_screen.dart';

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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Consumer<DictionaryProvider>(
        builder: (context, dictionaryProvider, child) {
          if (dictionaryProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final terms = dictionaryProvider.approvedTerms;

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
                return Padding(
                  padding: const EdgeInsets.only(top: AppConfig.paddingLarge),
                  child: AppFooter(
                    onPrivacyTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const PegiInfoScreen())),
                    onAboutTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const PegiInfoScreen())),
                    onContactTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ParentalGuidesListScreen())),
                  ),
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ProposeTermScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: Text(l10n.dictListProposeBtn),
          ),
        ],
      ),
    );
  }
}
