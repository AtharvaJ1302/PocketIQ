import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_spacing.dart';

class SettingsSwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsSwitchTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary
                  .withValues(alpha: .10),
              borderRadius:
              BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: theme.colorScheme.primary,
            ),
          ),

          const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleMedium,
            ),
          ),

          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}