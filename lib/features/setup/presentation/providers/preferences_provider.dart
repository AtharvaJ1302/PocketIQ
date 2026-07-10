import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/database/database_service.dart';
import '../../data/repositories/app_preferences_repository_impl.dart';
import '../../domain/repositories/app_preferences_repository.dart';
import 'preferences_notifier.dart';

final preferencesRepositoryProvider =
Provider<AppPreferencesRepository>(
      (ref) {
    return AppPreferencesRepositoryImpl(
      DatabaseService.instance,
    );
  },
);

final preferencesProvider =
ChangeNotifierProvider<PreferencesNotifier>(
      (ref) {
    return PreferencesNotifier(
      ref.read(
        preferencesRepositoryProvider,
      ),
    );
  },
);