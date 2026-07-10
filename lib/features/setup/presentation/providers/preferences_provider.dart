import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../data/repositories/app_preferences_repository_impl.dart';
import '../../domain/repositories/app_preferences_repository.dart';
import 'preferences_notifier.dart';

final appPreferencesRepositoryProvider =
Provider<AppPreferencesRepository>(
      (ref) {
    return AppPreferencesRepositoryImpl();
  },
);

final preferencesProvider =
ChangeNotifierProvider<PreferencesNotifier>(
      (ref) {
    return PreferencesNotifier(
      ref.read(appPreferencesRepositoryProvider),
    );
  },
);