import 'package:intl/intl.dart';

class TransactionDateFormatter {
  TransactionDateFormatter._();

  static String header(DateTime date) {
    final now = DateTime.now();

    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final yesterday = today.subtract(
      const Duration(days: 1),
    );

    final current = DateTime(
      date.year,
      date.month,
      date.day,
    );

    if (current == today) {
      return "Today";
    }

    if (current == yesterday) {
      return "Yesterday";
    }

    return DateFormat(
      "dd MMM yyyy",
    ).format(date);
  }

  static String subtitle(DateTime date) {
    final now = DateTime.now();

    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final yesterday = today.subtract(
      const Duration(days: 1),
    );

    final current = DateTime(
      date.year,
      date.month,
      date.day,
    );

    final time = DateFormat(
      "hh:mm a",
    ).format(date);

    if (current == today) {
      return "Today • $time";
    }

    if (current == yesterday) {
      return "Yesterday • $time";
    }

    return "${DateFormat("dd MMM").format(date)} • $time";
  }
}