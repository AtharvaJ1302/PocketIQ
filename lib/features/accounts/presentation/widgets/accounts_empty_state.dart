import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';

class AccountsEmptyState extends StatelessWidget {
  final VoidCallback onAddAccount;

  const AccountsEmptyState({
    super.key,
    required this.onAddAccount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_balance_wallet_outlined,
              size: 72,
              color: theme.colorScheme.primary,
            ),

            const SizedBox(height: AppSpacing.lg),

            Text(
              'No Accounts Yet',
              style: theme.textTheme.headlineSmall,
            ),

            const SizedBox(height: AppSpacing.sm),

            Text(
              'Add your first account to start tracking your finances.',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.xl),

            FilledButton.icon(
              onPressed: onAddAccount,
              icon: const Icon(Icons.add),
              label: const Text('Add Account'),
            ),
          ],
        ),
      ),
    );
  }
}