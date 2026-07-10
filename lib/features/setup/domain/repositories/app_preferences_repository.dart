import '../models/app_preferences.dart';

abstract class AppPreferencesRepository {
  Future<AppPreferences> loadPreferences();

  Future<void> savePreferences(
      AppPreferences preferences,
      );
}