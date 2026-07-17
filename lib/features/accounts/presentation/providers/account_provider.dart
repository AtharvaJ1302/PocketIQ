import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../budget/presentation/providers/budget_provider.dart';
import '../../../budget/presentation/providers/budget_repository_provider.dart';
import 'account_repository_provider.dart';
import 'account_notifier.dart';

final accountProvider =
ChangeNotifierProvider<AccountNotifier>((ref) {
  return AccountNotifier(
    ref.read(accountRepositoryProvider),
    ref.read(budgetProvider),
  );
});