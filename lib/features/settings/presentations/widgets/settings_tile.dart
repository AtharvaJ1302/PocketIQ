import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_radius.dart';
import '../../../../core/features/constants/app_spacing.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;

  final String title;

  /// Value displayed on the right
  final String? value;

  final VoidCallback? onTap;

  /// If false, no ripple, no chevron, no tap
  final bool enabled;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.value,
    this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: AppRadius.borderRadiusMd,
      onTap: enabled ? onTap : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary
                    .withValues(alpha: .10),
                borderRadius: BorderRadius.circular(12),
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

            if (value != null)
              Text(
                value!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),

            if (enabled) ...[
              const SizedBox(width: AppSpacing.sm),

              Icon(
                Icons.chevron_right_rounded,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ],
        ),
      ),
    );
  }
}