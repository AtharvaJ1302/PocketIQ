import '../../domain/models/app_preferences.dart';
import '../../domain/repositories/app_preferences_repository.dart';
import '../services/preferences_service.dart';

class AppPreferencesRepositoryImpl
    implements AppPreferencesRepository {

  final PreferencesService _service =
      PreferencesService.instance;

  @override
  Future<AppPreferences> getPreferences() async {
    return AppPreferences(
      userName: await _service.getUserName(),
      currencyCode: await _service.getCurrencyCode(),
      onboardingCompleted:
      await _service.isOnboardingCompleted(),
      appLockEnabled:
      await _service.isAppLockEnabled(),
    );
  }

  @override
  Future<void> savePreferences(
      AppPreferences preferences,
      ) async {
    await _service.setUserName(
      preferences.userName,
    );

    await _service.setCurrencyCode(
      preferences.currencyCode,
    );

    await _service.setOnboardingCompleted(
      preferences.onboardingCompleted,
    );

    await _service.setAppLockEnabled(
      preferences.appLockEnabled,
    );
  }
}