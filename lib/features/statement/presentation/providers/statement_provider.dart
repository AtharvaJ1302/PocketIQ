import 'package:flutter_riverpod/legacy.dart';

import 'statement_notifier.dart';

final statementProvider =
ChangeNotifierProvider(
      (ref) {
    return StatementNotifier();
  },
);