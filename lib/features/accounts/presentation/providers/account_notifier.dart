import 'package:flutter/foundation.dart';
import '../../../budget/presentation/providers/budget_notifier.dart';
import '../../domain/models/account.dart';
import '../../domain/repositories/account_repository.dart';

class AccountNotifier extends ChangeNotifier {
  AccountNotifier(
      this._repository,
      this._budgetNotifier,
      ) {
    loadAccounts();
  }

  final AccountRepository _repository;
  final BudgetNotifier _budgetNotifier;

  bool loading = false;

  List<Account> accounts = [];

  Future<void> loadAccounts() async {
    loading = true;
    notifyListeners();

    accounts = await _repository.getAccounts();

    loading = false;
    notifyListeners();
  }

  Future<void> addAccount(Account account) async {
    await _repository.addAccount(account);

    await loadAccounts();
  }

  Future<void> updateAccount(Account account) async {
    await _repository.updateAccount(account);

    await loadAccounts();
  }

  Future<void> deleteAccount(String id) async {
    loading = true;
    notifyListeners();

    try {
      final remainingAccounts =
          accounts.length - 1;

      if (remainingAccounts == 0) {
        await _budgetNotifier.clearBudgets();
      }

      await _repository.deleteAccount(id);

      await loadAccounts();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

}