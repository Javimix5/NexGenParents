import 'package:flutter/material.dart';

import '../../config/app_config.dart';

class AppLoadingState extends StatelessWidget {
  const AppLoadingState({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: AppConfig.paddingMedium),
          Text(message),
        ],
      ),
    );
  }
}
