import 'package:flutter/foundation.dart';

import '../../domain/models/account.dart';
import '../../domain/repositories/account_repository.dart';

class AddAccountNotifier extends ChangeNotifier {
  AddAccountNotifier(this._repository);

  final AccountRepository _repository;

  String? selectedBank;
  String? selectedAccountType;

  bool loading = false;

  void setBank(String? value) {
    selectedBank = value;
    notifyListeners();
  }

  void setAccountType(String? value) {
    selectedAccountType = value;
    notifyListeners();
  }

  Future<void> saveAccount({
    required String accountName,
    required String accountNumber,
  }) async {
    if (selectedBank == null || selectedAccountType == null) {
      return;
    }

    loading = true;
    notifyListeners();

    try {
      final account = Account(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        bankCode: selectedBank!,
        accountType: selectedAccountType!,
        accountName: accountName,
        accountNumber: accountNumber,
        openingBalance: 0,
      );

      await _repository.addAccount(account);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> updateAccount({
    required Account account,
    required String accountName,
    required String accountNumber,
  }) async {
    loading = true;
    notifyListeners();

    try {
      final updatedAccount = Account(
        id: account.id,
        bankCode: selectedBank!,
        accountType: selectedAccountType!,
        accountName: accountName,
        accountNumber: accountNumber,

        // Preserve the existing value in the database
        openingBalance: account.openingBalance,
      );

      await _repository.updateAccount(updatedAccount);
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}