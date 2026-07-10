class DatabaseConstants {
  DatabaseConstants._();

  static const databaseName = 'pocketiq.db';

  static const databaseVersion = 2;
}

class DatabaseTables {
  DatabaseTables._();

  static const accounts = 'accounts';

  static const transactions = 'transactions';

  static const preferences = 'preferences';
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

class PreferencesColumns {
  PreferencesColumns._();

  static const id = 'id';

  static const userName = 'userName';

  static const currencyCode = 'currencyCode';

  static const hideBalance = 'hideBalance';

  static const appLockEnabled = 'appLockEnabled';

  static const onboardingCompleted =
      'onboardingCompleted';
}