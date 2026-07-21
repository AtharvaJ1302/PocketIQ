import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/features/constants/app_chart_colors.dart';
import '../../../../../../core/features/constants/app_spacing.dart';
import '../../../../../core/features/constants/app_radius.dart';
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
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [

                  Icon(
                    Icons.show_chart_rounded,
                    color: theme.colorScheme.primary,
                    size: 24,
                  ),

                  const SizedBox(width: 10),

                  Text(
                    'Cash Flow',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.xs),

              Text(
                'Monthly income vs expenses',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: (netCashFlow >= 0
                      ? AppChartColors.income
                      : AppChartColors.expense)
                      .withValues(alpha: .08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [

                    Icon(
                      netCashFlow >= 0
                          ? Icons.trending_up_rounded
                          : Icons.trending_down_rounded,
                      size: 30,
                      color: netCashFlow >= 0
                          ? AppChartColors.income
                          : AppChartColors.expense,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      '${netCashFlow >= 0 ? '+' : '-'}₹${netCashFlow.abs().toStringAsFixed(0)}',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: netCashFlow >= 0
                            ? AppChartColors.income
                            : AppChartColors.expense,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      netCashFlow >= 0
                          ? 'Positive Cash Flow'
                          : 'Negative Cash Flow',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                child: CashFlowChart(
                  key: ValueKey(analytics.filter),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              const CashFlowLegend(),
            ],
          ),
        ),
      ),
    );
  }
}