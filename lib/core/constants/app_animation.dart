import 'package:flutter/material.dart';

class AppAnimation {
  AppAnimation._();

  // Splash
  static const splashDuration = Duration(seconds: 4);

  static const logoInterval = Interval(
    0.00,
    0.25,
    curve: Curves.easeOutBack,
  );

  static const titleInterval = Interval(
    0.20,
    0.45,
    curve: Curves.easeOut,
  );

  static const taglineInterval = Interval(
    0.45,
    0.60,
    curve: Curves.easeOut,
  );

  static const progressInterval = Interval(
    0.00,
    1.00,
    curve: Curves.easeInOut,
  );

  static const footerInterval = Interval(
    0.75,
    1.00,
    curve: Curves.easeOut,
  );
}