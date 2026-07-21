import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketiq/shared/components/states/pocket_empty_state.dart';

import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/services/financial_insights_service_provider.dart';
import '../../../core/features/constants/app_radius.dart';
import '../../transactions/presentation/providers/transaction_provider.dart';
import '../presentation/providers/analytics_provider.dart';
import 'financial_insight_tile.dart';

class FinancialInsights extends ConsumerWidget {
  const FinancialInsights({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final service =
    ref.read(financialInsightsServiceProvider);

    final transactions =
        ref.watch(analyticsProvider)
            .filteredTransactions;

    final insights =
    service.getInsights(transactions);

    return Padding(
      padding: AppSpacing.screenPadding,
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [

                  Icon(
                    Icons.auto_awesome_rounded,
                    size: 24,
                    color: theme.colorScheme.primary,
                  ),

                  const SizedBox(width: 10),

                  Text(
                    'Financial Insights',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.xs),

              Text(
                'Personalized recommendations based on your spending habits',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              if (insights.isEmpty)
                const PocketEmptyState(
                  icon: Icons.lightbulb_outline_rounded,
                  title: 'No Insights Yet',
                  description:
                  'Keep adding transactions to receive personalized financial insights.',
                )
              else
                ...insights.map(
                      (insight) => Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppSpacing.md,
                    ),
                    child: FinancialInsightTile(
                      insight: insight,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}