import 'package:flutter/material.dart';

import '../../../core/features/constants/app_spacing.dart';

class PocketEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const PocketEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.xxxl,
        horizontal: AppSpacing.xl,
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 64,
            color: theme.colorScheme.primary.withValues(
              alpha: .70,
            ),
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: AppSpacing.sm,
          ),

          Text(
            description,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}