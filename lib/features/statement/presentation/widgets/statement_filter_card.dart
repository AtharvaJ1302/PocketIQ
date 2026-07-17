import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(
          AppSpacing.lg,
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            Text(
              'Statement Period',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: AppSpacing.lg,
            ),

            DropdownButtonFormField<StatementPeriod>(
              value: options.period,

              decoration: const InputDecoration(
                labelText: 'Period',
              ),

              items: const [

                DropdownMenuItem(
                  value: StatementPeriod.thisMonth,
                  child: Text(
                    'This Month',
                  ),
                ),

                DropdownMenuItem(
                  value: StatementPeriod.lastMonth,
                  child: Text(
                    'Last Month',
                  ),
                ),

                DropdownMenuItem(
                  value: StatementPeriod.last3Months,
                  child: Text(
                    'Last 3 Months',
                  ),
                ),

                DropdownMenuItem(
                  value: StatementPeriod.thisYear,
                  child: Text(
                    'This Year',
                  ),
                ),

                // DropdownMenuItem(
                //   value: StatementPeriod.custom,
                //   enabled: false,
                //   child: Text(
                //     'Custom Range',
                //     overflow: TextOverflow.ellipsis,
                //   ),
                // ),
              ],

              onChanged: (value) {
                if (value == null) {
                  return;
                }

                notifier.changePeriod(
                  value,
                );
              },
            ),

            const SizedBox(
              height: AppSpacing.lg,
            ),

            // ListTile(
            //   contentPadding: EdgeInsets.zero,
            //   leading: const Icon(
            //     Icons.date_range_rounded,
            //   ),
            //   title: const Text(
            //     'Custom Date Range',
            //   ),
            //   subtitle: Text(
            //     'Available in a future update',
            //     style: theme.textTheme.bodySmall,
            //   ),
            //   trailing: const Icon(
            //     Icons.lock_outline_rounded,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}