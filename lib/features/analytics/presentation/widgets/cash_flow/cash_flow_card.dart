import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/features/constants/app_chart_colors.dart';
import '../../../../../../core/features/constants/app_spacing.dart';
import '../../providers/analytics_provider.dart';
import 'cash_flow_chart.dart';
import 'cash_flow_legend.dart';

class CashFlowCard extends ConsumerWidget {
  const CashFlowCard({
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

    final income = analytics.filteredTransactions
        .where((transaction) => transaction.isIncome)
        .fold<double>(
      0,
          (sum, transaction) =>
      sum + transaction.amount,
    );

    final expense = analytics.filteredTransactions
        .where((transaction) => transaction.isExpense)
        .fold<double>(
      0,
          (sum, transaction) =>
      sum + transaction.amount,
    );

    final netCashFlow =
        income - expense;

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
                'Cash Flow',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              Text(
                'Net Cash Flow',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(
                height: 4,
              ),

              Row(
                children: [

                  Text(
                    '${netCashFlow >= 0 ? '+' : '-'}₹${netCashFlow.abs().toStringAsFixed(0)}',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: netCashFlow >= 0
                          ? AppChartColors.income
                          : AppChartColors.expense,
                    ),
                  ),

                  const SizedBox(
                    width: 8,
                  ),

                  Icon(
                    netCashFlow >= 0
                        ? Icons.trending_up_rounded
                        : Icons.trending_down_rounded,
                    color: netCashFlow >= 0
                        ? AppChartColors.income
                        : AppChartColors.expense,
                  ),
                ],
              ),

              const SizedBox(
                height: AppSpacing.lg,
              ),

              const CashFlowLegend(),

              const SizedBox(
                height: AppSpacing.lg,
              ),

              AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: 350,
                ),
                switchInCurve:
                Curves.easeOut,
                switchOutCurve:
                Curves.easeIn,
                child: CashFlowChart(
                  key: ValueKey(
                    analytics.filter,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}