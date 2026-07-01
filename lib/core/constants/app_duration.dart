class AppDuration {
  AppDuration._();

  /// Micro interactions
  static const instant = Duration(milliseconds: 100);

  /// Button presses, ripples
  static const fast = Duration(milliseconds: 150);

  /// Most UI animations
  static const normal = Duration(milliseconds: 250);

  /// Page transitions
  static const medium = Duration(milliseconds: 350);

  /// Hero / Entrance animations
  static const slow = Duration(milliseconds: 500);

  /// Splash screen
  static const splash = Duration(seconds: 4);
}