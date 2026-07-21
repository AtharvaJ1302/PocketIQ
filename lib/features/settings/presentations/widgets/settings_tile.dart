import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_radius.dart';
import '../../../../core/features/constants/app_spacing.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? value;
  final VoidCallback? onTap;
  final bool enabled;
  final Color? accentColor;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.value,
    this.onTap,
    this.enabled = true,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final accent = accentColor ?? theme.colorScheme.primary;

    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: AppRadius.borderRadiusLg,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                icon,
                color: accent,
                size: 28,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  if (subtitle != null) ...[
                    const SizedBox(height: 4),

                    Text(
                      subtitle!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            if (value != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  value!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            if (enabled)
              Icon(
                Icons.chevron_right_rounded,
                size: 24,
                color: theme.colorScheme.outline,
              ),
          ],
        ),
      ),
    );
  }
}