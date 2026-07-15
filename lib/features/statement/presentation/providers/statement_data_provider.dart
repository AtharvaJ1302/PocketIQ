import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/features/services/statement_service_provider.dart';
import '../../../budget/presentation/providers/budget_provider.dart';
import '../../../transactions/presentation/providers/transaction_provider.dart';
import 'statement_provider.dart';

final statementDataProvider = Provider(
      (ref) {
    final service =
    ref.read(statementServiceProvider);

    final transactions =
        ref.watch(transactionProvider)
            .transactions;

    final options =
        ref.watch(statementProvider)
            .options;

    final budgetNotifier =
    ref.watch(budgetProvider);

    return service.build(
      transactions: transactions,
      budgets: budgetNotifier.budgets,
      options: options,
    );
  },
);