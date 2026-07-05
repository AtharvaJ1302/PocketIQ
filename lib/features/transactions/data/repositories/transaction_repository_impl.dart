import '../../domain/models/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl
    implements TransactionRepository {

  final List<Transaction> _transactions = [];

  @override
  Future<List<Transaction>> getTransactions() async {
    return List.unmodifiable(_transactions);
  }

  @override
  Future<void> addTransaction(
      Transaction transaction,
      ) async {
    _transactions.add(transaction);
  }

  @override
  Future<void> updateTransaction(
      Transaction transaction,
      ) async {
    final index = _transactions.indexWhere(
          (e) => e.id == transaction.id,
    );

    if (index == -1) return;

    _transactions[index] = transaction;
  }

  @override
  Future<void> deleteTransaction(
      String id,
      ) async {
    _transactions.removeWhere(
          (e) => e.id == id,
    );
  }
}