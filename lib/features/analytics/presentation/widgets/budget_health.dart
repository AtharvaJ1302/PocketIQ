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

    final totalBudgets = summaries.length;

    final healthScore = totalBudgets == 0
        ? 0.0
        : healthy / totalBudgets;

    return Padding(
      padding: AppSpacing.screenPadding,
      child: Container(
        padding: const EdgeInsets.all(
          AppSpacing.lg,
        ),
        decoration: BoxDecoration(
          borderRadius: AppRadius.borderRadiusXl,
          color: theme.brightness == Brightness.dark
              ? const Color(0xFF1B1D38).withValues(alpha: .85)
              : theme.colorScheme.surface.withValues(alpha: .92),
          border: Border.all(
            color: theme.brightness == Brightness.dark
                ? const Color(0xFF6F63FF).withValues(alpha: .18)
                : theme.colorScheme.outlineVariant.withValues(alpha: .30),
          ),
          boxShadow: [
            BoxShadow(
              color: theme.brightness == Brightness.dark
                  ? const Color(0xFF7C5CFF).withValues(alpha: .08)
                  : Colors.black.withValues(alpha: .05),
              blurRadius: 24,
              spreadRadius: -6,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                Icon(
                  Icons.shield_outlined,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),

                const SizedBox(width: 10),

                Text(
                  'Budget Health',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.sm),

            Text(
              'Your monthly budget performance',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: LinearProgressIndicator(
                value: healthScore,
                minHeight: 10,
                backgroundColor:
                theme.colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation(
                  healthScore >= .80
                      ? Colors.green
                      : healthScore >= .50
                      ? Colors.orange
                      : Colors.red,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Center(
              child: Text(
                '${(healthScore * 100).round()}% Healthy',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

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

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withValues(alpha: .20),
        ),
      ),
      child: Row(
        children: [

          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: .35),
                  blurRadius: 8,
                ),
              ],
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleMedium,
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              '$count',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}