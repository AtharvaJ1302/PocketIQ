import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_categories.dart';
import '../../../../core/features/constants/app_radius.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/utils/currency_formatter.dart';
import '../../../shared/components/indicators/pocket_progress_bar.dart';
import '../domain/models/budget_summary.dart';

class BudgetTile extends StatelessWidget {
  final BudgetSummary summary;

  const BudgetTile({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final category =
    AppCategories.byName(
      summary.budget.category,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius:
        AppRadius.borderRadiusLg,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              CircleAvatar(
                backgroundColor:
                category?.color.withValues(
                  alpha: .15,
                ) ??
                    theme.colorScheme.primary
                        .withValues(
                      alpha: .15,
                    ),
                child: Icon(
                  category?.icon ??
                      Icons.category,
                  color:
                  category?.color ??
                      theme.colorScheme
                          .primary,
                ),
              ),

              const SizedBox(
                width: AppSpacing.md,
              ),

              Expanded(
                child: Text(
                  summary.budget.category,
                  style: theme
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),

              Text(
                summary.percentageLabel,
                style: theme
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          Row(
            children: [

              Expanded(
                child: _BudgetMetric(
                  title: 'Budget',
                  value: CurrencyFormatter
                      .format(
                    summary
                        .budget
                        .budgetAmount,
                  ),
                ),
              ),

              Expanded(
                child: _BudgetMetric(
                  title: 'Spent',
                  value: CurrencyFormatter
                      .format(
                    summary.spent,
                  ),
                ),
              ),

              Expanded(
                child: _BudgetMetric(
                  title:
                  summary.isExceeded
                      ? 'Exceeded'
                      : 'Remaining',
                  value: CurrencyFormatter
                      .format(
                    summary.isExceeded
                        ? summary.exceeded
                        : summary.remaining,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          PocketProgressBar(
            progress: summary.progress,
          ),
        ],
      ),
    );
  }
}

class _BudgetMetric extends StatelessWidget {
  final String title;
  final String value;

  const _BudgetMetric({
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
          style:
          theme.textTheme.bodySmall,
        ),

        const SizedBox(
          height: AppSpacing.xs,
        ),

        Text(
          value,
          style: theme
              .textTheme
              .titleMedium
              ?.copyWith(
            fontWeight:
            FontWeight.bold,
          ),
        ),
      ],
    );
  }
}