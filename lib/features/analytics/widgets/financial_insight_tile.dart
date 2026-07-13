import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_radius.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../domain/models/financial_insight.dart';

class FinancialInsightTile
    extends StatelessWidget {

  final FinancialInsight insight;

  const FinancialInsightTile({
    super.key,
    required this.insight,
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
        color:
        theme.colorScheme.surfaceContainer,
        borderRadius:
        AppRadius.borderRadiusLg,
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Icon(
            insight.icon,
            color:
            theme.colorScheme.primary,
          ),

          const SizedBox(
            width: AppSpacing.md,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  insight.title,
                  style: theme
                      .textTheme.titleMedium
                      ?.copyWith(
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: AppSpacing.xs,
                ),

                Text(
                  insight.description,
                  style:
                  theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}