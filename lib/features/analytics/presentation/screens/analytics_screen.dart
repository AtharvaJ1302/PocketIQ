import 'package:flutter/material.dart';
import 'package:pocketiq/features/analytics/presentation/widgets/cash_flow/cash_flow_card.dart';

import '../../../../app/theme/colors/app_gradients.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../widgets/financial_insights.dart';
import '../../widgets/monthly_trend.dart';
import '../widgets/analytics_header.dart';
import '../widgets/budget_health.dart';
import '../widgets/expense_breakdown/analytics_overview_card.dart';
import '../widgets/expense_breakdown/expense_breakdown_card.dart';
import '../widgets/summary_cards.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: Theme.of(context).brightness == Brightness.dark
              ? AppGradients.screenBackground
              : AppGradients.screenBackgroundLight,
        ),
        child: const SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(height: 20),

                AnalyticsHeader(),

                SizedBox(height: 24),

                AnalyticsOverviewCard(),

                SizedBox(height: AppSpacing.section),

                BudgetHealth(),

                SizedBox(height: AppSpacing.section),

                ExpenseBreakdownCard(),

                SizedBox(height: AppSpacing.section),

                CashFlowCard(),

                SizedBox(height: AppSpacing.section),

                FinancialInsights(),

                SizedBox(height: AppSpacing.section),
              ],
            ),
          ),
        ),
      ),
    );
  }
}