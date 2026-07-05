import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../data/repositories/transaction_repository_impl.dart';
import '../../domain/repositories/transaction_repository.dart';
import 'add_transaction_notifier.dart';
import 'transaction_notifier.dart';

final transactionRepositoryProvider =
Provider<TransactionRepository>(
      (ref) {
    return TransactionRepositoryImpl();
  },
);

final transactionProvider =
ChangeNotifierProvider<TransactionNotifier>(
      (ref) {
    return TransactionNotifier(
      ref.read(transactionRepositoryProvider),
    );
  },
);

final addTransactionProvider =
ChangeNotifierProvider<AddTransactionNotifier>(
      (ref) {
    return AddTransactionNotifier(
      ref.read(transactionRepositoryProvider),
    );
  },
);