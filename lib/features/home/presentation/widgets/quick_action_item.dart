import 'package:flutter/material.dart';

import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';

class QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final VoidCallback onPressed;

  const QuickActionItem({
    super.key,
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: InkWell(
        borderRadius: AppRadius.borderRadiusLg,
        onTap: onPressed,
        child: Ink(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.xl,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainer,
            borderRadius: AppRadius.borderRadiusLg,
            border: Border.all(
              color: Colors.white.withValues(alpha: .12),
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 34,
                color: iconColor,
              ),

              const SizedBox(height: AppSpacing.sm),

              Text(
                label,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}