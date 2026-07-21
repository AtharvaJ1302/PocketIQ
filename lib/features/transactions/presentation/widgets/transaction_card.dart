import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme/themes/app_shadows.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/finance/category_colors.dart';
import '../../../../core/features/finance/category_icons.dart';
import '../../../../core/features/utils/currency_formatter.dart';
import '../../../../core/features/utils/transaction_date_formatter.dart';
import '../../domain/models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback? onTap;

  const TransactionCard({
    super.key,
    required this.transaction,
    this.onTap,
  });

  String _formatDate(DateTime date) {
    final now = DateTime.now();

    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final yesterday = today.subtract(
      const Duration(days: 1),
    );

    final transactionDate = DateTime(
      date.year,
      date.month,
      date.day,
    );

    if (transactionDate == today) {
      return "Today • ${DateFormat('hh:mm a').format(date)}";
    }

    if (transactionDate == yesterday) {
      return "Yesterday • ${DateFormat('hh:mm a').format(date)}";
    }

    return DateFormat(
      'dd MMM • hh:mm a',
    ).format(date);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final accentColor = CategoryColors.get(
      transaction.category,
    );

    final amountColor = transaction.isExpense
        ? Colors.red.shade600
        : Colors.green.shade600;

    return AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        child: Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          // boxShadow: AppShadows.card(context),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            child: Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(
                      alpha: .12,
                    ),
                    borderRadius:
                    BorderRadius.circular(18),
                    border: Border.all(
                      color: accentColor.withValues(
                        alpha: .18,
                      ),
                    ),
                  ),
                  child: Icon(
                    CategoryIcons.get(
                      transaction.category,
                    ),
                    size: 28,
                    color: accentColor,
                  ),
                ),

                const SizedBox(
                  width: AppSpacing.md,
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.category,
                        style: theme
                            .textTheme.titleMedium
                            ?.copyWith(
                          fontWeight:
                          FontWeight.w700,
                        ),
                      ),

                      if (transaction.note
                          ?.isNotEmpty ??
                          false) ...[
                        const SizedBox(height: 6),
                        Text(
                          transaction.note!,
                          maxLines: 2,
                          overflow:
                          TextOverflow.ellipsis,
                          style: theme
                              .textTheme.bodyMedium
                              ?.copyWith(
                            color: theme
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                        ),
                      ],

                      const SizedBox(height: 10),

                      Text(
                        TransactionDateFormatter.subtitle(
                          transaction.date,
                        ),
                        style: theme
                            .textTheme.bodySmall
                            ?.copyWith(
                          color: theme
                              .colorScheme
                              .onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${transaction.isExpense ? "-" : "+"}${CurrencyFormatter.format(transaction.amount)}",
                      style: theme
                          .textTheme.titleMedium
                          ?.copyWith(
                        color: amountColor,
                        fontWeight:
                        FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
        ),
    );
  }
}