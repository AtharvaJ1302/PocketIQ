class DatabaseConstants {
  DatabaseConstants._();

  static const databaseName = 'pocketiq.db';

  static const databaseVersion = 1;
}

class DatabaseTables {
  DatabaseTables._();

  static const accounts = 'accounts';

  static const transactions = 'transactions';
}

class AccountColumns {
  AccountColumns._();

  static const id = 'id';

  static const bankCode = 'bankCode';

  static const accountName = 'accountName';

  static const accountType = 'accountType';

  static const accountNumber = 'accountNumber';

  static const openingBalance = 'balance';
}

class TransactionColumns {
  TransactionColumns._();

  static const id = 'id';

  static const accountId = 'accountId';

  static const category = 'category';

  static const amount = 'amount';

  static const type = 'type';

  static const note = 'note';

  static const date = 'date';
}