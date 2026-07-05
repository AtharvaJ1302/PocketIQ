import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_spacing.dart';
import '../providers/transaction_provider.dart';
import '../widgets/transaction_form.dart';

class AddTransactionScreen extends ConsumerStatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  ConsumerState<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState
    extends ConsumerState<AddTransactionScreen> {
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

    final success = await notifier.saveTransaction(
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

    notifier.reset();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Transaction added successfully.'),
      ),
    );

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Transaction'),
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
            ),
          ),
        ),
      ),
    );
  }
}