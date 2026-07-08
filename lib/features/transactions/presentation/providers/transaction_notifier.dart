import 'package:flutter/foundation.dart';

import '../../domain/models/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';

class TransactionNotifier extends ChangeNotifier {
  final TransactionRepository _repository;

  TransactionNotifier(this._repository);

  bool loading = false;

  List<Transaction> transactions = [];

  Future<void> loadTransactions() async {
    loading = true;
    notifyListeners();

    transactions = await _repository.getTransactions();

    loading = false;
    notifyListeners();
  }

  // Future<void> deleteTransaction(String id) async {
  //   loading = true;
  //   notifyListeners();
  //
  //   await _repository.deleteTransaction(id);
  //
  //   await loadTransactions();
  //
  //   loading = false;
  //   notifyListeners();
  // }

  Future<void> refresh() async {
    await loadTransactions();
  }

  Future<void> deleteTransaction(String id) async {
    loading = true;
    notifyListeners();

    await _repository.deleteTransaction(id);

    transactions = await _repository.getTransactions();

    loading = false;
    notifyListeners();
  }
}