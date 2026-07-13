import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/features/constants/app_radius.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/utils/currency_formatter.dart';
import '../../../shared/components/indicators/pocket_progress_bar.dart';
import '../domain/models/category_summary.dart';

class CategoryTile extends StatelessWidget {
  final CategorySummary category;

  final Gradient gradient;

  const CategoryTile({
    super.key,
    required this.category,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(
        bottom: AppSpacing.md,
      ),
      padding: const EdgeInsets.all(
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: AppRadius.borderRadiusLg,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              Expanded(
                child: Text(
                  category.category,
                  style: theme.textTheme.titleMedium,
                ),
              ),

              Text(
                CurrencyFormatter.format(
                  category.amount,
                ),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          PocketProgressBar(
            progress: category.percentage,
            gradient: gradient,
          ),

          const SizedBox(
            height: AppSpacing.sm,
          ),

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${(category.percentage * 100).toStringAsFixed(0)}% of expenses',
                style: theme.textTheme.bodySmall?.copyWith(
                  color:
                  theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(
        begin: .15,
        duration: 350.ms,
    );
  }
}