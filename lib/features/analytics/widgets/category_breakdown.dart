import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/services/financial_insights_service_provider.dart';
import '../../../core/features/constants/app_chart_colors.dart';
import '../../../shared/components/states/pocket_empty_state.dart';
import '../../transactions/presentation/providers/transaction_provider.dart';
import 'category_tile.dart';

class CategoryBreakdown extends ConsumerWidget {
  const CategoryBreakdown({super.key});

  static const categoryColors = [
    Color(0xFF2563EB),
    Color(0xFF10B981),
    Color(0xFFF59E0B),
    Color(0xFFEF4444),
    Color(0xFF8B5CF6),
    Color(0xFF06B6D4),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service =
    ref.read(financialInsightsServiceProvider);

    final transactions =
        ref.watch(transactionProvider).transactions;

    final categories =
    service.getCategorySummary(transactions);

    if (categories.isEmpty) {
      return const Padding(
        padding: AppSpacing.screenPadding,
          child: PocketEmptyState(
            icon: Icons.pie_chart_outline_rounded,
            title: 'No Expense Data',
            description:
            'Add an expense transaction to view your spending categories.',
          )
      );
    }

    return Padding(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Text(
            'Top Spending Categories',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          ...List.generate(
            categories.length,
                (index) => CategoryTile(
              category: categories[index],
              gradient: AppChartColors.gradients[
              index %
                  AppChartColors.gradients.length
              ],
            ),
          ),
        ],
      ),
    );
  }
}