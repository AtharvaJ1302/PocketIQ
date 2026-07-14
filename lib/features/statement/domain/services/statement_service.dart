import '../../../../core/features/services/financial_insights_service.dart';
import '../../../analytics/domain/models/category_summary.dart';
import '../../../transactions/domain/models/transaction.dart';
import '../models/statement_data.dart';

class StatementService {
  final FinancialInsightsService
  _insightsService;

  const StatementService(
      this._insightsService);

  StatementData build({
    required List<Transaction>
    transactions,
  }) {
    return StatementData(
      income:
      _insightsService
          .getTotalIncome(
        transactions,
      ),
      expense:
      _insightsService
          .getTotalExpense(
        transactions,
      ),
      savings:
      _insightsService
          .getSavings(
        transactions,
      ),
      transactions:
      transactions,
      categories:
      _insightsService
          .getCategorySummary(
        transactions,
      ),
    );
  }
}