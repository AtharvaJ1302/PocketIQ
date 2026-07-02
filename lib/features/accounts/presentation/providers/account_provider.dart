import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../data/repositories/account_repository_impl.dart';
import '../../domain/repositories/account_repository.dart';
import 'account_notifier.dart';

final accountRepositoryProvider =
Provider<AccountRepository>((ref) {
  return AccountRepositoryImpl();
});

final accountProvider =
ChangeNotifierProvider<AccountNotifier>((ref) {
  return AccountNotifier(
    ref.read(accountRepositoryProvider),
  );
});