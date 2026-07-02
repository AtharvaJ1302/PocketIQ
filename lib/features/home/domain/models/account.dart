class Account {
  final String id;
  final String bankName;
  final String accountName;
  final double balance;
  final String lastFourDigits;
  final String bankCode;

  const Account({
    required this.id,
    required this.bankName,
    required this.accountName,
    required this.balance,
    required this.lastFourDigits,
    required this.bankCode,
  });
}