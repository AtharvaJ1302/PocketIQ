import 'package:pocketiq/features/statement/domain/models/statement_period.dart';

import '../../../analytics/domain/models/category_summary.dart';
import '../../../budget/domain/models/budget_summary.dart';
import '../../../transactions/domain/models/transaction.dart';

class StatementData {
  final StatementSummary summary;

  final List<Transaction> transactions;

  final List<CategorySummary> categories;

  final List<BudgetSummary> budgets;

  final List<Transaction> notedTransactions;

  final StatementPeriod period;

  const StatementData({
    required this.summary,
    required this.transactions,
    required this.categories,
    required this.budgets,
    required this.notedTransactions,
    required this.period,
  });
}

class StatementSummary {
  final double income;

  final double expense;

  final double savings;

  const StatementSummary({
    required this.income,
    required this.expense,
    required this.savings,
  });
}