import '../database_constants.dart';

class PreferencesSchema {
  PreferencesSchema._();

  static const createTable = '''
    CREATE TABLE ${DatabaseTables.preferences}(
      ${PreferencesColumns.id} INTEGER PRIMARY KEY,
      ${PreferencesColumns.userName} TEXT NOT NULL,
      ${PreferencesColumns.currencyCode} TEXT NOT NULL,
      ${PreferencesColumns.hideBalance} INTEGER NOT NULL,
      ${PreferencesColumns.appLockEnabled} INTEGER NOT NULL,
      ${PreferencesColumns.onboardingCompleted} INTEGER NOT NULL
    )
  ''';
}