import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../models/transaction_form_args.dart';
import '../providers/transaction_provider.dart';
import '../widgets/transaction_empty_state.dart';
import '../widgets/transaction_list.dart';

class TransactionsScreen extends ConsumerStatefulWidget {
  const TransactionsScreen({super.key});

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.push(
            AppRoutes.addTransaction,
            extra: const TransactionFormArgs(),
          );

          if (!mounted) return;

          ref.read(transactionProvider).refresh();
        },
        child: const Icon(Icons.add),
      ),

      body: notifier.loading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : RefreshIndicator(
        onRefresh: _refresh,
        child: notifier.transactions.isEmpty
            ? const TransactionEmptyState()
            : TransactionList(
          transactions: notifier.transactions,
        ),
      ),
    );
  }
}