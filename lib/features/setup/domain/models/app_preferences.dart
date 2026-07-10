class AppPreferences {
  final String userName;
  final String currencyCode;
  final bool onboardingCompleted;
  final bool appLockEnabled;

  const AppPreferences({
    required this.userName,
    required this.currencyCode,
    required this.onboardingCompleted,
    required this.appLockEnabled,
  });

  factory AppPreferences.initial() {
    return const AppPreferences(
      userName: '',
      currencyCode: 'INR',
      onboardingCompleted: false,
      appLockEnabled: false,
    );
  }

  AppPreferences copyWith({
    String? userName,
    String? currencyCode,
    bool? onboardingCompleted,
    bool? appLockEnabled,
  }) {
    return AppPreferences(
      userName: userName ?? this.userName,
      currencyCode: currencyCode ?? this.currencyCode,
      onboardingCompleted:
      onboardingCompleted ?? this.onboardingCompleted,
      appLockEnabled:
      appLockEnabled ?? this.appLockEnabled,
    );
  }
}