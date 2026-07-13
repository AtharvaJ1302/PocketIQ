import '../models/account.dart';

abstract class AccountRepository {
  Future<List<Account>> getAccounts();

  Future<void> addAccount(Account account);

  Future<void> updateAccount(Account account);

  Future<void> deleteAccount(String id);

  Future<void> clearAccounts();

}