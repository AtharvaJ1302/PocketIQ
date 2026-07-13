import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_radius.dart';
import '../../../../core/features/constants/app_spacing.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;
  final Color color;

  const SummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius:
        AppRadius.borderRadiusLg,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor:
            color.withValues(alpha: .15),
            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(
            width: AppSpacing.md,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                  theme.textTheme.bodyMedium,
                ),

                const SizedBox(height: 4),

                Text(
                  amount,
                  style: theme
                      .textTheme.titleLarge
                      ?.copyWith(
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}