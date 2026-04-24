import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/dictionary_provider.dart';
import '../../config/app_config.dart';
import '../../widgets/common/app_empty_state.dart';
import 'propose_term_screen.dart';
import 'term_detail_screen.dart';

class DictionaryListScreen extends StatefulWidget {
  const DictionaryListScreen({super.key});

  @override
  State<DictionaryListScreen> createState() => _DictionaryListScreenState();
}

class _DictionaryListScreenState extends State<DictionaryListScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar términos aprobados
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DictionaryProvider>(context, listen: false)
          .loadApprovedTerms();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diccionario Gamer'),
      ),
      body: Consumer<DictionaryProvider>(
        builder: (context, dictionaryProvider, child) {
          if (dictionaryProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final terms = dictionaryProvider.approvedTerms;

          if (terms.isEmpty) {
            return const AppEmptyState(
              icon: Icons.book_outlined,
              title: 'No hay términos en el diccionario',
              message: 'Sé el primero en proponer un término',
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppConfig.paddingMedium),
            itemCount: terms.length,
            itemBuilder: (context, index) {
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const ProposeTermScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Proponer término'),
      ),
    );
  }
}
