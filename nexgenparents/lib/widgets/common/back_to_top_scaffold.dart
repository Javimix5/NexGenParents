import 'package:flutter/material.dart';
import '../../config/app_config.dart';

class BackToTopScaffold extends StatefulWidget {
  final PreferredSizeWidget? appBar;
  /// El builder nos permite pasarle el ScrollController a la lista/contenido hijo
  final Widget Function(BuildContext context, ScrollController controller) builder;
  final Widget? floatingActionButton;
  final String heroTag;
  final Color? backgroundColor;

  const BackToTopScaffold({
    super.key,
    this.appBar,
    required this.builder,
    this.floatingActionButton,
    required this.heroTag,
    this.backgroundColor,
  });

  @override
  State<BackToTopScaffold> createState() => _BackToTopScaffoldState();
}

class _BackToTopScaffoldState extends State<BackToTopScaffold> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: widget.appBar,
      body: widget.builder(context, _scrollController),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min, // Importante para que no ocupe toda la pantalla
        children: [
          if (_showBackToTopButton) ...[
            FloatingActionButton.small(
              heroTag: widget.heroTag,
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
            if (widget.floatingActionButton != null) const SizedBox(height: 16),
          ],
          if (widget.floatingActionButton != null) widget.floatingActionButton!,
        ],
      ),
    );
  }
}