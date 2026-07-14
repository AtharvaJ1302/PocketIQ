import 'package:flutter/foundation.dart';

import '../../domain/models/statement_options.dart';

class StatementNotifier
    extends ChangeNotifier {

  StatementOptions _options =
  const StatementOptions();

  StatementOptions get options =>
      _options;

  void changeType(type) {
    _options =
        _options.copyWith(
          type: type,
        );

    notifyListeners();
  }

  void toggleIncome(bool value) {
    _options =
        _options.copyWith(
          includeIncome: value,
        );

    notifyListeners();
  }

  void toggleExpense(bool value) {
    _options =
        _options.copyWith(
          includeExpense: value,
        );

    notifyListeners();
  }

  void toggleCategories(
      bool value,
      ) {
    _options =
        _options.copyWith(
          includeCategories: value,
        );

    notifyListeners();
  }

  void toggleNotes(
      bool value,
      ) {
    _options =
        _options.copyWith(
          includeNotes: value,
        );

    notifyListeners();
  }

  void changeDateRange({
    DateTime? from,
    DateTime? to,
  }) {
    _options =
        _options.copyWith(
          from: from,
          to: to,
        );

    notifyListeners();
  }
}