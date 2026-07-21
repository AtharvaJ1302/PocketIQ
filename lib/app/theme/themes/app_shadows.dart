import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  static List<BoxShadow> card(BuildContext context) {
    final dark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return [
      BoxShadow(
        color: dark
            ? Colors.black.withValues(alpha: .18)
            : Colors.black.withValues(alpha: .05),
        blurRadius: 24,
        offset: const Offset(0, 10),
      ),
    ];
  }
}