import 'package:flutter/material.dart';

import '../../domain/models/app_preferences.dart';
import '../../domain/repositories/app_preferences_repository.dart';

class PreferencesNotifier extends ChangeNotifier {
  final AppPreferencesRepository _repository;

  PreferencesNotifier(this._repository) {
    loadPreferences();
  }

  bool loading = false;

  AppPreferences preferences =
  AppPreferences.initial();

  Future<void> loadPreferences() async {
    loading = true;
    notifyListeners();

    preferences =
    await _repository.getPreferences();

    loading = false;
    notifyListeners();
  }

  Future<void> savePreferences(
      AppPreferences value,
      ) async {
    loading = true;
    notifyListeners();

    await _repository.savePreferences(value);

    preferences = value;

    loading = false;
    notifyListeners();
  }

  Future<void> completeSetup({
    required String userName,
    required String currencyCode,
  }) async {
    await savePreferences(
      AppPreferences(
        userName: userName,
        currencyCode: currencyCode,
        onboardingCompleted: true,
        appLockEnabled: false,
      ),
    );
  }
}