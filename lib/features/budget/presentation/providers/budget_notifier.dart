import 'package:flutter/foundation.dart';

import '../../domain/models/budget.dart';
import '../../domain/repositories/budget_repository.dart';

class BudgetNotifier
    extends ChangeNotifier {

  final BudgetRepository _repository;

  BudgetNotifier(
      this._repository,
      );

  List<Budget> _budgets = [];

  List<Budget> get budgets =>
      _budgets;

  Future<void> loadBudgets() async {
    _budgets =
    await _repository.getBudgets();

    notifyListeners();
  }

  Future<void> saveBudget(
      Budget budget,
      ) async {
    await _repository.saveBudget(
      budget,
    );
  }

  Future<void> updateBudget(
      Budget budget,
      ) async {
    await _repository.updateBudget(
      budget,
    );
  }

  Future<void> deleteBudget(
      int id,
      ) async {
    await _repository.deleteBudget(
      id,
    );
  }

  Future<void> clearBudgets() async {
    await _repository.clearBudgets();

    await loadBudgets();
  }
}