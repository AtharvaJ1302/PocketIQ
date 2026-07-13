import 'package:flutter/widgets.dart';

class BudgetScrollService {
  static final instance =
  BudgetScrollService();

  final Map<String, GlobalKey> keys = {};

  void register(
      String category,
      GlobalKey key,
      ) {
    debugPrint("Registered: $category");

    keys[category] = key;
  }

  Future<void> scrollTo(
      String category,
      ) async {

    debugPrint("Scrolling to: $category");
    debugPrint("Available keys: ${keys.keys}");

    final key = keys[category];

    if (key == null) {
      debugPrint("Key not found!");
      return;
    }

    final context = key.currentContext;

    if (context == null) {
      debugPrint("Context is null!");
      return;
    }

    await Scrollable.ensureVisible(
      context,
      duration: const Duration(
        milliseconds: 700,
      ),
      curve: Curves.easeInOut,
      alignment: 0.2,
    );
  }
}