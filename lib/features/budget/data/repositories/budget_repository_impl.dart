import 'package:sqflite/sqflite.dart';

import '../../../../core/database/database_constants.dart';
import '../../../../core/database/database_service.dart';
import '../../domain/models/budget.dart';
import '../../domain/repositories/budget_repository.dart';

class BudgetRepositoryImpl
    implements BudgetRepository {

  final DatabaseService _databaseService;

  BudgetRepositoryImpl(
      this._databaseService,
      );

  @override
  Future<List<Budget>> getBudgets() async {
    final db =
    await _databaseService.database;

    final result = await db.query(
      DatabaseTables.budgets,
      orderBy:
      '${BudgetColumns.category} ASC',
    );

    return result
        .map(Budget.fromMap)
        .toList();
  }

  @override
  Future<void> saveBudget(
      Budget budget,
      ) async {
    final db =
    await _databaseService.database;

    await db.insert(
      DatabaseTables.budgets,
      budget.toMap(),
      conflictAlgorithm:
      ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateBudget(
      Budget budget,
      ) async {
    final db =
    await _databaseService.database;

    await db.update(
      DatabaseTables.budgets,
      budget.toMap(),
      where:
      '${BudgetColumns.id} = ?',
      whereArgs: [budget.id],
    );
  }

  @override
  Future<void> deleteBudget(
      int id,
      ) async {
    final db =
    await _databaseService.database;

    await db.delete(
      DatabaseTables.budgets,
      where:
      '${BudgetColumns.id} = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> clearBudgets() async {
    final db =
    await _databaseService.database;

    await db.delete(
      DatabaseTables.budgets,
    );
  }
}