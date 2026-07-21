import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/features/constants/app_radius.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../domain/models/statement_period.dart';
import '../providers/statement_provider.dart';

class StatementFilterCard extends ConsumerWidget {
  const StatementFilterCard({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final theme = Theme.of(context);

    final notifier =
    ref.watch(statementProvider);

    final options =
        notifier.options;

    return Container(
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
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: .08),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(
                    Icons.calendar_month_rounded,
                    color: theme.colorScheme.primary,
                    size: 32,
                  ),
                ),

                const SizedBox(width: AppSpacing.lg),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      Text(
                        'Statement Period',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        'Select the time period for your statement',
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(
                          color: theme.colorScheme
                              .onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.xl),

            DropdownButtonFormField<StatementPeriod>(
              value: options.period,

              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.calendar_today_rounded,
                ),
                labelText: 'Period',
              ),

              items: const [

                DropdownMenuItem(
                  value: StatementPeriod.thisMonth,
                  child: Text('This Month'),
                ),

                DropdownMenuItem(
                  value: StatementPeriod.lastMonth,
                  child: Text('Last Month'),
                ),

                DropdownMenuItem(
                  value: StatementPeriod.last3Months,
                  child: Text('Last 3 Months'),
                ),

                DropdownMenuItem(
                  value: StatementPeriod.thisYear,
                  child: Text('This Year'),
                ),
              ],

              onChanged: (value) {
                if (value != null) {
                  notifier.changePeriod(value);
                }
              },
            ),

            const SizedBox(height: AppSpacing.lg),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(
                  alpha: .05,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [

                  Icon(
                    Icons.date_range_rounded,
                    size: 18,
                    color: theme.colorScheme.primary,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      _periodDescription(options.period),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _periodDescription(
    StatementPeriod period,
    ) {
  switch (period) {
    case StatementPeriod.thisMonth:
      return "Current month's transactions";

    case StatementPeriod.lastMonth:
      return "Previous month's transactions";

    case StatementPeriod.last3Months:
      return "Last 3 months of activity";

    case StatementPeriod.thisYear:
      return "Current year's transactions";
  }
}