import 'package:flutter/foundation.dart';

import '../../../../core/features/services/budget_alert_service.dart';
import '../../domain/models/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';

class TransactionNotifier extends ChangeNotifier {
  final TransactionRepository _repository;

  final BudgetAlertService _budgetAlertService;

  TransactionNotifier(
      this._repository,
      this._budgetAlertService,
      );

  bool loading = false;

  List<Transaction> transactions = [];

  Future<void> loadTransactions() async {
    loading = true;
    notifyListeners();

    transactions =
    await _repository.getTransactions();

    loading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    await loadTransactions();
  }

  Future<void> checkBudgetAlerts() async {
    await _budgetAlertService.checkBudgetAlerts(
      transactions,
    );
  }
}