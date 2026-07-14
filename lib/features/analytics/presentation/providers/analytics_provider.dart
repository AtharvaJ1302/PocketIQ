import 'package:flutter_riverpod/legacy.dart';

import '../../../transactions/presentation/providers/transaction_provider.dart';
import 'analytics_notifier.dart';

final analyticsProvider =
ChangeNotifierProvider<AnalyticsNotifier>(
      (ref) {
    final notifier = AnalyticsNotifier();

    ref.listen(
      transactionProvider,
          (_, next) {
        notifier.setTransactions(
          next.transactions,
        );
      },
    );

    notifier.setTransactions(
      ref.read(transactionProvider).transactions,
    );

    return notifier;
  },
);