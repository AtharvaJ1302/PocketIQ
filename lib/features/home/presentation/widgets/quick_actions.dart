import 'package:flutter/material.dart';

import '../../../../app/theme/colors/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/components/sections/section_header.dart';
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
                onPressed: () {},
              ),

              const SizedBox(width: AppSpacing.md),

              QuickActionItem(
                icon: Icons.add_circle_outline,
                label: 'Income',
                iconColor: AppColors.income,
                onPressed: () {},
              ),

              const SizedBox(width: AppSpacing.md),

              QuickActionItem(
                icon: Icons.account_balance_outlined,
                label: 'Account',
                iconColor: AppColors.account,
                onPressed: () {},
              ),

              const SizedBox(width: AppSpacing.md),

              QuickActionItem(
                icon: Icons.pie_chart_outline,
                label: 'Budget',
                iconColor: AppColors.budget,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}