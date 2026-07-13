import 'budget.dart';

class BudgetSummary {
  final Budget budget;

  final double spent;

  const BudgetSummary({
    required this.budget,
    required this.spent,
  });

  double get remaining =>
      (budget.budgetAmount - spent).clamp(
        0,
        double.infinity,
      );

  double get exceeded =>
      spent > budget.budgetAmount
          ? spent - budget.budgetAmount
          : 0;

  double get progress {
    if (budget.budgetAmount <= 0) {
      return 0;
    }

    return (spent / budget.budgetAmount)
        .clamp(0.0, 1.0);
  }

  double get rawProgress {
    if (budget.budgetAmount <= 0) {
      return 0;
    }

    return spent / budget.budgetAmount;
  }

  String get percentageLabel =>
      '${(rawProgress * 100).toStringAsFixed(0)}%';

  int get percentage =>
      (progress * 100).round();

  bool get isExceeded =>
      spent > budget.budgetAmount;


}