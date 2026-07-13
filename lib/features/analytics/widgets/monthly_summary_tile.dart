import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_radius.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/utils/currency_formatter.dart';
import '../domain/models/monthly_summary.dart';

class MonthlySummaryTile extends StatelessWidget {
  final MonthlySummary summary;

  const MonthlySummaryTile({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final month = DateTime(
      summary.year,
      summary.month,
    );

    return Container(
      margin: const EdgeInsets.only(
        bottom: AppSpacing.md,
      ),
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

          Text(
            "${_monthName(month.month)} ${summary.year}",
            style: theme.textTheme.titleMedium
                ?.copyWith(
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          _Row(
            title: "Income",
            amount: summary.income,
          ),

          _Row(
            title: "Expense",
            amount: summary.expense,
          ),

          _Row(
            title: "Savings",
            amount: summary.savings,
          ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return months[month];
  }
}

class _Row extends StatelessWidget {
  final String title;
  final double amount;

  const _Row({
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Row(
        children: [

          Expanded(
            child: Text(title),
          ),

          Text(
            CurrencyFormatter.format(
              amount,
            ),
          ),
        ],
      ),
    );
  }
}