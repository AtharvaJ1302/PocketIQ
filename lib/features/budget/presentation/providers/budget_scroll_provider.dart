import 'package:flutter/widgets.dart';

class BudgetScrollService {
  static final instance =
  BudgetScrollService();

  final Map<String, GlobalKey> keys = {};

  void register(
      String category,
      GlobalKey key,
      ) {
    keys[category] = key;
  }

  Future<void> scrollTo(
      String category,
      ) async {
    final key = keys[category];

    if (key == null) return;

    final context = key.currentContext;

    if (context == null) return;

    await Scrollable.ensureVisible(
      context,
      duration: const Duration(
        milliseconds: 700,
      ),
      curve: Curves.easeInOut,
    );
  }
}