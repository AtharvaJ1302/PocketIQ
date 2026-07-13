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
      String category, {
        int retry = 0,
      }) async {

    final key = keys[category];

    if (key == null) {

      if (retry < 8) {

        await Future.delayed(
          const Duration(
            milliseconds: 150,
          ),
        );

        return scrollTo(
          category,
          retry: retry + 1,
        );
      }

      return;
    }

    final context = key.currentContext;

    if (context == null) {

      if (retry < 8) {

        await Future.delayed(
          const Duration(
            milliseconds: 150,
          ),
        );

        return scrollTo(
          category,
          retry: retry + 1,
        );
      }

      return;
    }

    await Scrollable.ensureVisible(
      context,
      duration: const Duration(
        milliseconds: 700,
      ),
      curve: Curves.easeInOut,
      alignment: 0.1,
      alignmentPolicy:
      ScrollPositionAlignmentPolicy.explicit,
    );
  }
}