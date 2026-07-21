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
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          splashColor: theme.colorScheme.primary.withOpacity(.08),
          highlightColor: Colors.transparent,
          onTap: onTap,
          child: Ink(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: isLight
                  ? const Color(0xFFF7F4FF)
                  : theme.colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isLight
                    ? const Color(0xFFE7DEFF)
                    : theme.colorScheme.outline.withOpacity(.18),
              ),
              // boxShadow: [
              //   BoxShadow(
              //     color: isLight
              //         ? const Color(0xFF6D5BFF).withOpacity(.08)
              //         : Colors.black.withOpacity(.18),
              //     blurRadius: 18,
              //     offset: const Offset(0, 6),
              //   ),
              // ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: isLight
                        ? const Color(0xFFEDE8FF)
                        : theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: Color(0xFF6D5BFF),
                  ),
                ),

                const SizedBox(width: 12),

                Text(
                  formattedDate,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isLight
                        ? const Color(0xFF4F4B66)
                        : theme.colorScheme.onSurface,
                  ),
                ),

                const SizedBox(width: 8),

                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 22,
                  color: isLight
                      ? const Color(0xFF6F6A8A)
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String get formattedDate {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final selected = DateTime(date.year, date.month, date.day);

    final difference = selected.difference(today).inDays;

    switch (difference) {
      case 0:
        return "Today, ${DateFormat('d MMM yyyy').format(date)}";
      case -1:
        return "Yesterday";
      case 1:
        return "Tomorrow";
      default:
        return DateFormat('d MMM yyyy').format(date);
    }
  }
}