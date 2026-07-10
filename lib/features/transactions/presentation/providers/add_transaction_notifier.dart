import 'package:flutter/material.dart';

import '../../domain/models/transaction.dart';
import '../../domain/models/transaction_type.dart';
import '../../domain/repositories/transaction_repository.dart';

class AddTransactionNotifier extends ChangeNotifier {
  final TransactionRepository _transactionRepository;

  AddTransactionNotifier(
      this._transactionRepository,
      );

  bool loading = false;

  TransactionType selectedType = TransactionType.expense;

  String? selectedAccountId;

  String? selectedCategory;

  DateTime selectedDate = DateTime.now();

  void setType(TransactionType type) {
    selectedType = type;
    selectedCategory = null;
    notifyListeners();
  }

  void setAccount(String? value) {
    selectedAccountId = value;
    notifyListeners();
  }

  void setCategory(String? value) {
    selectedCategory = value;
    notifyListeners();
  }

  Future<void> prepare({
    TransactionType? initialType,
    String? accountId,
    Transaction? transaction,
  }) async {
    // Always start from a clean state.
    selectedType = TransactionType.expense;
    selectedAccountId = null;
    selectedCategory = null;
    selectedDate = DateTime.now();
    loading = false;

    if (initialType != null) {
      selectedType = initialType;
    }

    if (accountId != null) {
      selectedAccountId = accountId;
    }

    if (transaction != null) {
      selectedType = transaction.type;
      selectedAccountId = transaction.accountId;
      selectedCategory = transaction.category;
      selectedDate = transaction.date;
    }

    notifyListeners();
  }

  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );

    if (picked == null) return;

    selectedDate = picked;

    notifyListeners();
  }

  Future<bool> saveOrUpdateTransaction({
    Transaction? existingTransaction,
    required double amount,
    required String? note,
  }) async {
    loading = true;
    notifyListeners();

    try {
      final transaction = Transaction(
        id: existingTransaction?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        accountId: selectedAccountId!,
        category: selectedCategory!,
        amount: amount,
        type: selectedType,
        note: note,
        date: selectedDate,
      );

      if (existingTransaction == null) {
        await _transactionRepository.addTransaction(transaction);
      } else {
        await _transactionRepository.updateTransaction(transaction);
      }

      return true;
    } catch (_) {
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void reset() {
    selectedType = TransactionType.expense;
    selectedAccountId = null;
    selectedCategory = null;
    selectedDate = DateTime.now();
    loading = false;

    notifyListeners();
  }

  void loadTransaction(Transaction transaction) {
    selectedType = transaction.type;
    selectedAccountId = transaction.accountId;
    selectedCategory = transaction.category;
    selectedDate = transaction.date;

    notifyListeners();
  }
}