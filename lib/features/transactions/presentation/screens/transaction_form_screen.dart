import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/colors/app_gradients.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../models/transaction_form_args.dart';
import '../providers/transaction_provider.dart';
import '../widgets/transaction_form.dart';

class TransactionFormScreen extends ConsumerStatefulWidget {
  final TransactionFormArgs? args;

  const TransactionFormScreen({
    super.key,
    this.args,
  });

  @override
  ConsumerState<TransactionFormScreen> createState() =>
      _TransactionFormScreenState();
}

class _TransactionFormScreenState
    extends ConsumerState<TransactionFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _amountController;
  late final TextEditingController _notesController;

  late final FocusNode _amountFocus;
  late final FocusNode _notesFocus;

  @override
  void initState() {
    super.initState();

    _amountController = TextEditingController();
    _notesController = TextEditingController();

    _amountFocus = FocusNode();
    _notesFocus = FocusNode();

    final args = widget.args;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(addTransactionProvider).prepare(
        initialType: args?.initialType,
        accountId: args?.accountId,
        transaction: args?.transaction,
      );

      if (args?.transaction != null) {
        final transaction = args!.transaction!;

        _amountController.text =
            transaction.amount.toStringAsFixed(2);

        _notesController.text =
            transaction.note ?? '';
      }
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();

    _amountFocus.dispose();
    _notesFocus.dispose();

    super.dispose();
  }

  Future<void> _saveTransaction() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final notifier = ref.read(addTransactionProvider);

    if (notifier.selectedAccountId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an account.'),
        ),
      );
      return;
    }

    if (notifier.selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a category.'),
        ),
      );
      return;
    }

    final success = await notifier.saveOrUpdateTransaction(
      existingTransaction: widget.args?.transaction,
      amount: double.parse(
        _amountController.text.trim(),
      ),
      note: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    );

    if (!mounted) return;

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to save transaction.'),
        ),
      );
      return;
    }

    await ref.read(transactionProvider).loadTransactions();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          (widget.args?.isEditing ?? false)
              ? 'Transaction updated successfully.'
              : 'Transaction added successfully.',
        ),
      ),
    );

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? AppGradients.screenBackground
              : AppGradients.screenBackgroundLight,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,

          appBar: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,

            title: Text(
              (widget.args?.isEditing ?? false)
                  ? 'Edit Transaction'
                  : 'Add Transaction',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          body: SafeArea(
            child: SingleChildScrollView(
              padding: AppSpacing.screenPadding,
              child: TransactionForm(
                formKey: _formKey,
                amountController: _amountController,
                notesController: _notesController,
                amountFocus: _amountFocus,
                notesFocus: _notesFocus,
                onSave: _saveTransaction,
                isEditing: widget.args?.isEditing ?? false,
                accountLocked:
                widget.args?.lockAccount ?? false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}