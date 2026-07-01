import 'package:flutter_riverpod/legacy.dart';

import 'authentication_notifier.dart';

final authenticationProvider =
ChangeNotifierProvider<AuthenticationNotifier>(
      (ref) => AuthenticationNotifier(),
);