import '../../../analytics/domain/models/category_summary.dart';
import '../../../transactions/domain/models/transaction.dart';

class StatementData {
  final double income;
  final double expense;
  final double savings;

  final List<Transaction> transactions;

  final List<CategorySummary> categories;

  const StatementData({
    required this.income,
    required this.expense,
    required this.savings,
    required this.transactions,
    required this.categories,
  });
}