import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_radius.dart';
import '../../../../core/features/constants/app_spacing.dart';

class SettingsSwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? accentColor;

  const SettingsSwitchTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final accent = accentColor ?? Colors.green;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: .12),
              borderRadius: AppRadius.borderRadiusMd,
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

          Transform.scale(
            scale: 0.92,
            child: Switch(
              value: value,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}