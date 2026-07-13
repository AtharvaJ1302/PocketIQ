import 'package:sqflite/sqflite.dart';

import '../../../../core/database/database_constants.dart';
import '../../../../core/database/database_service.dart';
import '../../domain/models/app_preferences.dart';
import '../../domain/repositories/app_preferences_repository.dart';

class AppPreferencesRepositoryImpl
    implements AppPreferencesRepository {

  final DatabaseService _databaseService;

  AppPreferencesRepositoryImpl(
      this._databaseService,
      );

  @override
  Future<void> clearPreferences() async {
    final db = await _databaseService.database;

    await db.delete(
      DatabaseTables.preferences,
    );
  }

  @override
  Future<AppPreferences> getPreferences() async {
    final db = await _databaseService.database;

    final result = await db.query(
      DatabaseTables.preferences,
      limit: 1,
    );

    if (result.isEmpty) {
      final preferences =
      AppPreferences.initial();

      await savePreferences(
        preferences,
      );

      return preferences;
    }

    return AppPreferences.fromMap(
      result.first,
    );
  }

  @override
  Future<void> savePreferences(
      AppPreferences preferences,
      ) async {
    final db = await _databaseService.database;

    await db.insert(
      DatabaseTables.preferences,
      preferences.toMap(),
      conflictAlgorithm:
      ConflictAlgorithm.replace,
    );
  }
}