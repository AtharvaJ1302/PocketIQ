import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/colors/app_colors.dart';
import '../../../../app/theme/colors/app_gradients.dart';
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
        heightFactor: .88,
        child: Container(
          decoration: BoxDecoration(
            gradient: Theme.of(context).brightness == Brightness.dark
                ? AppGradients.screenBackground
                : AppGradients.screenBackgroundLight,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(32),
            ),
          ),
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

            Column(
              children: [

                Center(
                  child: Container(
                    width: 56,
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: .7),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: .12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_rounded,
                    color: AppColors.primary,
                    size: 34,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  widget.budget == null
                      ? 'Monthly Budget'
                      : 'Edit Budget',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  widget.budget == null
                      ? 'Set spending limits for your categories.'
                      : 'Update your monthly budget settings.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
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

                    Text(
                      'Category',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 10),

                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      decoration: InputDecoration(
                        hintText: 'Select category',
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.folder_rounded,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: theme.colorScheme.outlineVariant,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: theme.colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 18,
                        ),
                      ),
                      items: availableCategories
                          .map(
                            (category) => DropdownMenuItem(
                          value: category.name,
                          child: Text(category.name),
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

                    const SizedBox(height: AppSpacing.xl),

                    Text(
                      'Set your monthly spending limit',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 10),

                    PocketTextField(
                      controller: _budgetController,
                      hint: 'Enter amount',
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),

                    const SizedBox(
                      height:
                      AppSpacing.lg,
                    ),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.brightness == Brightness.dark
                        ? theme.colorScheme.surfaceContainerHighest
                        : Colors.white.withValues(alpha: .85),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: theme.colorScheme.outlineVariant.withValues(alpha: .25),
                    ),
                  ),
                  child: Column(
                    children: [

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withValues(alpha: .12),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.notifications_active_rounded,
                              color: theme.colorScheme.primary,
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  'Budget Alerts',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  'Receive notifications when your spending reaches the selected threshold.',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Switch(
                            value: _notificationsEnabled,
                            onChanged: (value) {
                              setState(() {
                                _notificationsEnabled = value;
                              });
                            },
                          ),
                        ],
                      ),

                      if (_notificationsEnabled) ...[

                        const SizedBox(height: 20),

                        Divider(
                          color: theme.colorScheme.outlineVariant,
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [

                            Text(
                              'Alert Threshold',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const Spacer(),

                            Text(
                              '${_threshold.toInt()}%',
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        Slider(
                          value: _threshold,
                          min: 50,
                          max: 100,
                          divisions: 10,
                          label: '${_threshold.toInt()}%',
                          onChanged: (value) {
                            setState(() {
                              _threshold = value;
                            });
                          },
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [

                              Text(
                                '50%',
                                style: theme.textTheme.bodySmall,
                              ),

                              Text(
                                '75%',
                                style: theme.textTheme.bodySmall,
                              ),

                              Text(
                                '100%',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                      ],
                ),
              ),
                    const SizedBox(height:
                    AppSpacing.xxxl),
                ],
            ),
              ),
            ),
            if (!noCategoriesAvailable)
              PocketButton(
                icon: Icons.save_outlined,
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
        ),
    );
  }
}