import '../database_constants.dart';

class AccountSchema {
  AccountSchema._();

  static const createTable = '''
    CREATE TABLE ${DatabaseTables.accounts}(
      ${AccountColumns.id} TEXT PRIMARY KEY,
      ${AccountColumns.bankCode} TEXT NOT NULL,
      ${AccountColumns.accountName} TEXT NOT NULL,
      ${AccountColumns.accountType} TEXT NOT NULL,
      ${AccountColumns.accountNumber} TEXT NOT NULL,
      ${AccountColumns.openingBalance} REAL NOT NULL,
      ${AccountColumns.createdAt} INTEGER NOT NULL
    )
  ''';
}