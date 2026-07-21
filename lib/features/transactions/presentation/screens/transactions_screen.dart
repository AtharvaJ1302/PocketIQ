import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/colors/app_gradients.dart';
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
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

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

    return Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? AppGradients.screenBackground
              : AppGradients.screenBackgroundLight,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
        centerTitle: false,
        title: Text(
          widget.args?.screenTitle ?? "Transactions",
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'transactionsFab',
        tooltip: 'Add Transaction',
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
        child: const Icon(
          Icons.add_rounded,
          size: 28,
        ),
      ),
      body: notifier.loading
          ? const Center(
        child: SizedBox(
          width: 34,
          height: 34,
          child: CircularProgressIndicator(
            strokeWidth: 3,
          ),
        ),
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
        ),
    );
  }
}