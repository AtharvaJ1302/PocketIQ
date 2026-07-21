import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_radius.dart';
import '../../../../core/features/utils/currency_formatter.dart';
import '../../../../shared/components/indicators/pocket_progress_bar.dart';

class OverallBudgetCard extends StatelessWidget {
  final double totalBudget;
  final double spent;
  final double remaining;
  final double progress;

  const OverallBudgetCard({
    super.key,
    required this.totalBudget,
    required this.spent,
    required this.remaining,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: AppRadius.borderRadiusXl,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: theme.brightness == Brightness.dark
              ? const [
            Color(0xFF2A2850),
            Color(0xFF1D2142),
          ]
              : [
            theme.colorScheme.surface,
            theme.colorScheme.surfaceContainer,
          ],
        ),
        border: Border.all(
          color: theme.brightness == Brightness.dark
              ? Colors.white.withValues(alpha: 0.06)
              : theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                      value: progress.clamp(0, 1),
                      strokeWidth: 10,
                      backgroundColor: theme.colorScheme.outlineVariant
                          .withValues(alpha: .25),
                      valueColor: const AlwaysStoppedAnimation(
                        Color(0xff7C5CFF),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${(progress * 100).toStringAsFixed(0)}%',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'of budget\nused',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 24),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Monthly Budget',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  'Track your spending this month',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 18),

                _Metric(
                  title: 'Budget',
                  value: CurrencyFormatter.format(totalBudget),
                  color: const Color(0xff7C5CFF),
                ),

                const SizedBox(height: 14),

                _Metric(
                  title: 'Spent',
                  value: CurrencyFormatter.format(spent),
                  color: const Color(0xffFF8A34),
                ),

                const SizedBox(height: 14),

                _Metric(
                  title: remaining < 0 ? 'Exceeded' : 'Remaining',
                  value: CurrencyFormatter.format(
                    remaining.abs(),
                  ),
                  color: remaining < 0
                      ? Colors.red
                      : const Color(0xff38D67A),
                ),
              ],
            ),
          ),
        ],
      ),

          const SizedBox(height: 28),

          PocketProgressBar(
            progress: progress,
          ),

          const SizedBox(height: 12),

          Text(
            '${(progress * 100).toStringAsFixed(0)}% of ${CurrencyFormatter.format(totalBudget)} used',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _Metric({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}