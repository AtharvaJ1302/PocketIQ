import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/services/deep_link_manager.dart';
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
    DeepLinkManager.instance.consumePendingPayload();

    if (payload == null) {
      return;
    }

    if (!payload.startsWith('budget/')) {
      return;
    }

    final category = payload.split('/')[1];

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

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleDeepLink();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget'),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: BudgetList(),
        ),
      ),
      floatingActionButton:
      FloatingActionButton.extended(
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (_) =>
            const CreateBudgetSheet(),
          );

          if (!mounted) return;

          await ref
              .read(budgetProvider)
              .loadBudgets();
        },
        icon: const Icon(Icons.add),
        label: const Text(
          'Add Budget',
        ),
      ),
    );
  }
}