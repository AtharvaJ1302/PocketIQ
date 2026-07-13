import '../../../../core/database/database_constants.dart';

class AppPreferences {
  final int id;

  final String userName;

  final String currencyCode;

  final bool onboardingCompleted;

  final bool appLockEnabled;

  final bool hideBalance;

  final bool notificationPermissionAsked;

  final bool notificationsEnabled;

  const AppPreferences({
    this.id = 1,
    required this.userName,
    required this.currencyCode,
    required this.onboardingCompleted,
    required this.appLockEnabled,
    required this.hideBalance,
    required this.notificationPermissionAsked,
    required this.notificationsEnabled,
  });

  factory AppPreferences.initial() {
    return const AppPreferences(
      id: 1,
      userName: '',
      currencyCode: 'INR',
      onboardingCompleted: false,
      appLockEnabled: false,
      hideBalance: false,
      notificationPermissionAsked: false,
      notificationsEnabled: false,
    );
  }

  AppPreferences copyWith({
    int? id,
    String? userName,
    String? currencyCode,
    bool? onboardingCompleted,
    bool? appLockEnabled,
    bool? hideBalance,
    bool? notificationPermissionAsked,
    bool? notificationsEnabled,
  }) {
    return AppPreferences(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      currencyCode:
      currencyCode ?? this.currencyCode,
      onboardingCompleted:
      onboardingCompleted ??
          this.onboardingCompleted,
      appLockEnabled:
      appLockEnabled ??
          this.appLockEnabled,
      hideBalance:
      hideBalance ??
          this.hideBalance,
      notificationPermissionAsked:
      notificationPermissionAsked ??
          this.notificationPermissionAsked,
      notificationsEnabled:
      notificationsEnabled ??
          this.notificationsEnabled,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      PreferencesColumns.id: id,
      PreferencesColumns.userName: userName,
      PreferencesColumns.currencyCode:
      currencyCode,
      PreferencesColumns.hideBalance:
      hideBalance ? 1 : 0,
      PreferencesColumns.appLockEnabled:
      appLockEnabled ? 1 : 0,
      PreferencesColumns.onboardingCompleted:
      onboardingCompleted ? 1 : 0,
      PreferencesColumns
          .notificationPermissionAsked:
      notificationPermissionAsked
          ? 1
          : 0,
      PreferencesColumns
          .notificationsEnabled:
      notificationsEnabled
          ? 1
          : 0,
    };
  }

  factory AppPreferences.fromMap(
      Map<String, dynamic> map) {
    return AppPreferences(
      id: map[PreferencesColumns.id],
      userName:
      map[PreferencesColumns.userName],
      currencyCode:
      map[PreferencesColumns.currencyCode],
      hideBalance:
      map[PreferencesColumns.hideBalance] ==
          1,
      appLockEnabled:
      map[PreferencesColumns
          .appLockEnabled] ==
          1,
      onboardingCompleted:
      map[PreferencesColumns
          .onboardingCompleted] ==
          1,
      notificationPermissionAsked:
      (map[PreferencesColumns
          .notificationPermissionAsked] ??
          0) ==
          1,
      notificationsEnabled:
      (map[PreferencesColumns
          .notificationsEnabled] ??
          0) ==
          1,
    );
  }
}