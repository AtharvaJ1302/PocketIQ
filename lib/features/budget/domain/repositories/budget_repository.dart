import '../models/budget.dart';

abstract class BudgetRepository {

  Future<List<Budget>> getBudgets();

  Future<void> saveBudget(
      Budget budget,
      );

  Future<void> updateBudget(
      Budget budget,
      );

  Future<void> deleteBudget(
      int id,
      );

  Future<void> clearBudgets();
}