import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/dictionary_provider.dart';
import '../../config/app_config.dart';
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
      Provider.of<DictionaryProvider>(context, listen: false).loadApprovedTerms();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diccionario Gamer'),
      ),
      body: Consumer<DictionaryProvider>(
        builder: (context, dictionaryProvider, child) {
          if (dictionaryProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          final terms = dictionaryProvider.approvedTerms;

          if (terms.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(AppConfig.paddingLarge),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.book_outlined,
                      size: 80,
                      color: AppConfig.textSecondaryColor,
                    ),
                    SizedBox(height: AppConfig.paddingMedium),
                    Text(
                      'No hay términos en el diccionario',
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppConfig.paddingSmall),
                    Text(
                      'Sé el primero en proponer un término',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(AppConfig.paddingMedium),
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
        icon: Icon(Icons.add),
        label: Text('Proponer término'),
      ),
    );
  }
}