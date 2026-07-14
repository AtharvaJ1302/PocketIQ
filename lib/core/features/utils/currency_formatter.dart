import 'package:intl/intl.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  static final _formatter = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0,
  );

  static final NumberFormat _number =
  NumberFormat.decimalPattern('en_IN');

  static String format(num amount) {
    return _formatter.format(amount);
  }

  static String number(num amount) {
    return _number.format(amount);
  }

  static String compact(num amount) {
    final value = amount.abs();

    if (value >= 10000000) {
      return '₹${(amount / 10000000).toStringAsFixed(2)}Cr';
    }

    if (value >= 100000) {
      return '₹${(amount / 100000).toStringAsFixed(2)}L';
    }

    if (value >= 1000) {
      return '₹${(amount / 1000).toStringAsFixed(1)}K';
    }

    return format(amount);
  }

  static String signed(num amount) {
    return amount >= 0
        ? '+${format(amount)}'
        : '-${format(amount.abs())}';
  }
}