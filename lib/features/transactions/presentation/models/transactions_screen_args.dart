import 'transactions_filter.dart';

class TransactionsScreenArgs {
  final TransactionsFilter? filter;

  final String screenTitle;

  const TransactionsScreenArgs({
    this.filter,
    this.screenTitle = 'Transactions',
  });
}