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

    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: 290,
      height: 195,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        borderRadius: AppRadius.borderRadiusLg,
        gradient: isDark
            ? const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF18233D),
            Color(0xFF121A2E),
          ],
        )
            : const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFDFDFF),
            Color(0xFFF4F6FB),
          ],
        ),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: .06)
              : Colors.black.withValues(alpha: .05),
        ),
        boxShadow: [
          // Natural card elevation
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: .18)
                : Colors.black.withValues(alpha: .06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),

          // Premium colored glow
          BoxShadow(
            color: bankStyle.color.withValues(
              alpha: isDark ? .18 : .12,
            ),
            blurRadius: 30,
            spreadRadius: -8,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          /// Card Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Header
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: bankStyle.color.withValues(alpha: .15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      bankStyle.icon,
                      size: 24,
                      color: bankStyle.color,
                    ),
                  ),

                  const SizedBox(width: AppSpacing.md),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          BankInfo.getName(account.bankCode),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 2),

                        Text(
                          account.accountName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: .55),
                          ),
                        ),
                      ],
                    ),
                  ),

                  InkWell(
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
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: theme.brightness == Brightness.dark
                            ? Colors.white.withValues(alpha: .06)
                            : Colors.black.withValues(alpha: .05),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.chevron_right_rounded,
                        size: 20,
                        color: theme.colorScheme.onSurface.withValues(alpha: .75),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Text(
                '${account.accountType} •••• ${account.lastFourDigits}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: .60),
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                _displayAmount(
                  hideBalance,
                  CurrencyFormatter.format(currentBalance),
                ),
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -.5,
                ),
              ),

              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}