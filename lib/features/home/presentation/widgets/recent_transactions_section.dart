import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../transactions/presentation/providers/transaction_provider.dart';
import 'recent_transaction_card.dart';

class RecentTransactionsSection extends ConsumerStatefulWidget {
  const RecentTransactionsSection({super.key});

  @override
  ConsumerState<RecentTransactionsSection> createState() =>
      _RecentTransactionsSectionState();
}

class _RecentTransactionsSectionState
    extends ConsumerState<RecentTransactionsSection> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(transactionProvider).loadTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(transactionProvider);

    final transactions =
    notifier.transactions.take(3).toList();

    return Padding(
      padding: AppSpacing.screenPadding,
      child: Column(
        children: [

          Row(
            children: [

              Text(
                'Recent Transactions',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall,
              ),

              const Spacer(),

              if (transactions.isNotEmpty)
                TextButton(
                  onPressed: () {
                    context.push(
                      AppRoutes.transactions,
                    );
                  },
                  child: const Text('View All'),
                ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          if (notifier.loading)
            const Padding(
              padding: EdgeInsets.all(24),
              child: CircularProgressIndicator(),
            )

          else if (transactions.isEmpty)

            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 24,
              ),
              child: Text(
                'No transactions yet.',
              ),
            )

          else

            ...transactions.map(
                  (transaction) => Padding(
                padding: const EdgeInsets.only(
                  bottom: AppSpacing.md,
                ),
                child: RecentTransactionCard(
                  transaction: transaction,
                ),
              ),
            ),
        ],
      ),
    );
  }
}