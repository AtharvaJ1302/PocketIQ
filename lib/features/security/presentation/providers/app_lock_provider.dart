import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/features/services/local_auth_provider.dart';
import 'app_lock_notifier.dart';

final appLockProvider =
ChangeNotifierProvider<AppLockNotifier>((ref) {
  return AppLockNotifier(
    ref.read(localAuthProvider),
  );
});