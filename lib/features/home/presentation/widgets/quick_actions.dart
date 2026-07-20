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
          title: 'Quick Actions',
        ),

        const SizedBox(height: 5),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: QuickActionItem(
                  icon: Icons.add_rounded,
                  title: "Add",
                  subtitle: "Income",
                  iconColor: const Color(0xFFE74C3C),
                  onPressed: () {
                    context.push(
                      AppRoutes.addTransaction,
                      extra: const TransactionFormArgs(
                        initialType: TransactionType.income,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(width: 6),

              Expanded(
                child: QuickActionItem(
                  icon: Icons.add_rounded,
                  title: "Add",
                  subtitle: "Expense",
                  iconColor: const Color(0xFF22C55E),
                  onPressed: () {
                    context.push(
                      AppRoutes.addTransaction,
                      extra: const TransactionFormArgs(
                        initialType: TransactionType.expense,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(width: 6),

              Expanded(
                child: QuickActionItem(
                  icon: Icons.account_balance_rounded,
                  title: "Accounts",
                  subtitle: "Manage",
                  iconColor: const Color(0xFF3B82F6),
                  onPressed: () {
                    context.push(AppRoutes.accounts);
                  },
                ),
              ),

              const SizedBox(width: 6),

              Expanded(
                child: QuickActionItem(
                  icon: Icons.bar_chart_rounded,
                  title: "Statement",
                  subtitle: "Reports",
                  iconColor: const Color(0xFF8B5CF6),
                  onPressed: () {
                    context.push(AppRoutes.statement);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}