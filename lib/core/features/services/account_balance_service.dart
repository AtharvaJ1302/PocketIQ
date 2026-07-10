import '../../../features/accounts/domain/models/account.dart';
import '../../../features/transactions/domain/models/transaction.dart';

class AccountBalanceService {
  const AccountBalanceService();

  double getCurrentBalance({
    required Account account,
    required List<Transaction> transactions,
  }) {
    return account.openingBalance +
        getTotalIncome(
          accountId: account.id,
          transactions: transactions,
        ) -
        getTotalExpense(
          accountId: account.id,
          transactions: transactions,
        );
  }

  double getTotalIncome({
    required String accountId,
    required List<Transaction> transactions,
  }) {
    return transactions
        .where(
          (t) => t.accountId == accountId && t.isIncome,
    )
        .fold(
      0.0,
          (sum, t) => sum + t.amount,
    );
  }

  double getTotalExpense({
    required String accountId,
    required List<Transaction> transactions,
  }) {
    return transactions
        .where(
          (t) => t.accountId == accountId && t.isExpense,
    )
        .fold(
      0.0,
          (sum, t) => sum + t.amount,
    );
  }

  double getOverallBalance({
    required List<Account> accounts,
    required List<Transaction> transactions,
  }) {
    return accounts.fold(
      0.0,
          (sum, account) =>
      sum +
          getCurrentBalance(
            account: account,
            transactions: transactions,
          ),
    );
  }
}