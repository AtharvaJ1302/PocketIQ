import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_radius.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/utils/currency_formatter.dart';
import '../../../../shared/components/indicators/pocket_progress_bar.dart';

class OverallBudgetCard extends StatelessWidget {
  final double totalBudget;
  final double spent;
  final double remaining;
  final double progress;

  const OverallBudgetCard({
    super.key,
    required this.totalBudget,
    required this.spent,
    required this.remaining,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius:
        AppRadius.borderRadiusXl,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Text(
            'Monthly Budget',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: AppSpacing.xl,
          ),

          Row(
            children: [

              Expanded(
                child: _Metric(
                  title: 'Budget',
                  value: CurrencyFormatter.format(
                    totalBudget,
                  ),
                ),
              ),

              Expanded(
                child: _Metric(
                  title: 'Spent',
                  value: CurrencyFormatter.format(
                    spent,
                  ),
                ),
              ),

              Expanded(
                child: _Metric(
                  title: 'Remaining',
                  value: CurrencyFormatter.format(
                    remaining,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.xl,
          ),

          PocketProgressBar(
            progress: progress,
          ),

          const SizedBox(
            height: AppSpacing.sm,
          ),

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${(progress * 100).toStringAsFixed(0)}%',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String title;
  final String value;

  const _Metric({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [

        Text(
          title,
          style: theme.textTheme.bodySmall,
        ),

        const SizedBox(
          height: AppSpacing.xs,
        ),

        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}