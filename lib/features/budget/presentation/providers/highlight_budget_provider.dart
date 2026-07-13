import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart';

class HighlightBudgetNotifier extends ChangeNotifier {
  String? highlightedCategory;

  Future<void> highlight(
      String category,
      ) async {
    highlightedCategory = category;

    notifyListeners();

    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );

    clear();
  }

  void clear() {
    highlightedCategory = null;
    notifyListeners();
  }
}

final highlightBudgetProvider =
ChangeNotifierProvider(
      (ref) => HighlightBudgetNotifier(),
);