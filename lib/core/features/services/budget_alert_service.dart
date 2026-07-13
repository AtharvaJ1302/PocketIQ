import '../../../features/budget/domain/models/budget.dart';
import '../../../features/budget/domain/repositories/budget_repository.dart';
import '../../../features/transactions/domain/models/transaction.dart';
import 'financial_insights_service.dart';
import 'local_notification_service.dart';

class BudgetAlertService {
  final BudgetRepository _budgetRepository;

  final FinancialInsightsService
  _financialInsightsService;

  BudgetAlertService({
    required BudgetRepository budgetRepository,
    required FinancialInsightsService
    financialInsightsService,
  })  : _budgetRepository = budgetRepository,
        _financialInsightsService =
            financialInsightsService;

  Future<void> checkBudgetAlerts(
      List<Transaction> transactions,
      ) async {
    final budgets =
    await _budgetRepository.getBudgets();

    for (final budget in budgets) {
      await _checkBudget(
        budget,
        transactions,
      );
    }
  }

  Future<void> _checkBudget(
      Budget budget,
      List<Transaction> transactions,
      ) async {

    if (!budget.notificationsEnabled) {
      return;
    }

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

    final progress =
        (spent / budget.budgetAmount) * 100;

    if (progress >=
        budget.notificationThreshold &&
        budget.lastNotificationThreshold ==
            0) {

      await LocalNotificationService.instance.show(
        id: budget.category.hashCode,
        title: 'Budget Alert',
        body:
        'You have spent ${progress.toStringAsFixed(0)}% of your ${budget.category} budget.',
        payload:
        'budget/${budget.category}',
      );

      final updated =
      budget.copyWith(
        lastNotificationThreshold:
        budget.notificationThreshold,
      );

      await _budgetRepository
          .updateBudget(updated);

      return;
    }

    if (progress >= 100 &&
        budget.lastNotificationThreshold <
            100) {

      final exceeded =
          spent - budget.budgetAmount;

      await LocalNotificationService.instance.show(
        id: budget.category.hashCode + 1,
        title: 'Budget Exceeded',
        body:
        'You exceeded your ${budget.category} budget.',
        payload:
        'budget/${budget.category}',
      );

      final updated =
      budget.copyWith(
        lastNotificationThreshold:
        100,
      );

      await _budgetRepository
          .updateBudget(updated);
    }
  }
}