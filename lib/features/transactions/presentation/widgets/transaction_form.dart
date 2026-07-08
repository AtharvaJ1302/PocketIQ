import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/components/buttons/pocket_button.dart';
import '../../../../shared/layouts/form_section.dart';
import '../providers/transaction_provider.dart';
import 'account_dropdown.dart';
import 'amount_field.dart';
import 'category_dropdown.dart';
import 'date_picker_tile.dart';
import 'notes_field.dart';
import 'transaction_type_toggle.dart';

class TransactionForm extends ConsumerWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController amountController;
  final TextEditingController notesController;

  final FocusNode amountFocus;
  final FocusNode notesFocus;

  final VoidCallback onSave;

  final bool isEditing;

  const TransactionForm({
    super.key,
    required this.formKey,
    required this.amountController,
    required this.notesController,
    required this.amountFocus,
    required this.notesFocus,
    required this.onSave,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(addTransactionProvider);

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TransactionTypeToggle(
            selectedType: notifier.selectedType,
            onChanged: notifier.setType,
          ),

          const SizedBox(height: AppSpacing.xl),

          FormSection(
            title: 'Transaction Information',
            children: [
              AmountField(
                controller: amountController,
                focusNode: amountFocus,
                onFieldSubmitted: (_) {
                  notesFocus.requestFocus();
                },
              ),

              const SizedBox(height: AppSpacing.lg),

              AccountDropdown(
                value: notifier.selectedAccountId,
                onChanged: notifier.setAccount,
              ),

              const SizedBox(height: AppSpacing.lg),

              CategoryDropdown(
                type: notifier.selectedType,
                value: notifier.selectedCategory,
                onChanged: notifier.setCategory,
              ),

              const SizedBox(height: AppSpacing.lg),

              DatePickerTile(
                date: notifier.selectedDate,
                onTap: () {
                  notifier.pickDate(context);
                },
              ),

              const SizedBox(height: AppSpacing.lg),

              NotesField(
                controller: notesController,
                focusNode: notesFocus,
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.xxxl),

          PocketButton(
            label: isEditing
                ? 'Update Transaction'
                : notifier.selectedType.isExpense
                ? 'Add Expense'
                : 'Add Income',
            loading: notifier.loading,
            onPressed: onSave,
          ),
        ],
      ),
    );
  }
}