import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/features/constants/app_radius.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/finance/bank_info.dart';
import '../../../../core/features/utils/currency_formatter.dart';
import '../../../../shared/dialogs/confirm_delete_dialog.dart';
import '../../domain/models/account.dart';

class AccountListCard extends StatelessWidget {
  final Account account;
  final VoidCallback onDelete;

  const AccountListCard({
    super.key,
    required this.account,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.borderRadiusLg,
      ),
      child: InkWell(
        borderRadius: AppRadius.borderRadiusLg,

        /// Tap = Edit Account
        onTap: () {
          context.push(
            AppRoutes.addAccount,
            extra: account,
          );
        },

        /// Long Press = Delete Account
        onLongPress: () {
          showDialog(
            context: context,
            builder: (_) => ConfirmDeleteDialog(
              title: 'Delete Account',
              message:
              'Are you sure you want to delete "${account.accountName}"?',
              onDelete: onDelete,
            ),
          );
        },

        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 24,
                child: Icon(
                  Icons.account_balance_outlined,
                ),
              ),

              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      BankInfo.getName(account.bankCode),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      account.accountName,
                      style: theme.textTheme.bodyLarge,
                    ),

                    const SizedBox(height: 2),

                    Text(
                      '${account.accountType} •••• ${account.lastFourDigits}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),

              Text(
                CurrencyFormatter.format(account.openingBalance),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}