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
    final theme = Theme.of(context);

    final notifier = ref.watch(transactionProvider);

    final transactions = notifier.transactions.take(3).toList();

    return Padding(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      'Recent Transactions',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Your latest financial activity',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: .55),
                      ),
                    ),
                  ],
                ),
              ),

              if (transactions.isNotEmpty)
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    context.push(AppRoutes.transactions);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 6,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Text(
                          'View All',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(width: 4),

                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                          color: theme.colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 20),

          /// Loading
          if (notifier.loading)

            Column(
              children: List.generate(
                3,
                    (_) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Container(
                    height: 86,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                ),
              ),
            )

          /// Empty State
          else if (transactions.isEmpty)

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Column(
                  children: [

                    Icon(
                      Icons.receipt_long_outlined,
                      size: 48,
                      color: theme.colorScheme.onSurface.withValues(alpha: .30),
                    ),

                    const SizedBox(height: 14),

                    Text(
                      'No transactions yet',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Your recent transactions will appear here.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: .55),
                      ),
                    ),
                  ],
                ),
              ),
            )

          /// Transactions
          else

            ...transactions.map(
                  (transaction) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
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