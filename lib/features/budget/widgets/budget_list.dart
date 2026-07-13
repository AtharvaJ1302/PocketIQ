import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/services/financial_insights_service_provider.dart';
import '../../../../shared/components/states/pocket_empty_state.dart';
import '../../transactions/presentation/providers/transaction_provider.dart';
import '../presentation/providers/budget_provider.dart';
import '../presentation/widgets/overall_budget_card.dart';
import 'budget_tile.dart';

class BudgetList extends ConsumerWidget {
  const BudgetList({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final budgetNotifier =
    ref.watch(budgetProvider);

    final transactionNotifier =
    ref.watch(transactionProvider);

    final service = ref.read(
      financialInsightsServiceProvider,
    );

    final budgets =
        budgetNotifier.budgets;

    if (budgets.isEmpty) {
      return const PocketEmptyState(
        icon: Icons.savings_outlined,
        title: 'No Budgets Yet',
        description:
        'Create your first monthly budget to start tracking your spending.',
      );
    }

    final summaries =
    service.getBudgetSummaries(
      budgets: budgets,
      transactions:
      transactionNotifier.transactions,
    );

    final totalBudget =
    service.getTotalBudget(
      budgets,
    );

    final spent =
    service.getTotalSpent(
      summaries,
    );

    final remaining =
    service.getRemainingBudget(
      summaries,
    );

    final progress =
    service.getOverallBudgetProgress(
      summaries,
    );

    return Column(
      children: [

        OverallBudgetCard(
          totalBudget: totalBudget,
          spent: spent,
          remaining: remaining,
          progress: progress,
        ),

        const SizedBox(
          height: AppSpacing.xl,
        ),

        ...summaries.map(
              (summary) => Padding(
            padding:
            const EdgeInsets.only(
              bottom: AppSpacing.lg,
            ),
            child: BudgetTile(
              summary: summary,
            ),
          ),
        ),
      ],
    );
  }
}