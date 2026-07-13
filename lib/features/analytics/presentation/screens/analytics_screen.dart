import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_spacing.dart';
import '../../widgets/category_breakdown.dart';
import '../../widgets/financial_insights.dart';
import '../../widgets/monthly_trend.dart';
import '../widgets/analytics_header.dart';
import '../widgets/summary_cards.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),

              AnalyticsHeader(),

              SizedBox(height: 24),

              SummaryCards(),

              const SizedBox(
                height: AppSpacing.section,
              ),

              CategoryBreakdown(),

              const SizedBox(
                height: AppSpacing.section,
              ),

              MonthlyTrend(),

              const SizedBox(
                height: AppSpacing.section,
              ),

              FinancialInsights(),

              const SizedBox(
                height: AppSpacing.section,
              ),
            ],
          ),
        ),
      ),
    );
  }
}