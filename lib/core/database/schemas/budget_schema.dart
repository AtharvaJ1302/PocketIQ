import '../database_constants.dart';

class BudgetSchema {
  BudgetSchema._();

  static const createTable = '''
  CREATE TABLE ${DatabaseTables.budgets}(
    ${BudgetColumns.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${BudgetColumns.category} TEXT NOT NULL UNIQUE,
    ${BudgetColumns.budgetAmount} REAL NOT NULL,
    ${BudgetColumns.notificationsEnabled} INTEGER NOT NULL,
    ${BudgetColumns.notificationThreshold} INTEGER NOT NULL,
    ${BudgetColumns.lastNotificationThreshold} INTEGER NOT NULL,
    ${BudgetColumns.createdAt} TEXT NOT NULL,
    ${BudgetColumns.updatedAt} TEXT NOT NULL
  )
  ''';
}