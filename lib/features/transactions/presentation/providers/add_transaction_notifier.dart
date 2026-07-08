import 'package:flutter/material.dart';

import '../../domain/models/transaction.dart';
import '../../domain/models/transaction_type.dart';
import '../../domain/repositories/transaction_repository.dart';

class AddTransactionNotifier extends ChangeNotifier {
  final TransactionRepository _repository;

  AddTransactionNotifier(this._repository);

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
        await _repository.addTransaction(transaction);
      } else {
        await _repository.updateTransaction(transaction);
      }

      loading = false;
      notifyListeners();

      return true;
    } catch (_) {
      loading = false;
      notifyListeners();

      return false;
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