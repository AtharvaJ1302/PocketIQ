import 'package:flutter/material.dart';

import 'bank_codes.dart';

class BankColors {
  BankColors._();

  static Color getColor(String bankCode) {
    switch (bankCode) {
      case BankCodes.icici:
        return const Color(0xFFF58220);

      case BankCodes.sbi:
        return const Color(0xFF2E6EB5);

      case BankCodes.hdfc:
        return const Color(0xFFE53935);

      case BankCodes.axis:
        return const Color(0xFF97144D);

      case BankCodes.kotak:
        return const Color(0xFFED1C24);

      case BankCodes.idfc:
        return const Color(0xFF8B0000);

      case BankCodes.pnb:
        return const Color(0xFFB8860B);

      case BankCodes.bob:
        return const Color(0xFFFF6600);

      case BankCodes.canara:
        return const Color(0xFF005BAC);

      case BankCodes.union:
        return const Color(0xFF0072BC);

      default:
        return Colors.grey;
    }
  }
}