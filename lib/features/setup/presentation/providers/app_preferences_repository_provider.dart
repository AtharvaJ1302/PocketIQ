import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_service.dart';
import '../../data/repositories/app_preferences_repository_impl.dart';
import '../../domain/repositories/app_preferences_repository.dart';

final appPreferencesRepositoryProvider =
Provider<AppPreferencesRepository>((ref) {
  return AppPreferencesRepositoryImpl(
    DatabaseService.instance,
  );
});