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

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.borderRadiusMd,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: CategoryColors
                  .get(transaction.category)
                  .withValues(alpha: .15),
              child: Icon(
                CategoryIcons.get(transaction.category),
                color: CategoryColors.get(
                  transaction.category,
                ),
              ),
            ),

            const SizedBox(width: AppSpacing.md),

            Expanded(
              child: Text(
                transaction.category,
                style: theme.textTheme.titleSmall,
              ),
            ),

            Text(
              '${transaction.isExpense ? '-' : '+'}${CurrencyFormatter.format(transaction.amount)}',
              style: theme.textTheme.titleSmall?.copyWith(
                color: transaction.isExpense
                    ? Colors.red
                    : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}