import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'account_repository_provider.dart';
import 'account_notifier.dart';

final accountProvider =
ChangeNotifierProvider<AccountNotifier>((ref) {
  return AccountNotifier(
    ref.read(accountRepositoryProvider),
  );
});