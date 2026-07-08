import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/dialogs/confirm_delete_dialog.dart';
import '../../domain/models/transaction.dart';
import '../models/transaction_form_args.dart';
import '../providers/transaction_provider.dart';
import 'transaction_actions_sheet.dart';
import 'transaction_card.dart';

class TransactionList extends ConsumerWidget {
  final List<Transaction> transactions;

  const TransactionList({
    super.key,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: AppSpacing.screenPadding,
      itemCount: transactions.length,
      separatorBuilder: (_, __) =>
      const SizedBox(height: AppSpacing.md),
      itemBuilder: (_, index) {
        final transaction = transactions[index];

        return TransactionCard(
          transaction: transaction,

          onTap: () {
            context.push(
              AppRoutes.addTransaction,
              extra: TransactionFormArgs(
                transaction: transaction,
              ),
            );
          },

          onLongPress: () {
            showModalBottomSheet(
              context: context,
              showDragHandle: true,
              builder: (_) => TransactionActionsSheet(
                onEdit: () {
                  context.push(
                    AppRoutes.addTransaction,
                    extra: TransactionFormArgs(
                      transaction: transaction,
                    ),
                  );
                },
                onDelete: () {
                  showDialog(
                    context: context,
                    builder: (_) => ConfirmDeleteDialog(
                      title: 'Delete Transaction',
                      message:
                      'Are you sure you want to delete this transaction?',
                      onDelete: () async {
                        await ref
                            .read(transactionProvider)
                            .deleteTransaction(transaction.id);
                      },
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}