import 'package:flutter/widgets.dart';

class AppSpacing {
  AppSpacing._();

  // Base Spacing
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 40;
  static const double xxxl = 56;
  static const double huge = 72;

  // Common Sizes
  static const double buttonHeight = 56;
  static const double buttonRadius = 18;

  static const double indicatorHeight = 8;
  static const double indicatorWidth = 34;

  static const double animationHeight = 300;
  static const double contentMaxWidth = 320;

  // Screen Padding
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );

  static const EdgeInsets cardPadding = EdgeInsets.all(md);

  static const section = 40.0;
}