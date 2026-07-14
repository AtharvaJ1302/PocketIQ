import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/features/constants/app_radius.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/services/financial_insights_service_provider.dart';
import '../../../budget/presentation/providers/budget_provider.dart';
import '../../../transactions/presentation/providers/transaction_provider.dart';
import '../../domain/models/analytics_filter.dart';
import '../providers/analytics_provider.dart';

class BudgetHealth extends ConsumerWidget {
  const BudgetHealth({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final theme = Theme.of(context);

    final analytics =
    ref.watch(analyticsProvider);

    if (analytics.filter !=
        AnalyticsFilter.thisMonth) {
      return const SizedBox.shrink();
    }

    final budgetNotifier =
    ref.watch(budgetProvider);

    final transactions =
        ref.watch(analyticsProvider)
            .filteredTransactions;

    if (budgetNotifier.budgets.isEmpty) {
      return const SizedBox.shrink();
    }

    final service = ref.read(
      financialInsightsServiceProvider,
    );

    final summaries =
    service.getBudgetSummaries(
      budgets: budgetNotifier.budgets,
      transactions: transactions,
    );

    int healthy = 0;
    int nearLimit = 0;
    int exceeded = 0;

    for (final summary in summaries) {
      if (summary.rawProgress >= 1.0) {
        exceeded++;
      } else if (summary.rawProgress >= 0.80) {
        nearLimit++;
      } else {
        healthy++;
      }
    }

    return Padding(
      padding: AppSpacing.screenPadding,
      child: Container(
        padding: const EdgeInsets.all(
          AppSpacing.lg,
        ),
        decoration: BoxDecoration(
          color:
          theme.colorScheme.surfaceContainer,
          borderRadius:
          AppRadius.borderRadiusLg,
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            Text(
              'Budget Health',
              style: theme.textTheme.titleLarge
                  ?.copyWith(
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: AppSpacing.sm,
            ),

            Text(
              '$healthy / ${summaries.length} budgets are healthy',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(
                color: theme.colorScheme
                    .onSurfaceVariant,
              ),
            ),

            const SizedBox(
              height: AppSpacing.xl,
            ),

            _HealthTile(
              color: Colors.green,
              title: 'Healthy',
              count: healthy,
            ),

            const SizedBox(
              height: AppSpacing.md,
            ),

            _HealthTile(
              color: Colors.orange,
              title: 'Near Limit',
              count: nearLimit,
            ),

            const SizedBox(
              height: AppSpacing.md,
            ),

            _HealthTile(
              color: Colors.red,
              title: 'Exceeded',
              count: exceeded,
            ),
          ],
        ),
      ),
    );
  }
}

class _HealthTile extends StatelessWidget {
  final Color color;
  final String title;
  final int count;

  const _HealthTile({
    required this.color,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [

        CircleAvatar(
          radius: 7,
          backgroundColor:
          color.withValues(alpha: .15),
          child: CircleAvatar(
            radius: 3,
            backgroundColor: color,
          ),
        ),

        const SizedBox(
          width: AppSpacing.md,
        ),

        Expanded(
          child: Text(
            title,
            style: theme
                .textTheme
                .titleMedium,
          ),
        ),

        Text(
          '$count',
          style: theme.textTheme.titleLarge
              ?.copyWith(
            fontWeight:
            FontWeight.bold,
          ),
        ),
      ],
    );
  }
}