import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_spacing.dart';

class AccountEmptyState extends StatelessWidget {
  const AccountEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.xl,
      ),
      child: Column(
        children: [
          Icon(
            Icons.account_balance_outlined,
            size: 52,
            color: theme.colorScheme.primary.withValues(alpha: .7),
          ),

          const SizedBox(height: AppSpacing.md),

          Text(
            'No accounts yet',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          Text(
            'Tap the Account action above to add your first account.',
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