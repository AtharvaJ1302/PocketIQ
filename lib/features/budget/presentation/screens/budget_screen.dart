import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/services/deep_link_manager.dart';
import '../../../accounts/presentation/providers/account_provider.dart';
import '../../widgets/budget_list.dart';
import '../providers/budget_provider.dart';
import '../providers/budget_scroll_provider.dart';
import '../providers/highlight_budget_provider.dart';
import '../widgets/create_budget_sheet.dart';

class BudgetScreen extends ConsumerStatefulWidget {
  const BudgetScreen({super.key});

  @override
  ConsumerState<BudgetScreen> createState() =>
      _BudgetScreenState();
}

class _BudgetScreenState
    extends ConsumerState<BudgetScreen> {

  Future<void> _handleDeepLink() async {

    final payload =
    DeepLinkManager.instance
        .consumePendingPayload();

    if (payload == null) {
      return;
    }

    if (!payload.startsWith('budget/')) {
      return;
    }

    final category =
    payload.split('/')[1];

    await Future.delayed(
      const Duration(milliseconds: 150),
    );

    await BudgetScrollService.instance
        .scrollTo(category);

    if (!mounted) return;

    await ref
        .read(highlightBudgetProvider)
        .highlight(category);
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {

      await ref
          .read(budgetProvider)
          .loadBudgets();

      if (!mounted) return;

      WidgetsBinding.instance
          .addPostFrameCallback((_) {
        _handleDeepLink();
      });

    });
  }

  @override
  Widget build(BuildContext context) {

    final accountNotifier = ref.watch(accountProvider);

    final hasAccounts =
        accountNotifier.accounts.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget'),
      ),
      body: SafeArea(
        child: hasAccounts
            ? SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            MediaQuery.of(context).padding.bottom + 180,
          ),
          child: const BudgetList(),
        )
            : const _NoAccountBudgetState(),
      ),
      floatingActionButton: hasAccounts
          ? Padding(
        // Keeps the button above the floating navigation bar
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 88,
        ),
          child:Container(
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
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF7C5CFF).withValues(alpha: .35),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: FloatingActionButton.extended(
              elevation: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              onPressed: () async {
                await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (_) => const CreateBudgetSheet(),
                );

                if (!mounted) return;

                await ref.read(budgetProvider).loadBudgets();
              },
              icon: const Icon(Icons.add),
              label: const Text(
                'Add Budget',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
      )
          : null,
      );
  }
}

class _NoAccountBudgetState
    extends StatelessWidget {
  const _NoAccountBudgetState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: AppSpacing.screenPadding,
      child: Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [

            Icon(
              Icons.account_balance_wallet_outlined,
              size: 72,
              color: theme.colorScheme.primary,
            ),

            const SizedBox(
              height: AppSpacing.xl,
            ),

            Text(
              'Create Your First Account',
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),

            const SizedBox(
              height: AppSpacing.md,
            ),

            Text(
              'Budgets are linked to your accounts.\n\n'
                  'Create an account first, then start planning your monthly spending.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),

            const SizedBox(
              height: AppSpacing.xxxl,
            ),

            FilledButton.icon(
              onPressed: () {
                context.push(
                  AppRoutes.accounts,
                );
              },
              icon: const Icon(
                Icons.add,
              ),
              label: const Text(
                'Create Account',
              ),
            ),
          ],
        ),
      ),
    );
  }
}