import '../database_constants.dart';

class TransactionSchema {
  TransactionSchema._();

  static const createTable = '''
    CREATE TABLE ${DatabaseTables.transactions}(
      ${TransactionColumns.id} TEXT PRIMARY KEY,
      ${TransactionColumns.accountId} TEXT NOT NULL,
      ${TransactionColumns.category} TEXT NOT NULL,
      ${TransactionColumns.amount} REAL NOT NULL,
      ${TransactionColumns.type} TEXT NOT NULL,
      ${TransactionColumns.note} TEXT,
      ${TransactionColumns.date} TEXT NOT NULL
    )
  ''';
}