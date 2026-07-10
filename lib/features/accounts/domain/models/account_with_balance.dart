import 'account.dart';

class AccountWithBalance {
  final Account account;

  final double currentBalance;

  const AccountWithBalance({
    required this.account,
    required this.currentBalance,
  });
}