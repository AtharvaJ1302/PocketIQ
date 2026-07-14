import 'package:flutter/material.dart';

import '../../../../../core/features/constants/app_radius.dart';
import '../../../../../core/features/constants/app_spacing.dart';

class StatTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;

  const StatTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius:
        AppRadius.borderRadiusMd,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Icon(
            icon,
            size: 20,
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          Text(
            title,
            style:
            theme.textTheme.bodySmall,
          ),

          const SizedBox(
            height: 2,
          ),

          Text(
            value,
            maxLines: 1,
            overflow:
            TextOverflow.ellipsis,
            style: theme
                .textTheme
                .titleMedium
                ?.copyWith(
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 2,
          ),

          Text(
            subtitle,
            maxLines: 1,
            overflow:
            TextOverflow.ellipsis,
            style:
            theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}