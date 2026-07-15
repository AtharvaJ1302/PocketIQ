import 'package:flutter/foundation.dart';

import '../../domain/models/statement_options.dart';
import '../../domain/models/statement_period.dart';
import '../../domain/models/statement_type.dart';

class StatementNotifier extends ChangeNotifier {
  StatementOptions _options =
  const StatementOptions();

  StatementOptions get options => _options;

  void changeType(
      StatementType type,
      ) {
    _options = _options.copyWith(
      type: type,
    );

    notifyListeners();
  }

  void changePeriod(
      StatementPeriod period,
      ) {
    _options = _options.copyWith(
      period: period,
    );

    notifyListeners();
  }

  void toggleCategories(
      bool value,
      ) {
    _options = _options.copyWith(
      includeCategories: value,
    );

    notifyListeners();
  }

  void toggleBudgetSummary(
      bool value,
      ) {
    _options = _options.copyWith(
      includeBudgetSummary: value,
    );

    notifyListeners();
  }

  void toggleNotes(
      bool value,
      ) {
    _options = _options.copyWith(
      includeNotes: value,
    );

    notifyListeners();
  }

  void changeDateRange({
    DateTime? from,
    DateTime? to,
  }) {
    _options = _options.copyWith(
      from: from,
      to: to,
    );

    notifyListeners();
  }
}