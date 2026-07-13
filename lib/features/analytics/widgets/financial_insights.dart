import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketiq/shared/components/states/pocket_empty_state.dart';

import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/services/financial_insights_service_provider.dart';
import '../../transactions/presentation/providers/transaction_provider.dart';
import 'financial_insight_tile.dart';

class FinancialInsights extends ConsumerWidget {
  const FinancialInsights({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final service =
    ref.read(financialInsightsServiceProvider);

    final transactions =
        ref.watch(transactionProvider).transactions;

    final insights =
    service.getInsights(transactions);

    return Padding(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Text(
            'Financial Insights',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          if (insights.isEmpty)

            const PocketEmptyState(
              icon: Icons.lightbulb_outline_rounded,
              title: 'No Insights Yet',
              description:
              'Keep adding transactions to receive personalized financial insights.',
            )

          else

            ...insights.map(
                  (insight) =>
                  FinancialInsightTile(
                    insight: insight,
                  ),
            ),
        ],
      ),
    );
  }
}