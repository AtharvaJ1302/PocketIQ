import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/colors/app_colors.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../shared/components/sections/section_header.dart';
import '../../../transactions/domain/models/transaction_type.dart';
import '../../../transactions/presentation/models/transaction_form_args.dart';
import 'quick_action_item.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(
          title: 'Actions',
        ),

        const SizedBox(height: AppSpacing.md),

        Padding(
          padding: AppSpacing.screenPadding,
          child: Row(
            children: [
              QuickActionItem(
                icon: Icons.remove_circle_outline,
                label: 'Expense',
                iconColor: AppColors.expense,
                onPressed: () {
                  context.push(
                    AppRoutes.addTransaction,
                    extra: const TransactionFormArgs(
                      initialType: TransactionType.expense,
                    ),
                  );
                },
              ),

              const SizedBox(width: AppSpacing.md),

              QuickActionItem(
                icon: Icons.add_circle_outline,
                label: 'Income',
                iconColor: AppColors.income,
                onPressed: () {
                  context.push(
                    AppRoutes.addTransaction,
                    extra: const TransactionFormArgs(
                      initialType: TransactionType.income,
                    ),
                  );
                },
              ),

              const SizedBox(width: AppSpacing.md),

              QuickActionItem(
                icon: Icons.account_balance_outlined,
                label: 'Account',
                iconColor: AppColors.account,
                onPressed: () {
                  context.push(
                    AppRoutes.accounts,
                  );
                },
              ),

              const SizedBox(width: AppSpacing.md),

              QuickActionItem(
                icon: Icons.picture_as_pdf_outlined,
                label: 'Statement',
                iconColor: AppColors.statement,
                onPressed: () {
                  context.push(
                    AppRoutes.statement,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}