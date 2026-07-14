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

        Row(
          children: [

            Expanded(
              child: StatTile(
                icon: Icons.emoji_events_rounded,
                title: 'Largest',
                value: largestCategory.category,
                subtitle:
                '${(largestCategory.percentage * 100).toStringAsFixed(0)}%',
              ),
            ),

            const SizedBox(
              width: AppSpacing.md,
            ),

            Expanded(
              child: StatTile(
                icon: Icons.trending_up_rounded,
                title: 'Biggest',
                value:
                '₹${biggestExpense.amount.toStringAsFixed(0)}',
                subtitle:
                biggestExpense.category,
              ),
            ),
          ],
        ),

        const SizedBox(
          height: AppSpacing.md,
        ),

        Row(
          children: [

            Expanded(
              child: StatTile(
                icon:
                Icons.calendar_today_rounded,
                title: 'Avg / Day',
                value:
                '₹${average.toStringAsFixed(0)}',
                subtitle: 'Daily',
              ),
            ),

            const SizedBox(
              width: AppSpacing.md,
            ),

            Expanded(
              child: StatTile(
                icon:
                Icons.receipt_long_rounded,
                title: 'Expenses',
                value:
                '${expenses.length}',
                subtitle:
                'Transactions',
              ),
            ),
          ],
        ),
      ],
    );
  }
}