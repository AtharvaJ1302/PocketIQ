import 'package:flutter/foundation.dart';

import '../../../../core/features/services/local_auth_service.dart';

class AppLockNotifier extends ChangeNotifier {
  final LocalAuthService _localAuth;

  AppLockNotifier(
      this._localAuth,
      );

  bool loading = false;

  Future<bool> unlock() async {
    loading = true;
    notifyListeners();

    try {
      return await _localAuth.authenticate();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}