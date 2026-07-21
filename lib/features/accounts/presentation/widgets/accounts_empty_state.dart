import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_spacing.dart';


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

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF7C5CFF),
                    Color(0xFF5B4DFF),
                  ],
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: onAddAccount,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Add Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}