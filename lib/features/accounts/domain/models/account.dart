class Account {
  final String id;

  final String bankCode;

  final String accountName;

  final String accountType;

  final String accountNumber;

  final double balance;

  const Account({
    required this.id,
    required this.bankCode,
    required this.accountName,
    required this.accountType,
    required this.accountNumber,
    required this.balance,
  });

  String get lastFourDigits {
    if (accountNumber.length <= 4) {
      return accountNumber;
    }

    return accountNumber.substring(
      accountNumber.length - 4,
    );
  }

  Account copyWith({
    String? id,
    String? bankCode,
    String? accountName,
    String? accountType,
    String? accountNumber,
    double? balance,
  }) {
    return Account(
      id: id ?? this.id,
      bankCode: bankCode ?? this.bankCode,
      accountName: accountName ?? this.accountName,
      accountType: accountType ?? this.accountType,
      accountNumber: accountNumber ?? this.accountNumber,
      balance: balance ?? this.balance,
    );
  }

}