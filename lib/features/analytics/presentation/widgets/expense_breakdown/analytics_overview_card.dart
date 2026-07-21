import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/features/constants/app_radius.dart';
import '../../../../../core/features/constants/app_spacing.dart';
import '../../../../../core/features/services/financial_insights_service_provider.dart';
import '../../../../../core/features/utils/currency_formatter.dart';
import '../../providers/analytics_provider.dart';

class AnalyticsOverviewCard extends ConsumerWidget {
  const AnalyticsOverviewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final service =
    ref.read(financialInsightsServiceProvider);

    final transactions =
        ref.watch(analyticsProvider).filteredTransactions;

    final income =
    service.getTotalIncome(transactions);

    final expense =
    service.getTotalExpense(transactions);

    final savings =
    service.getSavings(transactions);

    return Padding(
      padding: AppSpacing.screenPadding,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: AppRadius.borderRadiusXl,
          gradient: theme.brightness == Brightness.dark
              ? const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2C2B57),
              Color(0xFF1A1C3D),
              Color(0xFF101427),
            ],
          )
              : LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.surfaceContainer,
            ],
          ),
          border: Border.all(
            color: theme.brightness == Brightness.dark
                ? Colors.white.withValues(alpha: .08)
                : theme.colorScheme.outlineVariant
                .withValues(alpha: .30),
          ),
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            Text(
              'Overview',
              style: theme.textTheme.titleLarge
                  ?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            IntrinsicHeight(
              child: Row(
                children: [

                  Expanded(
                    child: _Metric(
                      title: 'Income',
                      value: CurrencyFormatter.format(income),
                      icon: Icons.arrow_downward_rounded,
                      color: Colors.green,
                    ),
                  ),

                  VerticalDivider(
                    color: theme.colorScheme.outlineVariant
                        .withValues(alpha: .80),
                  ),

                  Expanded(
                    child: _Metric(
                      title: 'Expenses',
                      value: CurrencyFormatter.format(expense),
                      icon: Icons.arrow_upward_rounded,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Divider(
              color: theme.colorScheme.outlineVariant
                  .withValues(alpha: .80),
            ),

            const SizedBox(height: 20),

            Text(
              'Savings',
              style: theme.textTheme.bodyMedium,
            ),

            const SizedBox(height: 8),

            Text(
              CurrencyFormatter.format(savings),
              style: theme.textTheme.headlineMedium
                  ?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF7C5CFF),
              ),
            ),

            const SizedBox(height: 8),

            Row(
              children: [

                Icon(
                  savings >= 0
                      ? Icons.trending_up_rounded
                      : Icons.trending_down_rounded,
                  size: 18,
                  color: savings >= 0
                      ? Colors.green
                      : Colors.red,
                ),

                const SizedBox(width: 6),

                Text(
                  savings >= 0
                      ? 'Positive Cash Flow'
                      : 'Negative Cash Flow',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _Metric({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [

        CircleAvatar(
          radius: 20,
          backgroundColor:
          color.withValues(alpha: .12),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          title,
          style: theme.textTheme.bodyMedium,
        ),

        const SizedBox(height: 6),

        FittedBox(
          child: Text(
            value,
            style: theme.textTheme.titleLarge
                ?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}