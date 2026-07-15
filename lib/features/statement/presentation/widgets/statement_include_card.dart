import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/features/constants/app_spacing.dart';
import '../providers/statement_provider.dart';

class StatementIncludeCard extends ConsumerWidget {
  const StatementIncludeCard({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final theme = Theme.of(context);

    final notifier =
    ref.watch(statementProvider);

    final options =
        notifier.options;

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(
          AppSpacing.lg,
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            Text(
              'Customize Statement',
              style: theme.textTheme.titleMedium
                  ?.copyWith(
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: AppSpacing.md,
            ),

            Container(
              padding: const EdgeInsets.all(
                AppSpacing.md,
              ),
              decoration: BoxDecoration(
                color: theme
                    .colorScheme
                    .primaryContainer,
                borderRadius:
                BorderRadius.circular(
                  12,
                ),
              ),
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Icon(
                    Icons.info_outline_rounded,
                    color: theme
                        .colorScheme
                        .primary,
                  ),

                  const SizedBox(
                    width: 12,
                  ),

                  Expanded(
                    child: Text(
                      'Every statement automatically includes your income, expenses, savings, and all transactions. Choose any additional sections below.',
                      style: theme
                          .textTheme
                          .bodySmall,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: AppSpacing.lg,
            ),

            SwitchListTile(
              contentPadding:
              EdgeInsets.zero,
              title: const Text(
                'Category Summary',
              ),
              subtitle: const Text(
                'Show spending grouped by category',
              ),
              value:
              options.includeCategories,
              onChanged:
              notifier.toggleCategories,
            ),

            SwitchListTile(
              contentPadding:
              EdgeInsets.zero,
              title: const Text(
                'Budget Summary',
              ),
              subtitle: const Text(
                'Compare budgets with actual spending',
              ),
              value: options
                  .includeBudgetSummary,
              onChanged:
              notifier.toggleBudgetSummary,
            ),

            SwitchListTile(
              contentPadding:
              EdgeInsets.zero,
              title: const Text(
                'Transaction Notes',
              ),
              subtitle: const Text(
                'Include notes added to transactions',
              ),
              value:
              options.includeNotes,
              onChanged:
              notifier.toggleNotes,
            ),
          ],
        ),
      ),
    );
  }
}