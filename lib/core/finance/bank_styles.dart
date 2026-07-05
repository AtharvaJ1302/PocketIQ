import 'package:flutter/material.dart';

import 'bank_codes.dart';

class BankStyle {
  final IconData icon;
  final Color color;

  const BankStyle({
    required this.icon,
    required this.color,
  });
}

class BankStyles {
  BankStyles._();

  static BankStyle get(String bankCode) {
    switch (bankCode) {
      case BankCodes.icici:
        return const BankStyle(
          icon: Icons.account_balance,
          color: Color(0xFFF58220),
        );

      case BankCodes.sbi:
        return const BankStyle(
          icon: Icons.account_balance,
          color: Color(0xFF2E6EB5),
        );

      case BankCodes.hdfc:
        return const BankStyle(
          icon: Icons.account_balance,
          color: Color(0xFFE53935),
        );

      case BankCodes.axis:
        return const BankStyle(
          icon: Icons.account_balance,
          color: Color(0xFF97144D),
        );

      case BankCodes.kotak:
        return const BankStyle(
          icon: Icons.account_balance,
          color: Color(0xFFED1C24),
        );

      default:
        return const BankStyle(
          icon: Icons.account_balance,
          color: Colors.grey,
        );
    }
  }
}