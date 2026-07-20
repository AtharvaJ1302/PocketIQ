import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_radius.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/finance/category_colors.dart';
import '../../../../core/features/finance/category_icons.dart';
import '../../../../core/features/utils/currency_formatter.dart';
import '../../../transactions/domain/models/transaction.dart';

class RecentTransactionCard extends StatelessWidget {
  final Transaction transaction;

  const RecentTransactionCard({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: theme.brightness == Brightness.dark
              ? Colors.white.withValues(alpha: .05)
              : Colors.black.withValues(alpha: .04),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.brightness == Brightness.dark
                ? Colors.black.withValues(alpha: .12)
                : Colors.black.withValues(alpha: .05),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        child: Row(
          children: [

            /// Category Icon
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: CategoryColors.get(
                  transaction.category,
                ).withValues(alpha: .15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                CategoryIcons.get(transaction.category),
                color: CategoryColors.get(transaction.category),
                size: 24,
              ),
            ),

            const SizedBox(width: 16),

            /// Transaction Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [

                  Text(
                    transaction.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    transaction.isExpense
                        ? 'Expense'
                        : 'Income',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: .55),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            /// Amount & Status
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [

                Text(
                  '${transaction.isExpense ? '-' : '+'}${CurrencyFormatter.format(transaction.amount)}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: transaction.isExpense
                        ? Colors.red
                        : Colors.green,
                  ),
                ),

                const SizedBox(height: 6),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: (transaction.isExpense
                        ? Colors.red
                        : Colors.green)
                        .withValues(alpha: .10),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    transaction.isExpense
                        ? 'Debit'
                        : 'Credit',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: transaction.isExpense
                          ? Colors.red
                          : Colors.green,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}