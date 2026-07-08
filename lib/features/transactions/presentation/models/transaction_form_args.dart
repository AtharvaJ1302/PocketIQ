import '../../domain/models/transaction.dart';
import '../../domain/models/transaction_type.dart';

class TransactionFormArgs {
  final Transaction? transaction;
  final TransactionType? initialType;

  const TransactionFormArgs({
    this.transaction,
    this.initialType,
  });

  bool get isEditing => transaction != null;
}