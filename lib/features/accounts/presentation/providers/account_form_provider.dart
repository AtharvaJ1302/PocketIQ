import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'account_notifier.dart';
import 'account_provider.dart';
import 'account_repository_provider.dart';
import 'add_account_notifier.dart';

final addAccountProvider =
ChangeNotifierProvider<AddAccountNotifier>((ref) {
  return AddAccountNotifier(
    ref.read(accountRepositoryProvider),
  );
});

final accountRefreshProvider = Provider<AccountNotifier>((ref) {
  return ref.read(accountProvider);
});