import 'package:flutter/foundation.dart';

import '../../domain/models/app_preferences.dart';
import '../../domain/repositories/app_preferences_repository.dart';

class PreferencesNotifier extends ChangeNotifier {
  final AppPreferencesRepository _repository;

  PreferencesNotifier(
      this._repository,
      );

  AppPreferences _preferences =
  AppPreferences.initial();

  AppPreferences get preferences =>
      _preferences;

  bool loading = false;

  Future<void> loadPreferences() async {
    loading = true;
    notifyListeners();

    try {
      _preferences =
      await _repository.getPreferences();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> savePreferences(
      AppPreferences preferences,
      ) async {
    loading = true;
    notifyListeners();

    try {
      await _repository.savePreferences(
        preferences,
      );

      _preferences = preferences;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> updatePreferences(
      AppPreferences preferences,
      ) async {
    await savePreferences(
      preferences,
    );
  }

  Future<void> completeSetup({
    required String userName,
    required String currencyCode,
  }) async {
    await savePreferences(
      AppPreferences.initial().copyWith(
        userName: userName,
        currencyCode: currencyCode,
        onboardingCompleted: true,
      ),
    );
  }

  Future<void> updateUserName(
      String name,
      ) async {
    await savePreferences(
      _preferences.copyWith(
        userName: name,
      ),
    );
  }

  Future<void> toggleHideBalance() async {
    await savePreferences(
      _preferences.copyWith(
        hideBalance:
        !_preferences.hideBalance,
      ),
    );
  }

  Future<void> toggleAppLock() async {
    await savePreferences(
      _preferences.copyWith(
        appLockEnabled:
        !_preferences.appLockEnabled,
      ),
    );
  }
}