import '../../domain/models/transaction.dart';
import '../../domain/models/transaction_type.dart';

class TransactionFormArgs {
  final Transaction? transaction;

  final TransactionType? initialType;

  /// Prefills the selected account in the transaction form.
  final String? accountId;

  final bool lockAccount;

  const TransactionFormArgs({
    this.transaction,
    this.initialType,
    this.accountId,
    this.lockAccount = false
  });

  bool get isEditing => transaction != null;
}