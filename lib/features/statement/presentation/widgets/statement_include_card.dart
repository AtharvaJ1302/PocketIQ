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
                color: theme.colorScheme.primary.withValues(alpha: .08),
                borderRadius: BorderRadius.circular(18),
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

            const SizedBox(height: AppSpacing.xl),

            _StatementOptionTile(
              icon: Icons.pie_chart_rounded,
              iconColor: Colors.green,
              title: 'Category Summary',
              subtitle: 'Show spending grouped by category',
              value: options.includeCategories,
              onChanged: notifier.toggleCategories,
            ),

            const Divider(height: 1),

            _StatementOptionTile(
              icon: Icons.bar_chart_rounded,
              iconColor: Colors.blue,
              title: 'Budget Summary',
              subtitle: 'Compare budgets with actual spending',
              value: options.includeBudgetSummary,
              onChanged: notifier.toggleBudgetSummary,
            ),

            const Divider(height: 1),

            _StatementOptionTile(
              icon: Icons.sticky_note_2_rounded,
              iconColor: Colors.orange,
              title: 'Transaction Notes',
              subtitle: 'Include notes added to transactions',
              value: options.includeNotes,
              onChanged: notifier.toggleNotes,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatementOptionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _StatementOptionTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [

          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),

          const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          Switch.adaptive(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}