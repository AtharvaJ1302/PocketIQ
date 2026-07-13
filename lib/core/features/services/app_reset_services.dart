import '../../../features/accounts/domain/repositories/account_repository.dart';
import '../../../features/budget/domain/repositories/budget_repository.dart';
import '../../../features/setup/domain/repositories/app_preferences_repository.dart';
import '../../../features/transactions/domain/repositories/transaction_repository.dart';

class AppResetService {
  final AccountRepository accountRepository;

  final TransactionRepository transactionRepository;

  final BudgetRepository budgetRepository;

  final AppPreferencesRepository preferencesRepository;

  AppResetService({
    required this.accountRepository,
    required this.transactionRepository,
    required this.budgetRepository,
    required this.preferencesRepository,
  });

  Future<void> reset() async {
    await transactionRepository.clearTransactions();

    await accountRepository.clearAccounts();

    await budgetRepository.clearBudgets();

    await preferencesRepository.clearPreferences();
  }
}