import 'package:flutter_riverpod/legacy.dart';

import 'budget_notifier.dart';
import 'budget_repository_provider.dart';

final budgetProvider =
ChangeNotifierProvider<
    BudgetNotifier>(
      (ref) {
    return BudgetNotifier(
      ref.read(
        budgetRepositoryProvider,
      ),
    );
  },
);