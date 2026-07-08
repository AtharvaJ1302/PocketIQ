enum TransactionType {
  expense,
  income;

  bool get isExpense => this == TransactionType.expense;

  bool get isIncome => this == TransactionType.income;
}