import 'transaction_type.dart';

class Transaction {
  final String id;
  final String accountId;
  final String category;
  final double amount;
  final TransactionType type;
  final String? note;
  final DateTime date;

  const Transaction({
    required this.id,
    required this.accountId,
    required this.category,
    required this.amount,
    required this.type,
    this.note,
    required this.date,
  });

  bool get isExpense => type == TransactionType.expense;

  bool get isIncome => type == TransactionType.income;

  Transaction copyWith({
    String? id,
    String? accountId,
    String? category,
    double? amount,
    TransactionType? type,
    String? note,
    DateTime? date,
  }) {
    return Transaction(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      note: note ?? this.note,
      date: date ?? this.date,
    );
  }
}