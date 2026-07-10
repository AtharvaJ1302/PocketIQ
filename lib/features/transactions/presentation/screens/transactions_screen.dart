import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../models/transaction_form_args.dart';
import '../models/transactions_screen_args.dart';
import '../providers/transaction_provider.dart';
import '../widgets/transaction_empty_state.dart';
import '../widgets/transaction_list.dart';

class TransactionsScreen extends ConsumerStatefulWidget {
  final TransactionsScreenArgs? args;

  const TransactionsScreen({
    super.key,
    this.args,
  });

  @override
  ConsumerState<TransactionsScreen> createState() =>
      _TransactionsScreenState();
}

class _TransactionsScreenState
    extends ConsumerState<TransactionsScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(transactionProvider).loadTransactions();
    });
  }

  Future<void> _refresh() async {
    await ref.read(transactionProvider).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(transactionProvider);

    var transactions = notifier.transactions;

    final filter = widget.args?.filter;

    if (filter?.accountId != null) {
      transactions = transactions
          .where(
            (t) => t.accountId == filter!.accountId,
      )
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.args?.screenTitle ?? 'Transactions',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.push(
            AppRoutes.addTransaction,
            extra: TransactionFormArgs(
              accountId: filter?.accountId,
              lockAccount: filter?.accountId != null,
            ),
          );

          if (!mounted) return;

          await ref
              .read(transactionProvider)
              .refresh();
        },
        child: const Icon(Icons.add),
      ),
      body: notifier.loading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : RefreshIndicator(
        onRefresh: _refresh,
        child: transactions.isEmpty
            ? TransactionEmptyState(
          message: filter?.accountId != null
              ? 'No transactions found for this account.'
              : 'Tap + to add your first transaction.',
        )
            : TransactionList(
          transactions: transactions,
        ),
      ),
    );
  }
}