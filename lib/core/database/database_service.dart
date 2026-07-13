import 'package:path/path.dart';
import 'package:pocketiq/core/database/schemas/account_schema.dart';
import 'package:pocketiq/core/database/schemas/budget_schema.dart';
import 'package:pocketiq/core/database/schemas/preferences_schema.dart';
import 'package:pocketiq/core/database/schemas/transaction_schema.dart';
import 'package:sqflite/sqflite.dart';

import 'database_constants.dart';

class DatabaseService {
  DatabaseService._();

  static final DatabaseService instance =
  DatabaseService._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(
      databasePath,
      DatabaseConstants.databaseName,
    );

    return openDatabase(
      path,
      version: DatabaseConstants.databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(
      Database db,
      int version,
      ) async {
    await db.execute(
      AccountSchema.createTable,
    );

    await db.execute(
      TransactionSchema.createTable,
    );

    await db.execute(
      BudgetSchema.createTable,
    );

    await db.execute(
      PreferencesSchema.createTable,
    );
  }

  Future<void> close() async {
    final db = await database;

    await db.close();

    _database = null;
  }
}