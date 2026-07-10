import 'package:sqflite/sqflite.dart' hide Transaction;

import '../../../../core/database/database_constants.dart';
import '../../../../core/database/database_service.dart';
import '../../domain/models/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../mappers/transaction_mapper.dart';

class TransactionRepositoryImpl
    implements TransactionRepository {

  Future<Database> get _db =>
      DatabaseService.instance.database;

  @override
  Future<List<Transaction>> getTransactions() async {
    final db = await _db;

    final result = await db.query(
      DatabaseTables.transactions,
      orderBy:
      '${TransactionColumns.date} DESC',
    );

    return result
        .map(TransactionMapper.fromMap)
        .toList();
  }

  @override
  Future<void> addTransaction(
      Transaction transaction,
      ) async {
    final db = await _db;

    await db.insert(
      DatabaseTables.transactions,
      TransactionMapper.toMap(transaction),
      conflictAlgorithm:
      ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateTransaction(
      Transaction transaction,
      ) async {
    final db = await _db;

    await db.update(
      DatabaseTables.transactions,
      TransactionMapper.toMap(transaction),
      where:
      '${TransactionColumns.id} = ?',
      whereArgs: [transaction.id],
    );
  }

  @override
  Future<void> deleteTransaction(
      String id,
      ) async {
    final db = await _db;

    await db.delete(
      DatabaseTables.transactions,
      where:
      '${TransactionColumns.id} = ?',
      whereArgs: [id],
    );
  }
}