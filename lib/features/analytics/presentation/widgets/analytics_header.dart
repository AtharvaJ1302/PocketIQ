import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/features/constants/app_spacing.dart';
import '../../domain/models/analytics_filter.dart';
import '../providers/analytics_provider.dart';

class AnalyticsHeader extends ConsumerWidget {
  const AnalyticsHeader({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final theme = Theme.of(context);

    final notifier =
    ref.watch(analyticsProvider);

    return Padding(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Text(
            'Analytics',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: AppSpacing.xs,
          ),

          Text(
            'Track your spending trends',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          Align(
            alignment: Alignment.centerRight,
            child: PopupMenuButton<AnalyticsFilter>(
              initialValue: notifier.filter,

              onSelected: notifier.changeFilter,

              itemBuilder: (_) => const [

                PopupMenuItem(
                  value: AnalyticsFilter.thisMonth,
                  child: Text('This Month'),
                ),

                PopupMenuItem(
                  value: AnalyticsFilter.lastMonth,
                  child: Text('Last Month'),
                ),

                PopupMenuItem(
                  value: AnalyticsFilter.last3Months,
                  child: Text('Last 3 Months'),
                ),

                PopupMenuItem(
                  value: AnalyticsFilter.thisYear,
                  child: Text('This Year'),
                ),
              ],

              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Icon(
                      Icons.calendar_month_rounded,
                      size: 18,
                      color: theme.colorScheme.primary,
                    ),

                    const SizedBox(
                      width: 8,
                    ),

                    Text(
                      _labelForFilter(
                        notifier.filter,
                      ),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.primary,
                      ),
                    ),

                    const SizedBox(
                      width: 4,
                    ),

                    Icon(
                      Icons.expand_more_rounded,
                      size: 18,
                      color: theme.colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _labelForFilter(
      AnalyticsFilter filter,
      ) {
    switch (filter) {
      case AnalyticsFilter.thisMonth:
        return 'This Month';

      case AnalyticsFilter.lastMonth:
        return 'Last Month';

      case AnalyticsFilter.last3Months:
        return 'Last 3 Months';

      case AnalyticsFilter.thisYear:
        return 'This Year';
    }
  }
}