import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/colors/app_colors.dart';
import '../../../../core/features/constants/app_spacing.dart';
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

  final bool accountLocked;

  const TransactionForm({
    super.key,
    required this.formKey,
    required this.amountController,
    required this.notesController,
    required this.amountFocus,
    required this.notesFocus,
    required this.onSave,
    required this.isEditing,
    this.accountLocked = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(addTransactionProvider);

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// Date
          DatePickerTile(
            date: notifier.selectedDate,
            onTap: () {
              notifier.pickDate(context);
            },
          ),

          const SizedBox(height: 40),

          /// Amount
          Center(
            child: AmountField(
              controller: amountController,
              focusNode: amountFocus,
              onFieldSubmitted: (_) {
                notesFocus.requestFocus();
              },
            ),
          ),

          const SizedBox(height: 40),

          /// Account
          const _SectionTitle("Account"),

          const SizedBox(height: 12),

          AccountDropdown(
            value: notifier.selectedAccountId,
            onChanged: notifier.setAccount,
            enabled: !accountLocked,
          ),

          const SizedBox(height: 28),

          /// Transaction Type
          const _SectionTitle("Transaction Type"),

          const SizedBox(height: 12),

          TransactionTypeToggle(
            selectedType: notifier.selectedType,
            onChanged: notifier.setType,
          ),

          const SizedBox(height: 28),

          /// Category
          const _SectionTitle("Category"),

          const SizedBox(height: 12),

          CategoryDropdown(
            type: notifier.selectedType,
            value: notifier.selectedCategory,
            onChanged: notifier.setCategory,
          ),

          const SizedBox(height: 28),

          /// Notes
          NotesField(
            controller: notesController,
          ),

          const SizedBox(height: 40),

          PocketButton(
            label: isEditing
                ? "Update Transaction"
                : notifier.selectedType.isExpense
                ? "Save Expense"
                : "Save Income",
            loading: notifier.loading,
            icon: isEditing
                ? Icons.edit_rounded
                : notifier.selectedType.isExpense
                ? Icons.arrow_upward_rounded
                : Icons.arrow_downward_rounded,
            onPressed: onSave,
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: .2,
      ),
    );
  }
}