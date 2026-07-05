import '../../../../core/finance/bank_codes.dart';
import '../../domain/models/account.dart';
import '../../domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final List<Account> _accounts = [
    Account(
      id: '1',
      bankCode: BankCodes.icici,
      accountName: 'Savings Account',
      accountType: 'Savings',
      accountNumber: '458712364821',
      balance: 24520,
    ),
    Account(
      id: '2',
      bankCode: BankCodes.sbi,
      accountName: 'Salary Account',
      accountType: 'Savings',
      accountNumber: '654321781942',
      balance: 18200,
    ),
  ];

  @override
  Future<List<Account>> getAccounts() async {
    return List.unmodifiable(_accounts);
  }

  @override
  Future<void> addAccount(Account account) async {
    _accounts.add(account);
  }

  @override
  Future<void> updateAccount(Account account) async {
    final index = _accounts.indexWhere(
          (e) => e.id == account.id,
    );

    if (index == -1) return;

    _accounts[index] = account;
  }

  @override
  Future<void> deleteAccount(String id) async {
    _accounts.removeWhere((e) => e.id == id);
  }

  @override
  Future<void> updateBalance(
      String accountId,
      double amount,
      bool isExpense,
      ) async {
    final index = _accounts.indexWhere(
          (e) => e.id == accountId,
    );

    if (index == -1) return;

    final account = _accounts[index];

    _accounts[index] = account.copyWith(
      balance: isExpense
          ? account.balance - amount
          : account.balance + amount,
    );
  }

}
