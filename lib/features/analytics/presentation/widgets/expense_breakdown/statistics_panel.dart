import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/features/constants/app_spacing.dart';
import '../../../../../core/features/services/financial_insights_service_provider.dart';
import '../../../../transactions/presentation/providers/transaction_provider.dart';
import '../../providers/analytics_provider.dart';
import 'stat_tile.dart';

class StatisticsPanel extends ConsumerWidget {
  const StatisticsPanel({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final service =
    ref.read(financialInsightsServiceProvider);

    final transactions =
        ref.watch(analyticsProvider)
            .filteredTransactions;

    final expenses = transactions
        .where((transaction) => transaction.isExpense)
        .toList();

    if (expenses.isEmpty) {
      return const SizedBox.shrink();
    }

    final categories =
    service.getCategorySummary(transactions);

    final largestCategory =
        categories.first;

    expenses.sort(
          (a, b) => b.amount.compareTo(a.amount),
    );

    final biggestExpense =
        expenses.first;

    final totalExpense =
    service.getTotalExpense(transactions);

    final uniqueDays = expenses
        .map(
          (transaction) => DateTime(
        transaction.date.year,
        transaction.date.month,
        transaction.date.day,
      ),
    )
        .toSet()
        .length;

    final average =
    uniqueDays == 0
        ? 0
        : totalExpense / uniqueDays;

    return Column(
      children: [

        const Divider(),

        const SizedBox(
          height: AppSpacing.lg,
        ),

        _InsightRow(
          icon: Icons.emoji_events_rounded,
          iconColor: Colors.amber,
          title: 'Largest Category',
          value: largestCategory.category,
          trailing:
          '${(largestCategory.percentage * 100).toStringAsFixed(0)}%',
        ),

        const SizedBox(height: AppSpacing.lg),

        _InsightRow(
          icon: Icons.payments_rounded,
          iconColor: Colors.red,
          title: 'Biggest Expense',
          value:
          '₹${biggestExpense.amount.toStringAsFixed(0)}',
          trailing: biggestExpense.category,
        ),

        const SizedBox(height: AppSpacing.lg),

        _InsightRow(
          icon: Icons.calendar_today_rounded,
          iconColor: Colors.blue,
          title: 'Daily Average',
          value:
          '₹${average.toStringAsFixed(0)}',
          trailing: 'Per Day',
        ),

        const SizedBox(height: AppSpacing.lg),

        _InsightRow(
          icon: Icons.receipt_long_rounded,
          iconColor: Colors.green,
          title: 'Transactions',
          value: '${expenses.length}',
          trailing: 'Expenses',
        ),
      ],
    );
  }
}

class _InsightRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;
  final String trailing;

  const _InsightRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [

        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: .10),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 22,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                value,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        Text(
          trailing,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}