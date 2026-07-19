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
}