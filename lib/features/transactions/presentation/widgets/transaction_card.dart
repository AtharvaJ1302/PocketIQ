import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_radius.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/finance/category_colors.dart';
import '../../../../core/features/finance/category_icons.dart';
import '../../../../core/features/utils/currency_formatter.dart';
import '../../domain/models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final amountColor = transaction.isExpense
        ? Colors.red
        : Colors.green;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.borderRadiusLg,
      ),
      child: InkWell(
        borderRadius: AppRadius.borderRadiusLg,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: CategoryColors.get(
                  transaction.category,
                ).withValues(alpha: .15),
                child: Icon(
                  CategoryIcons.get(transaction.category),
                  color: CategoryColors.get(
                    transaction.category,
                  ),
                ),
              ),

              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.category,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    if (transaction.note != null &&
                        transaction.note!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4,
                        ),
                        child: Text(
                          transaction.note!,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                  ],
                ),
              ),

              Text(
                '${transaction.isExpense ? '-' : '+'} ${CurrencyFormatter.format(transaction.amount)}',
                style: theme.textTheme.titleMedium
                    ?.copyWith(
                  color: amountColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}