import 'package:sqflite/sqflite.dart';

import '../../../../core/database/database_constants.dart';
import '../../../../core/database/database_service.dart';
import '../../domain/models/account.dart';
import '../../domain/repositories/account_repository.dart';
import '../mappers/account_mapper.dart';

class AccountRepositoryImpl implements AccountRepository {
  final DatabaseService _databaseService;

  AccountRepositoryImpl(
      this._databaseService,
      );

  Future<Database> get _db =>
      DatabaseService.instance.database;

  @override
  Future<List<Account>> getAccounts() async {
    final db = await _db;

    final result = await db.query(
      DatabaseTables.accounts,
      orderBy: AccountColumns.accountName,
    );

    return result
        .map(AccountMapper.fromMap)
        .toList();
  }

  @override
  Future<void> addAccount(Account account) async {
    final db = await _db;

    await db.insert(
      DatabaseTables.accounts,
      AccountMapper.toMap(account),
      conflictAlgorithm:
      ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateAccount(
      Account account,
      ) async {
    final db = await _db;

    await db.update(
      DatabaseTables.accounts,
      AccountMapper.toMap(account),
      where:
      '${AccountColumns.id} = ?',
      whereArgs: [account.id],
    );
  }

  @override
  Future<void> deleteAccount(
      String id,
      ) async {
    final db = await _db;

    await db.delete(
      DatabaseTables.accounts,
      where:
      '${AccountColumns.id} = ?',
      whereArgs: [id],
    );
  }


  @override
  Future<void> clearAccounts() async {
    final db = await _db;

    await db.delete(
      DatabaseTables.accounts,
    );
  }

}