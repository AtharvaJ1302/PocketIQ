import 'package:flutter/foundation.dart';
import '../../domain/models/account.dart';
import '../../domain/repositories/account_repository.dart';

class AccountNotifier extends ChangeNotifier {
  AccountNotifier(this._repository) {
    loadAccounts();
  }

  final AccountRepository _repository;

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
      await _repository.deleteAccount(id);
      await loadAccounts();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

}