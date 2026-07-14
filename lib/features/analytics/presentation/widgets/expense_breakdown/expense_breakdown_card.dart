import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/features/constants/app_spacing.dart';
import '../../../domain/models/analytics_filter.dart';
import '../../providers/analytics_provider.dart';
import 'expense_pie_chart.dart';
import 'statistics_panel.dart';

class ExpenseBreakdownCard extends ConsumerWidget {
  const ExpenseBreakdownCard({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final theme = Theme.of(context);

    final analytics =
    ref.watch(analyticsProvider);

    final expenseTransactions =
    analytics.filteredTransactions
        .where(
          (transaction) =>
      transaction.isExpense,
    )
        .toList();

    return Padding(
      padding: AppSpacing.screenPadding,
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(
            AppSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              Text(
                'Expense Breakdown',
                style: theme
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: AppSpacing.lg,
              ),

              if (expenseTransactions.isEmpty)
                SizedBox(
                  height: 260,
                  child: Center(
                    child: Column(
                      mainAxisSize:
                      MainAxisSize.min,
                      children: [

                        Icon(
                          Icons.pie_chart_outline_rounded,
                          size: 64,
                          color: theme
                              .colorScheme
                              .outline,
                        ),

                        const SizedBox(
                          height: 16,
                        ),

                        Text(
                          'No expense data',
                          style: theme
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        Text(
                          'Add expense transactions for this period\n'
                              'to see your spending breakdown.',
                          textAlign:
                          TextAlign.center,
                          style: theme
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                            color: theme
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else ...[
                const ExpensePieChart(),

                const SizedBox(
                  height: AppSpacing.lg,
                ),

                const StatisticsPanel(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _labelForFilter(
      AnalyticsFilter filter,
      ) {
    switch (filter) {
      case AnalyticsFilter.thisMonth:
        return 'This Month';

      case AnalyticsFilter.lastMonth:
        return 'Last Month';

      case AnalyticsFilter.last3Months:
        return 'Past 3 Months';

      case AnalyticsFilter.thisYear:
        return 'This Year';
    }
  }
}