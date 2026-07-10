import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  PreferencesService._();

  static final PreferencesService instance =
  PreferencesService._();

  static const _userNameKey = 'user_name';
  static const _currencyCodeKey = 'currency_code';
  static const _onboardingCompletedKey =
      'onboarding_completed';
  static const _appLockEnabledKey =
      'app_lock_enabled';

  Future<SharedPreferences> get _prefs async {
    return SharedPreferences.getInstance();
  }

  Future<String> getUserName() async {
    final prefs = await _prefs;

    return prefs.getString(_userNameKey) ?? '';
  }

  Future<void> setUserName(String value) async {
    final prefs = await _prefs;

    await prefs.setString(
      _userNameKey,
      value,
    );
  }

  Future<String> getCurrencyCode() async {
    final prefs = await _prefs;

    return prefs.getString(
      _currencyCodeKey,
    ) ??
        'INR';
  }

  Future<void> setCurrencyCode(
      String value,
      ) async {
    final prefs = await _prefs;

    await prefs.setString(
      _currencyCodeKey,
      value,
    );
  }

  Future<bool> isOnboardingCompleted() async {
    final prefs = await _prefs;

    return prefs.getBool(
      _onboardingCompletedKey,
    ) ??
        false;
  }

  Future<void> setOnboardingCompleted(
      bool value,
      ) async {
    final prefs = await _prefs;

    await prefs.setBool(
      _onboardingCompletedKey,
      value,
    );
  }

  Future<bool> isAppLockEnabled() async {
    final prefs = await _prefs;

    return prefs.getBool(
      _appLockEnabledKey,
    ) ??
        false;
  }

  Future<void> setAppLockEnabled(
      bool value,
      ) async {
    final prefs = await _prefs;

    await prefs.setBool(
      _appLockEnabledKey,
      value,
    );
  }

  Future<void> clear() async {
    final prefs = await _prefs;

    await prefs.clear();
  }
}