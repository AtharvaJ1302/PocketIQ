import '../../../../core/database/database_constants.dart';
import '../../domain/models/account.dart';

class AccountMapper {
  AccountMapper._();

  static Map<String, dynamic> toMap(Account account) {
    return {
      AccountColumns.id: account.id,
      AccountColumns.bankCode: account.bankCode,
      AccountColumns.accountName: account.accountName,
      AccountColumns.accountType: account.accountType,
      AccountColumns.accountNumber: account.accountNumber,
      AccountColumns.openingBalance: account.openingBalance,
    };
  }

  static Account fromMap(
      Map<String, dynamic> map,
      ) {
    return Account(
      id: map[AccountColumns.id],
      bankCode: map[AccountColumns.bankCode],
      accountName: map[AccountColumns.accountName],
      accountType: map[AccountColumns.accountType],
      accountNumber: map[AccountColumns.accountNumber],
      openingBalance: map[AccountColumns.openingBalance],
    );
  }
}