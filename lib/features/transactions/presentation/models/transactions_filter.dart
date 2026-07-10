import '../../domain/models/transaction_type.dart';

class TransactionsFilter {
  final String? accountId;
  final TransactionType? type;
  final String? category;

  const TransactionsFilter({
    this.accountId,
    this.type,
    this.category,
  });

  bool get hasFilter =>
      accountId != null ||
          type != null ||
          category != null;
}