import '../../../../core/bank/bank_codes.dart';
import '../../../home/domain/models/account.dart';
import '../../domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final List<Account> _accounts = [
    Account(
      id: '1',
      bankName: 'ICICI Bank',
      accountName: 'Savings',
      balance: 24520,
      lastFourDigits: '4821',
      bankCode: BankCodes.icici,
    ),
    Account(
      id: '2',
      bankName: 'SBI',
      accountName: 'Salary',
      balance: 18200,
      lastFourDigits: '1942',
      bankCode: BankCodes.sbi,
    ),
  ];

  @override
  Future<List<Account>> getAccounts() async {
    return _accounts;
  }

  @override
  Future<void> addAccount(Account account) async {
    _accounts.add(account);
  }

  @override
  Future<void> updateAccount(Account account) async {}

  @override
  Future<void> deleteAccount(String id) async {
    _accounts.removeWhere((e) => e.id == id);
  }
}