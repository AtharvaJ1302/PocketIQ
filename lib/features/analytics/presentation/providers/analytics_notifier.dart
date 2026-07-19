import 'package:flutter/material.dart';

import '../../../../core/features/services/financial_insights_service.dart';
import '../../../budget/domain/models/budget_summary.dart';
import '../../../transactions/domain/models/transaction.dart';
import '../../domain/models/analytics_filter.dart';
import '../../domain/models/category_summary.dart';
import '../../domain/models/financial_insight.dart';
import '../../domain/models/monthly_summary.dart';

class AnalyticsNotifier extends ChangeNotifier {
  AnalyticsNotifier();

  final FinancialInsightsService _service =
  const FinancialInsightsService();

  AnalyticsFilter _filter =
      AnalyticsFilter.thisMonth;

  AnalyticsFilter get filter => _filter;

  List<Transaction> _allTransactions = [];

  void setTransactions(
      List<Transaction> transactions,
      ) {
    _allTransactions = transactions;
    notifyListeners();
  }

  void changeFilter(
      AnalyticsFilter filter,
      ) {
    if (_filter == filter) return;

    _filter = filter;
    notifyListeners();
  }

  List<Transaction> get filteredTransactions =>
      _service.filterTransactions(
        _allTransactions,
        _filter,
      );

  double get totalIncome =>
      _service.getTotalIncome(
        filteredTransactions,
      );

  double get totalExpense =>
      _service.getTotalExpense(
        filteredTransactions,
      );

  double get savings =>
      _service.getSavings(
        filteredTransactions,
      );

  List<CategorySummary> get categorySummary =>
      _service.getCategorySummary(
        filteredTransactions,
      );

  List<MonthlySummary> get monthlySummary =>
      _service.getMonthlySummary(
        filteredTransactions,
      );

  List<FinancialInsight> get insights =>
      _service.getInsights(
        filteredTransactions,
      );

  List<BudgetSummary> getBudgetSummaries({
    required List budgets,
  }) {
    return _service.getBudgetSummaries(
      budgets: budgets.cast(),
      transactions: filteredTransactions,
    );
  }

  FinancialInsight? get heroInsight =>
      _service.getHeroInsight(
        filteredTransactions,
      );
}