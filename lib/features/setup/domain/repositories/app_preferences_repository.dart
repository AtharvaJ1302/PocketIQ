import '../models/app_preferences.dart';

abstract class AppPreferencesRepository {

  Future<AppPreferences> getPreferences();

  Future<void> savePreferences(
      AppPreferences preferences,
      );

}