import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../config/app_config.dart';

class GameCardShimmer extends StatelessWidget {
  const GameCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Colores base para el esqueleto (adaptables al modo oscuro/claro)
    final baseColor = isDark ? Colors.grey[850]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Card(
        margin: const EdgeInsets.only(bottom: AppConfig.paddingMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppConfig.paddingMedium),
          child: Row(
            children: [
              // 1. Placeholder de la imagen
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: isDark ? AppConfig.cardDark : Colors.white,
                  borderRadius: BorderRadius.circular(AppConfig.borderRadiusSmall),
                ),
              ),
              const SizedBox(width: AppConfig.paddingMedium),
              // 2. Placeholder de textos
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 16,
                      decoration: BoxDecoration(
                        color: isDark ? AppConfig.cardDark : Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: AppConfig.paddingSmall / 2),
                    Container(
                      width: 100,
                      height: 16,
                      decoration: BoxDecoration(
                        color: isDark ? AppConfig.cardDark : Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: AppConfig.paddingSmall / 2),
                    Container(
                      width: 60,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isDark ? AppConfig.cardDark : Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
              // Placeholder para el icono arrow_forward_ios
              Container(
                width: 12,
                height: 16,
                decoration: BoxDecoration(
                  color: isDark ? AppConfig.cardDark : Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}