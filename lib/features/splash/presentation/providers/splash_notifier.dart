import 'package:flutter/foundation.dart';

import '../../../../core/constants/startup_strings.dart';

class SplashNotifier extends ChangeNotifier {
  String _status = StartupStrings.initializing;

  String get status => _status;

  void updateStatus(double progress) {
    final newStatus = switch (progress) {
      < 0.25 => StartupStrings.initializing,
      < 0.50 => StartupStrings.loadingPreferences,
      < 0.75 => StartupStrings.checkingAuthentication,
      < 0.95 => StartupStrings.preparingDashboard,
      _ => StartupStrings.almostReady,
    };

    if (newStatus == _status) return;

    _status = newStatus;
    notifyListeners();
  }
}