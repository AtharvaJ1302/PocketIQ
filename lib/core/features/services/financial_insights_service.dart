import 'package:flutter/material.dart';

import '../../../features/analytics/domain/models/analytics_filter.dart';
import '../../../features/analytics/domain/models/cash_flow_data.dart';
import '../../../features/analytics/domain/models/category_summary.dart';
import '../../../features/analytics/domain/models/financial_insight.dart';
import '../../../features/analytics/domain/models/financial_snapshot_item.dart';
import '../../../features/analytics/domain/models/monthly_summary.dart';
import '../../../features/budget/domain/models/budget.dart';
import '../../../features/budget/domain/models/budget_summary.dart';
import '../../../features/transactions/domain/models/transaction.dart';

class FinancialInsightsService {
  const FinancialInsightsService();

  double getTotalIncome(
      List<Transaction> transactions,
      ) {
    return transactions
        .where((t) => t.isIncome)
        .fold(
      0.0,
          (sum, t) => sum + t.amount,
    );
  }

  double getTotalExpense(
      List<Transaction> transactions,
      ) {
    return transactions
        .where((t) => t.isExpense)
        .fold(
      0.0,
          (sum, t) => sum + t.amount,
    );
  }

  double getSavings(
      List<Transaction> transactions,
      ) {
    return getTotalIncome(transactions) -
        getTotalExpense(transactions);
  }

  Map<String, double> getCategoryTotals(
      List<Transaction> transactions,
      ) {
    final Map<String, double> totals = {};

    for (final transaction in transactions) {
      if (transaction.isIncome) {
        continue;
      }

      totals.update(
        transaction.category,
            (value) => value + transaction.amount,
        ifAbsent: () => transaction.amount,
      );
    }

    return totals;
  }

  List<CategorySummary> getCategorySummary(
      List<Transaction> transactions,
      ) {
    final Map<String, double> totals = {};

    double totalExpenses = 0;

    for (final transaction in transactions) {
      if (transaction.isIncome) continue;

      totalExpenses += transaction.amount;

      totals.update(
        transaction.category,
            (value) => value + transaction.amount,
        ifAbsent: () => transaction.amount,
      );
    }

    final summaries = totals.entries
        .map(
          (entry) => CategorySummary(
        category: entry.key,
        amount: entry.value,
        percentage: totalExpenses == 0
            ? 0
            : entry.value / totalExpenses,
      ),
    )
        .toList();

    summaries.sort(
          (a, b) => b.amount.compareTo(a.amount),
    );

    return summaries;
  }

  List<MonthlySummary> getMonthlySummary(
      List<Transaction> transactions,
      ) {
    final Map<String, MonthlySummary> data = {};

    for (final transaction in transactions) {
      final key =
          '${transaction.date.year}-${transaction.date.month}';

      final current = data[key];

      if (current == null) {
        data[key] = MonthlySummary(
          year: transaction.date.year,
          month: transaction.date.month,
          income: transaction.isIncome
              ? transaction.amount
              : 0,
          expense: transaction.isExpense
              ? transaction.amount
              : 0,
        );

        continue;
      }

      data[key] = MonthlySummary(
        year: current.year,
        month: current.month,
        income: current.income +
            (transaction.isIncome
                ? transaction.amount
                : 0),
        expense: current.expense +
            (transaction.isExpense
                ? transaction.amount
                : 0),
      );
    }

    final result = data.values.toList();

    result.sort(
          (a, b) {
        final left = DateTime(a.year, a.month);
        final right = DateTime(b.year, b.month);

        return right.compareTo(left);
      },
    );

// Show only the latest 6 months on Analytics.
    return result.take(6).toList();
  }

  List<FinancialInsight> getInsights(
      List<Transaction> transactions,
      ) {
    if (transactions.isEmpty) {
      return [];
    }

    final insights = <FinancialInsight>[];

    final income = getTotalIncome(transactions);
    final expense = getTotalExpense(transactions);

    if (income > 0) {
      final savingsRate =
          ((income - expense) / income) * 100;

      insights.add(
        FinancialInsight(
          icon: Icons.savings_rounded,
          title: 'Savings Rate',
          description:
          'You are saving ${savingsRate.toStringAsFixed(0)}% of your income.',
        ),
      );
    }

    final categories =
    getCategorySummary(transactions);

    if (categories.isNotEmpty) {
      final top = categories.first;

      insights.add(
        FinancialInsight(
          icon: Icons.pie_chart_rounded,
          title: 'Top Spending Category',
          description:
          '${top.category} accounts for ${(top.percentage * 100).toStringAsFixed(0)}% of your expenses.',
        ),
      );
    }

    final expenses = transactions
        .where((t) => t.isExpense)
        .toList();

    if (expenses.isNotEmpty) {
      expenses.sort(
            (a, b) =>
            b.amount.compareTo(a.amount),
      );

      insights.add(
        FinancialInsight(
          icon: Icons.trending_down_rounded,
          title: 'Largest Expense',
          description:
          '${expenses.first.category} • ₹${expenses.first.amount.toStringAsFixed(0)}',
        ),
      );
    }

    return insights;
  }

  List<BudgetSummary> getBudgetSummaries({
    required List<Budget> budgets,
    required List<Transaction> transactions,
  }) {
    final summaries = <BudgetSummary>[];

    for (final budget in budgets) {
      final spent = transactions
          .where(
            (transaction) =>
        transaction.isExpense &&
            transaction.category ==
                budget.category,
      )
          .fold<double>(
        0,
            (sum, transaction) =>
        sum + transaction.amount,
      );

      summaries.add(
        BudgetSummary(
          budget: budget,
          spent: spent,
        ),
      );
    }

    return summaries;
  }

  double getTotalBudget(
      List<Budget> budgets,
      ) {
    return budgets.fold(
      0,
          (sum, budget) =>
      sum + budget.budgetAmount,
    );
  }

  double getTotalSpent(
      List<BudgetSummary> summaries,
      ) {
    return summaries.fold(
      0,
          (sum, summary) =>
      sum + summary.spent,
    );
  }

  double getRemainingBudget(
      List<BudgetSummary> summaries,
      ) {
    final totalBudget = getTotalBudget(
      summaries.map((e) => e.budget).toList(),
    );

    final spent = getTotalSpent(
      summaries,
    );

    final remaining = totalBudget - spent;

    return remaining > 0 ? remaining : 0;
  }

  double getOverallBudgetProgress(
      List<BudgetSummary> summaries,
      ) {
    final totalBudget = summaries.fold<double>(
      0,
          (sum, summary) =>
      sum + summary.budget.budgetAmount,
    );

    final spent = summaries.fold<double>(
      0,
          (sum, summary) =>
      sum + summary.spent,
    );

    if (totalBudget == 0) {
      return 0;
    }

    return (spent / totalBudget)
        .clamp(0.0, 1.0);
  }

  List<BudgetSummary> getNearLimitBudgets(
      List<BudgetSummary> summaries,
      ) {
    return summaries
        .where(
          (summary) =>
      summary.percentage >= 80,
    )
        .toList()
      ..sort(
            (a, b) => b.percentage.compareTo(
          a.percentage,
        ),
      );
  }

  List<Transaction> filterTransactions(
      List<Transaction> transactions,
      AnalyticsFilter filter,
      ) {
    final now = DateTime.now();

    switch (filter) {
      case AnalyticsFilter.thisMonth:
        return transactions.where(
              (transaction) =>
          transaction.date.month == now.month &&
              transaction.date.year == now.year,
        ).toList();

      case AnalyticsFilter.lastMonth:
        final previousMonth =
        DateTime(now.year, now.month - 1);

        return transactions.where(
              (transaction) =>
          transaction.date.month ==
              previousMonth.month &&
              transaction.date.year ==
                  previousMonth.year,
        ).toList();

      case AnalyticsFilter.last3Months:
        final start =
        DateTime(now.year, now.month - 2, 1);

        return transactions.where(
              (transaction) =>
          transaction.date.isAfter(
            start.subtract(
              const Duration(days: 1),
            ),
          ) &&
              transaction.date.isBefore(
                DateTime(
                  now.year,
                  now.month + 1,
                  1,
                ),
              ),
        ).toList();

      case AnalyticsFilter.thisYear:
        return transactions.where(
              (transaction) =>
          transaction.date.year ==
              now.year,
        ).toList();
    }
  }

  List<CashFlowData> getCashFlowData(
      List<Transaction> transactions,
      ) {
    final Map<String, CashFlowData> data = {};

    for (final transaction in transactions) {
      final key =
          '${transaction.date.year}-${transaction.date.month}';

      final current = data[key];

      if (current == null) {
        data[key] = CashFlowData(
          year: transaction.date.year,
          month: transaction.date.month,
          income:
          transaction.isIncome
              ? transaction.amount
              : 0,
          expense:
          transaction.isExpense
              ? transaction.amount
              : 0,
        );

        continue;
      }

      data[key] = CashFlowData(
        year: current.year,
        month: current.month,
        income: current.income +
            (transaction.isIncome
                ? transaction.amount
                : 0),
        expense: current.expense +
            (transaction.isExpense
                ? transaction.amount
                : 0),
      );
    }

    final result = data.values.toList();

    result.sort((a, b) {
      final left = DateTime(a.year, a.month);
      final right = DateTime(b.year, b.month);

      return left.compareTo(right);
    });

    return result;
  }

  FinancialInsight? getHeroInsight(
      List<Transaction> transactions,
      ) {
    if (transactions.isEmpty) {
      return null;
    }

    final income = getTotalIncome(transactions);
    final expense = getTotalExpense(transactions);

    if (income > 0) {
      final savingsRate =
          ((income - expense) / income) * 100;

      if (savingsRate >= 40) {
        return FinancialInsight(
          icon: Icons.emoji_events_rounded,
          title: 'Excellent Saving',
          description:
          'You saved ${savingsRate.toStringAsFixed(0)}% of your income this month.',
        );
      }

      if (savingsRate >= 20) {
        return FinancialInsight(
          icon: Icons.trending_up_rounded,
          title: 'Healthy Savings',
          description:
          'Great job! You saved ${savingsRate.toStringAsFixed(0)}% this month.',
        );
      }

      if (savingsRate <= 0) {
        return const FinancialInsight(
          icon: Icons.warning_amber_rounded,
          title: 'Overspending',
          description:
          'Your expenses exceeded your income this month.',
        );
      }
    }

    final categories = getCategorySummary(transactions);

    if (categories.isNotEmpty) {
      final top = categories.first;

      return FinancialInsight(
        icon: Icons.pie_chart_rounded,
        title: 'Top Spending',
        description:
        '${top.category} makes up ${(top.percentage * 100).toStringAsFixed(0)}% of your expenses.',
      );
    }

    return const FinancialInsight(
      icon: Icons.auto_graph_rounded,
      title: 'Keep Going',
      description:
      'Keep adding transactions to unlock more insights.',
    );
  }
}