import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppGradients {
  AppGradients._();

  static const darkBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.gradientDarkTop,
      AppColors.gradientDarkMiddle,
      AppColors.gradientDarkBottom,
    ],
  );

  static const lightBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.gradientLightTop,
      AppColors.gradientLightMiddle,
      AppColors.gradientLightBottom,
    ],
  );

  static const primary = LinearGradient(
    colors: [
      AppColors.accent,
      AppColors.accentLight,
    ],
  );

  static const screenBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF060B18),
      Color(0xFF0A1022),
      Color(0xFF101938),
    ],
  );

  static const screenBackgroundLight = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFEFE7FF),
Color(0xFFEFE7FF),
Color(0xFFEFE7FF),
    ],
  );
}

// Color(0xFFF2F1F6),
// Color(0xFFF7F4FF),
// Color(0xFFEFE7FF),