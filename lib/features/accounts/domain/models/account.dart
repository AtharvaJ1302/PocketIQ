class Account {
  final String id;

  final String bankCode;

  final String accountName;

  final String accountType;

  final String accountNumber;

  final double openingBalance;

  final int createdAt;

  const Account({
    required this.id,
    required this.bankCode,
    required this.accountName,
    required this.accountType,
    required this.accountNumber,
    required this.openingBalance,
    required this.createdAt,
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
    double? openingBalance,
    int? createdAt,
  }) {
    return Account(
      id: id ?? this.id,
      bankCode: bankCode ?? this.bankCode,
      accountName: accountName ?? this.accountName,
      accountType: accountType ?? this.accountType,
      accountNumber: accountNumber ?? this.accountNumber,
      openingBalance: openingBalance ?? this.openingBalance,
      createdAt: createdAt ?? this.createdAt,
    );
  }

}