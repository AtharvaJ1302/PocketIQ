import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/accounts/presentation/providers/account_repository_provider.dart';
import '../../../features/budget/presentation/providers/budget_repository_provider.dart';
import '../../../features/setup/presentation/providers/app_preferences_repository_provider.dart';
import '../../../features/transactions/presentation/providers/transaction_provider.dart';
import 'app_reset_services.dart';

final appResetServiceProvider =
Provider<AppResetService>((ref) {
  return AppResetService(
    accountRepository: ref.read(
      accountRepositoryProvider,
    ),
    transactionRepository: ref.read(
      transactionRepositoryProvider,
    ),
    budgetRepository: ref.read(
      budgetRepositoryProvider,
    ),
    preferencesRepository: ref.read(
      appPreferencesRepositoryProvider,
    ),
  );
});