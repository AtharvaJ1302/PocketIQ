import 'package:flutter/material.dart';
import '../../../../app/theme/colors/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/finance/bank_info.dart';
import '../../../../core/finance/bank_styles.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../accounts/domain/models/account.dart';

class AccountCard extends StatelessWidget {
  final Account account;
  final VoidCallback? onTap;
  late final bankStyle = BankStyles.get(account.bankCode);

   AccountCard({
    super.key,
    required this.account,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: AppRadius.borderRadiusLg,
      onTap: onTap,
      child: Container(
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

                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.cardIcon,
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.lg),

            /// Account Name + Number
            Text(
              '${account.accountType} •••• ${account.lastFourDigits}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.cardSubtitle,
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            /// Balance
            Text(
              CurrencyFormatter.format(account.balance),
              style: theme.textTheme.titleLarge?.copyWith(
                color: AppColors.cardTitle,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Spacer(),

            /// Footer
            Row(
              children: [
                Icon(
                  Icons.sync,
                  size: 14,
                  color: Colors.green.shade400,
                ),

                const SizedBox(width: 4),

                Text(
                  'Synced',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}