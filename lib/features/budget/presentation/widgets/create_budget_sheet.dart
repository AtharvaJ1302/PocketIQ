import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/features/constants/app_categories.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/services/local_notification_service.dart';
import '../../../../shared/components/buttons/pocket_button.dart';
import '../../../../shared/components/inputs/pocket_text_field.dart';
import '../../../setup/presentation/widgets/notification_permission_sheet.dart';
import '../../domain/models/budget.dart';
import '../providers/budget_provider.dart';

class CreateBudgetSheet extends ConsumerStatefulWidget {

  final Budget? budget;

  const CreateBudgetSheet({
    super.key,
    this.budget,
  });

  @override
  ConsumerState<CreateBudgetSheet> createState() =>
      _CreateBudgetSheetState();
}

class _CreateBudgetSheetState
    extends ConsumerState<CreateBudgetSheet> {

  @override
  void initState() {
    super.initState();

    if (widget.budget != null) {
      _selectedCategory =
          widget.budget!.category;

      _budgetController.text =
          widget.budget!.budgetAmount
              .toString();

      _notificationsEnabled =
          widget.budget!.notificationsEnabled;

      _threshold =
          widget.budget!
              .notificationThreshold
              .toDouble();
    }
  }

  Future<void> _saveBudget() async {
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select a category.',
          ),
        ),
      );
      return;
    }

    final amount = double.tryParse(
      _budgetController.text,
    );

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter a valid budget amount.',
          ),
        ),
      );
      return;
    }

    final now = DateTime.now();

    if (widget.budget == null) {

      final budget = Budget(
        category: _selectedCategory!,
        budgetAmount: amount,
        notificationsEnabled:
        _notificationsEnabled,
        notificationThreshold:
        _threshold.toInt(),
        lastNotificationThreshold: 0,
        createdAt: now,
        updatedAt: now,
      );

      await ref
          .read(budgetProvider)
          .saveBudget(
        budget,
      );

    } else {

      final updatedBudget = Budget(
        id: widget.budget!.id,
        category: widget.budget!.category,
        budgetAmount: amount,
        notificationsEnabled:
        _notificationsEnabled,
        notificationThreshold:
        _threshold.toInt(),
        lastNotificationThreshold:
        widget.budget!.budgetAmount != amount
            ? 0
            : widget.budget!.lastNotificationThreshold,
        createdAt:
        widget.budget!.createdAt,
        updatedAt: now,
      );

      await ref
          .read(budgetProvider)
          .updateBudget(
        updatedBudget,
      );
    }

    if (!mounted) return;

    _budgetController.clear();

    _selectedCategory = null;

    _notificationsEnabled = true;

    _threshold = 90;

    if (_notificationsEnabled) {
      final permissionGranted =
      await LocalNotificationService.instance
          .isPermissionGranted();

      if (!permissionGranted && mounted) {
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          builder: (_) =>
          const NotificationPermissionSheet(),
        );
      }
    }

    if (!mounted) return;

    Navigator.pop(context);
  }

  String? _selectedCategory;

  bool _notificationsEnabled = true;

  double _threshold = 90;

  final _budgetController =
  TextEditingController();

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final budgets = ref.watch(budgetProvider).budgets;

    final availableCategories =
    widget.budget == null
        ? AppCategories
        .budgetCategories()
        .where(
          (category) => !budgets.any(
            (budget) =>
        budget.category ==
            category.name,
      ),
    )
        .toList()
        : AppCategories
        .budgetCategories();

    final noCategoriesAvailable =
        availableCategories.isEmpty;

    final selectedCategory =
    availableCategories.any(
          (category) =>
      category.name == _selectedCategory,
    )
        ? _selectedCategory
        : null;

    return FractionallySizedBox(
      heightFactor: .82,
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom:
          MediaQuery.of(context)
              .viewInsets
              .bottom +
              20,
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            Text(
              widget.budget == null
                  ? 'Monthly Budget'
                  : 'Edit Budget',
              style: theme.textTheme.headlineSmall,
            ),

            const SizedBox(
              height: AppSpacing.sm,
            ),

            Text(
              widget.budget == null
                  ? 'Set spending limits for your categories.'
                  : 'Update your monthly budget settings.',
              style: theme.textTheme.bodyMedium,
            ),

            const SizedBox(
              height: AppSpacing.xl,
            ),

            Expanded(
              child: noCategoriesAvailable
                  ? Center(
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(
                    vertical:
                    AppSpacing.xxxl,
                  ),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [

                      Icon(
                        Icons
                            .check_circle_outline_rounded,
                        size: 72,
                        color: theme
                            .colorScheme
                            .primary,
                      ),

                      const SizedBox(
                        height:
                        AppSpacing.lg,
                      ),

                      Text(
                        'All Categories Added',
                        style: theme
                            .textTheme
                            .titleLarge,
                      ),

                      const SizedBox(
                        height:
                        AppSpacing.sm,
                      ),

                      Text(
                        'Every category already has a budget.\n'
                            'Edit or delete an existing budget to create another one.',
                        textAlign:
                        TextAlign.center,
                        style: theme
                            .textTheme
                            .bodyMedium,
                      ),
                    ],
                  ),
                ),
              )
                  : SingleChildScrollView(
                child: Column(
                  children: [

                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      decoration:
                      const InputDecoration(
                        labelText:
                        'Category',
                      ),
                      items:
                      availableCategories
                          .map(
                            (
                            category,
                            ) =>
                            DropdownMenuItem(
                              value:
                              category
                                  .name,
                              child: Text(
                                category
                                    .name,
                              ),
                            ),
                      )
                          .toList(),
                      onChanged: widget.budget != null
                          ? null
                          : (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),

                    const SizedBox(
                      height:
                      AppSpacing.lg,
                    ),

                    PocketTextField(
                      controller:
                      _budgetController,
                      label:
                      'Monthly Budget',
                      hint:
                      'Enter monthly budget',
                      keyboardType:
                      const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),

                    const SizedBox(
                      height:
                      AppSpacing.lg,
                    ),

                    SwitchListTile(
                      contentPadding:
                      EdgeInsets.zero,
                      title:
                      const Text(
                        'Budget Alerts',
                      ),
                      subtitle:
                      const Text(
                        'Receive notifications when your spending reaches the selected threshold.',
                      ),
                      value:
                      _notificationsEnabled,
                      onChanged:
                          (value) {
                        setState(() {
                          _notificationsEnabled =
                              value;
                        });
                      },
                    ),

                    if (_notificationsEnabled)
                      ...[
                        const SizedBox(
                          height:
                          AppSpacing
                              .md,
                        ),

                        Row(
                          children: [

                            const Text(
                              'Alert Threshold',
                            ),

                            const Spacer(),

                            Text(
                              '${_threshold.toInt()}%',
                              style: theme
                                  .textTheme
                                  .titleMedium,
                            ),
                          ],
                        ),

                        Slider(
                          value:
                          _threshold,
                          min: 50,
                          max: 100,
                          divisions: 10,
                          label:
                          '${_threshold.toInt()}%',
                          onChanged:
                              (value) {
                            setState(() {
                              _threshold =
                                  value;
                            });
                          },
                        ),
                      ],
                  ],
                ),
              ),
            ),

            if (!noCategoriesAvailable)
              PocketButton(
                label: widget.budget == null
                    ? 'Save Budget'
                    : 'Save Changes',
                onPressed: _saveBudget,
              ),

            const SizedBox(
              height: AppSpacing.md,
            ),
          ],
        ),
      ),
    );
  }
}