import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/features/constants/app_spacing.dart';
import '../../widgets/budget_list.dart';
import '../providers/budget_provider.dart';
import '../widgets/create_budget_sheet.dart';

class BudgetScreen extends ConsumerStatefulWidget {
  const BudgetScreen({super.key});

  @override
  ConsumerState<BudgetScreen> createState() =>
      _BudgetScreenState();
}

class _BudgetScreenState
    extends ConsumerState<BudgetScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(budgetProvider)
          .loadBudgets();
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