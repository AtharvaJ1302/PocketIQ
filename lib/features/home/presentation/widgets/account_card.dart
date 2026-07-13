import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/colors/app_colors.dart';
import '../../../../core/features/constants/app_radius.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/finance/bank_info.dart';
import '../../../../core/features/finance/bank_styles.dart';
import '../../../../core/features/services/account_balance_service_provider.dart';
import '../../../../core/features/utils/currency_formatter.dart';
import '../../../accounts/domain/models/account.dart';
import '../../../setup/presentation/providers/preferences_provider.dart';
import '../../../transactions/presentation/models/transactions_filter.dart';
import '../../../transactions/presentation/models/transactions_screen_args.dart';
import '../../../transactions/presentation/providers/transaction_provider.dart';

class AccountCard extends ConsumerWidget {
  final Account account;

  const AccountCard({
    super.key,
    required this.account,
  });

  String _displayAmount(
      bool hidden,
      String amount,
      ) {
    return hidden
        ? '••••••'
        : amount;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final preferences =
        ref.watch(preferencesProvider).preferences;

    final hideBalance =
        preferences.hideBalance;

    final bankStyle = BankStyles.get(account.bankCode);

    final transactions =
        ref.watch(transactionProvider).transactions;

    final balanceService =
    ref.read(accountBalanceServiceProvider);

    final currentBalance =
    balanceService.getCurrentBalance(
      account: account,
      transactions: transactions,
    );

    return Container(
      width: 260,
      height: 205,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2438),
        borderRadius: AppRadius.borderRadiusLg,
        border: Border.all(
          color: Colors.white.withValues(alpha: .06),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: bankStyle.color.withValues(alpha: .15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  bankStyle.icon,
                  size: 22,
                  color: bankStyle.color,
                ),
              ),

              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: Text(
                  BankInfo.getName(
                    account.bankCode,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.cardTitle,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              InkResponse(
                radius: 22,
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  context.push(
                    AppRoutes.transactions,
                    extra: TransactionsScreenArgs(
                      screenTitle: account.accountName,
                      filter: TransactionsFilter(
                        accountId: account.id,
                      ),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.cardIcon,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          Text(
            '${account.accountType} •••• ${account.lastFourDigits}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.cardSubtitle,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          Text(
            _displayAmount(
              hideBalance,
              CurrencyFormatter.format(
                currentBalance,
              ),
            ),
            style: theme.textTheme.titleLarge?.copyWith(
              color: AppColors.cardTitle,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),

          Row(
            children: [
              Icon(
                Icons.sync,
                size: 14,
                color: Colors.green,
              ),

              const SizedBox(width: 4),

              Text(
                'Synced',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}