import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'account_balance_service.dart';

final accountBalanceServiceProvider =
Provider<AccountBalanceService>(
      (ref) {
    return const AccountBalanceService();
  },
);