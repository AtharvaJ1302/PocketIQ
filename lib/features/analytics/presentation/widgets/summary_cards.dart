import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/services/financial_insights_service_provider.dart';
import '../../../../core/features/utils/currency_formatter.dart';
import '../../../transactions/presentation/providers/transaction_provider.dart';
import 'summary_card.dart';

class SummaryCards extends ConsumerWidget {
  const SummaryCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service =
    ref.read(financialInsightsServiceProvider);

    final transactions =
        ref.watch(transactionProvider).transactions;

    final income =
    service.getTotalIncome(transactions);

    final expense =
    service.getTotalExpense(transactions);

    final savings =
    service.getSavings(transactions);

    return Padding(
      padding: AppSpacing.screenPadding,
      child: Column(
        children: [
          SummaryCard(
            title: 'Income',
            amount:
            CurrencyFormatter.format(income),
            icon:
            Icons.arrow_downward_rounded,
            color: Colors.green,
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          SummaryCard(
            title: 'Expenses',
            amount:
            CurrencyFormatter.format(expense),
            icon:
            Icons.arrow_upward_rounded,
            color: Colors.red,
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          SummaryCard(
            title: 'Savings',
            amount:
            CurrencyFormatter.format(savings),
            icon:
            Icons.savings_rounded,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}