import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pocketiq/features/transactions/presentation/widgets/transaction_date_header.dart';

import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/utils/transaction_date_formatter.dart';
import '../../domain/models/transaction.dart';
import 'transaction_card.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({
    super.key,
    required this.transactions,
  });

  bool _shouldShowHeader(
      int index,
      List<Transaction> transactions,
      ) {
    if (index == 0) {
      return true;
    }

    final current = transactions[index].date;
    final previous = transactions[index - 1].date;

    return current.year != previous.year ||
        current.month != previous.month ||
        current.day != previous.day;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: AppSpacing.screenPadding,
      itemCount: transactions.length,
      itemBuilder: (_, index) {
        final transaction = transactions[index];

        return Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            if (_shouldShowHeader(
              index,
              transactions,
            ))
              TransactionDateHeader(
                title: TransactionDateFormatter.header(
                  transaction.date,
                ),
              ),

            Padding(
              padding: const EdgeInsets.only(
                bottom: AppSpacing.md,
              ),
              child: TransactionCard(
                transaction: transaction,
                onTap: () {
                  // TODO
                },
              ),
            ),
          ],
        );
      },
    );
  }
}