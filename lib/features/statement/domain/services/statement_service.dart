import '../../../../core/features/services/financial_insights_service.dart';
import '../../../budget/domain/models/budget.dart';
import '../../../budget/domain/models/budget_summary.dart';
import '../../../transactions/domain/models/transaction.dart';
import '../models/statement_data.dart';
import '../models/statement_options.dart';
import '../models/statement_period.dart';

class StatementService {
  final FinancialInsightsService _insightsService;

  const StatementService(
      this._insightsService,
      );

  StatementData build({
    required List<Transaction> transactions,
    required List<Budget> budgets,
    required StatementOptions options,
  }) {
    final filtered = _filterTransactions(
      transactions: transactions,
      period: options.period,
    );

    return StatementData(
      period: options.period,

      summary: StatementSummary(
        income: _insightsService.getTotalIncome(
          filtered,
        ),
        expense: _insightsService.getTotalExpense(
          filtered,
        ),
        savings: _insightsService.getSavings(
          filtered,
        ),
      ),

      transactions: filtered,

      categories: options.includeCategories
          ? _insightsService.getCategorySummary(
        filtered,
      )
          : const [],

      budgets: options.includeBudgetSummary
          ? _insightsService.getBudgetSummaries(
        budgets: budgets,
        transactions: filtered,
      )
          : const [],

      notedTransactions: options.includeNotes
          ? filtered
          .where(
            (transaction) =>
        transaction.note != null &&
            transaction.note!.trim().isNotEmpty,
      )
          .toList()
          : const [],
    );
  }

  List<Transaction> _filterTransactions({
    required List<Transaction> transactions,
    required StatementPeriod period,
  }) {
    final now = DateTime.now();

    switch (period) {
      case StatementPeriod.thisMonth:
        return transactions.where((transaction) {
          return transaction.date.month == now.month &&
              transaction.date.year == now.year;
        }).toList();

      case StatementPeriod.lastMonth:
        final previous =
        DateTime(now.year, now.month - 1);

        return transactions.where((transaction) {
          return transaction.date.month ==
              previous.month &&
              transaction.date.year ==
                  previous.year;
        }).toList();

      case StatementPeriod.last3Months:
        final cutoff =
        DateTime(now.year, now.month - 2);

        return transactions.where((transaction) {
          return transaction.date.isAfter(cutoff) ||
              transaction.date.isAtSameMomentAs(
                cutoff,
              );
        }).toList();

      case StatementPeriod.thisYear:
        return transactions.where((transaction) {
          return transaction.date.year ==
              now.year;
        }).toList();

      // case StatementPeriod.custom:
      //   return transactions;
    }
  }
}