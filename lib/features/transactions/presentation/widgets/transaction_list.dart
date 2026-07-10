import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_spacing.dart';
import '../../domain/models/transaction.dart';
import 'transaction_card.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({
    super.key,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: AppSpacing.screenPadding,
      itemCount: transactions.length,
      separatorBuilder: (_, __) =>
      const SizedBox(height: AppSpacing.md),
      itemBuilder: (_, index) {
        final transaction = transactions[index];

        return GestureDetector(
          onTap: () {
            // TODO:
            // Navigate to Transaction Details Screen
          },
          child: TransactionCard(
            transaction: transaction,
          ),
        );
      },
    );
  }
}