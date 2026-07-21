import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/features/constants/app_spacing.dart';
import '../../../../../core/features/constants/app_radius.dart';
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppRadius.borderRadiusXl,
          color: theme.brightness == Brightness.dark
              ? const Color(0xFF1B1D38).withValues(alpha: .85)
              : theme.colorScheme.surface.withValues(alpha: .92),
          border: Border.all(
            color: theme.brightness == Brightness.dark
                ? const Color(0xFF6F63FF).withValues(alpha: .18)
                : theme.colorScheme.outlineVariant.withValues(alpha: .30),
          ),
          boxShadow: [
            BoxShadow(
              color: theme.brightness == Brightness.dark
                  ? const Color(0xFF7C5CFF).withValues(alpha: .08)
                  : Colors.black.withValues(alpha: .05),
              blurRadius: 24,
              spreadRadius: -6,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            AppSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [

                  Icon(
                    Icons.donut_large_rounded,
                    size: 24,
                    color: theme.colorScheme.primary,
                  ),

                  const SizedBox(width: 10),

                  Text(
                    'Expense Breakdown',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: AppSpacing.xs,
              ),

              Text(
                'Where your money went this month',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(
                height: AppSpacing.xl,
              ),

              if (expenseTransactions.isEmpty)
                SizedBox(
                  height: 300,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withValues(alpha: .08),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.pie_chart_outline_rounded,
                            size: 46,
                            color: theme.colorScheme.primary,
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Text(
                          'No expense data yet',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Text(
                          'Track your spending by adding\n'
                              'your first expense transaction.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else ...[
                const ExpensePieChart(),

                const SizedBox(
                  height: AppSpacing.xl,
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