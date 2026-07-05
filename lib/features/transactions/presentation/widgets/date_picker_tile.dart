import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerTile extends StatelessWidget {
  final DateTime date;
  final VoidCallback onTap;

  const DatePickerTile({
    super.key,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.calendar_today_outlined),
      title: const Text('Date'),
      subtitle: Text(
        DateFormat('dd MMM yyyy').format(date),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}