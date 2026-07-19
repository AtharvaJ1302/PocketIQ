import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/features/constants/app_assets.dart';
import '../../../../core/features/constants/app_radius.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/services/account_balance_service_provider.dart';
import '../../../../core/features/utils/currency_formatter.dart';
import '../../../accounts/presentation/providers/account_provider.dart';
import '../../../analytics/presentation/providers/analytics_provider.dart';
import '../../../setup/presentation/providers/preferences_provider.dart';
import '../../../transactions/presentation/providers/transaction_provider.dart';

class BalanceCard extends ConsumerWidget {
  const BalanceCard({super.key});

  String _displayAmount(
      bool hidden,
      String amount,
      ) {
    return hidden ? '••••••' : amount;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final preferences =
        ref.watch(preferencesProvider).preferences;

    final hideBalance = preferences.hideBalance;

    final accountNotifier =
    ref.watch(accountProvider);

    final transactionNotifier =
    ref.watch(transactionProvider);

    final analytics =
    ref.watch(analyticsProvider);

    final balanceService =
    ref.read(accountBalanceServiceProvider);

    final totalBalance =
    balanceService.getOverallBalance(
      accounts: accountNotifier.accounts,
      transactions: transactionNotifier.transactions,
    );

    final totalIncome =
    transactionNotifier.transactions
        .where((t) => t.isIncome)
        .fold<double>(
      0,
          (sum, t) => sum + t.amount,
    );

    final totalExpense =
    transactionNotifier.transactions
        .where((t) => t.isExpense)
        .fold<double>(
      0,
          (sum, t) => sum + t.amount,
    );

    final insight =
    analytics.insights.isNotEmpty
        ? analytics.insights.first
        : null;

    return Padding(
        padding: AppSpacing.screenPadding,
        child: SizedBox(
          height: 290,
          child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        28,
        AppSpacing.xl,
        28,
      ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF7C3AED),
                Color(0xFF5B4CFF),
                Color(0xFF0D1B5E),
              ],
            ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7C3AED)
                  .withValues(alpha: .35),
              blurRadius: 40,
              spreadRadius: -8,
              offset: const Offset(0, 18),
            ),
          ],
        ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                /// Purple glow
                Positioned(
                  right: -40,
                  top: -40,
                  child: Container(
                    width: 260,
                    height: 260,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const RadialGradient(
                        colors: [
                          Color(0x60D7B8FF),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                /// Wallet
                Positioned(
                  top: -10,
                  right: -120,
                  child: Image.asset(
                    AppAssets.walletIllustration,
                    width: 300,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(
                  width: MediaQuery.of(context).size.width * .70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// Header
                      Row(
                        children: [

                          Text(
                            "Total Balance",
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white70,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(width: 8),

                          InkWell(
                            onTap: () async {
                              await ref
                                  .read(preferencesProvider)
                                  .toggleHideBalance();
                            },
                            child: Icon(
                              hideBalance
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Text(
                        _displayAmount(
                          hideBalance,
                          CurrencyFormatter.format(totalBalance),
                        ),
                        style: theme.textTheme.displayLarge?.copyWith(
                          fontSize: 42,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          height: 1,
                          letterSpacing: -1,
                        ),
                      ),

                      const SizedBox(height: 12),

                      if (insight != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: .15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              Icon(
                                insight.icon,
                                size: 16,
                                color: const Color(0xFF4ADE80),
                              ),

                              const SizedBox(width: 6),

                              Flexible(
                                child: Text(
                                  insight.title,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: const Color(0xFF4ADE80),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      const Spacer(),

                      Row(
                        children: [

                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: .06),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: .05),
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: _InfoTile(
                                title: "Income",
                                value: _displayAmount(
                                  hideBalance,
                                  CurrencyFormatter.format(totalIncome),
                                ),
                                icon: Icons.south_west_rounded,
                              ),
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: .06),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: .05),
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: _InfoTile(
                                title: "Expense",
                                value: _displayAmount(
                                  hideBalance,
                                  CurrencyFormatter.format(totalExpense),
                                ),
                                icon: Icons.north_east_rounded,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
      ),
        ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _InfoTile({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: title == "Income"
                ? const Color(0xFF22C55E).withValues(alpha: .18)
                : const Color(0xFFEF4444).withValues(alpha: .18),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 18,
            color: title == "Income"
                ? const Color(0xFF22C55E)
                : const Color(0xFFEF4444),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: .70),
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                value,
                maxLines: 1,
                overflow:
                TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}