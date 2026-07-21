import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/finance/bank_info.dart';
import '../../../../core/features/services/account_balance_service_provider.dart';
import '../../../../core/features/utils/currency_formatter.dart';
import '../../../../shared/dialogs/confirm_delete_dialog.dart';
import '../../../transactions/presentation/providers/transaction_provider.dart';
import '../../domain/models/account.dart';

class AccountListCard extends ConsumerWidget {
  final Account account;
  final VoidCallback onDelete;

  const AccountListCard({
    super.key,
    required this.account,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final accent = _accentColor(account.bankCode);
    final transactions =
        ref.watch(transactionProvider).transactions;

    final balanceService =
    ref.read(accountBalanceServiceProvider);

    final currentBalance =
    balanceService.getCurrentBalance(
      account: account,
      transactions: transactions,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: () {
          context.push(
            AppRoutes.addAccount,
            extra: account,
          );
        },
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
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            // borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.04),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 5,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(28),
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            color: accent.withOpacity(.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.account_balance_rounded,
                            color: accent,
                            size: 30,
                          ),
                        ),

                        const SizedBox(width: 18),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                BankInfo.getName(account.bankCode),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                '•••• ${account.lastFourDigits}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 16),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              CurrencyFormatter.format(currentBalance),
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              account.accountType,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: accent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(width: 12),

                        Icon(
                          Icons.chevron_right_rounded,
                          color: theme.colorScheme.outline,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _accentColor(String bankCode) {
    switch (bankCode) {
      case 'SBI':
        return Colors.blue;

      case 'HDFC':
        return Colors.red;

      case 'ICICI':
        return const Color(0xFFFF6F00);

      case 'AXIS':
        return Colors.purple;

      case 'KOTAK':
        return Colors.deepPurple;

      case 'PNB':
        return Colors.orange;

      case 'BOB':
        return Colors.indigo;

      case 'CANARA':
        return Colors.green;

      case 'UNION':
        return Colors.teal;

      case 'IDFC':
        return Colors.cyan;

      default:
        return const Color(0xff6D5BFF);
    }
  }
}