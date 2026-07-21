import 'package:flutter/material.dart';

import 'pocket_card_accent.dart';

extension PocketCardAccentExtension on PocketCardAccent {
  Color color(BuildContext context) {
    switch (this) {
      case PocketCardAccent.primary:
        return Theme.of(context).colorScheme.primary;

      case PocketCardAccent.blue:
        return Colors.blue;

      case PocketCardAccent.green:
        return Colors.green;

      case PocketCardAccent.orange:
        return Colors.orange;

      case PocketCardAccent.purple:
        return Colors.deepPurple;

      case PocketCardAccent.red:
        return Colors.red;
    }
  }
}