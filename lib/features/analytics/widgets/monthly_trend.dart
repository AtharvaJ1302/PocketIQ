import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/services/financial_insights_service_provider.dart';
import '../../../shared/components/states/pocket_empty_state.dart';
import '../../transactions/presentation/providers/transaction_provider.dart';
import 'monthly_summary_tile.dart';

class MonthlyTrend extends ConsumerWidget {
  const MonthlyTrend({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final transactions =
        ref.watch(transactionProvider).transactions;

    final service =
    ref.read(financialInsightsServiceProvider);

    final summaries =
    service.getMonthlySummary(transactions);

    return Padding(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Text(
            'Monthly Trend',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          if (summaries.isEmpty)

            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 32,
                ),
                child: PocketEmptyState(
                  icon: Icons.show_chart_rounded,
                  title: 'No Monthly Trend',
                  description:
                  'Track your finances over multiple months to unlock trends.',
                )
              ),
            )

          else

            ...summaries.map(
                  (summary) =>
                  MonthlySummaryTile(
                    summary: summary,
                  ),
            ),
        ],
      ),
    );
  }
}