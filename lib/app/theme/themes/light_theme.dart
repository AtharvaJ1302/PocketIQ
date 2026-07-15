import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../../core/features/constants/app_radius.dart';
import '../../../core/features/constants/app_sizes.dart';
import '../colors/app_colors.dart';
import '../typography/app_typography.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,

  scaffoldBackgroundColor: AppColors.backgroundLight,

  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
  ),

  textTheme: AppTypography.getTextTheme(
    ThemeData.light().textTheme,
  ),

  appBarTheme: const AppBarTheme(
    centerTitle: false,
    elevation: 0,
    scrolledUnderElevation: 0,

    backgroundColor: Colors.transparent,

    foregroundColor: AppColors.textPrimary,

    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),

  cardTheme: CardThemeData(
    color: AppColors.surfaceLight,
    elevation: 2,
    shadowColor: Colors.black12,
    margin: EdgeInsets.zero,
    shape: const RoundedRectangleBorder(
      borderRadius: AppRadius.borderRadiusLg,
    ),
  ),

  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size(
        double.infinity,
        AppSizes.buttonHeight,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadius.borderRadiusMd,
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,

    contentPadding: const EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 18,
    ),

    border: const OutlineInputBorder(
      borderRadius: AppRadius.borderRadiusMd,
      borderSide: BorderSide.none,
    ),

    enabledBorder: const OutlineInputBorder(
      borderRadius: AppRadius.borderRadiusMd,
      borderSide: BorderSide(
        color: AppColors.divider,
      ),
    ),

    focusedBorder: const OutlineInputBorder(
      borderRadius: AppRadius.borderRadiusMd,
      borderSide: BorderSide(
        color: AppColors.primary,
        width: 2,
      ),
    ),
  ),

  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.primary,
  ),

  bottomSheetTheme: const BottomSheetThemeData(
    showDragHandle: true,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: AppRadius.radiusXl,
      ),
    ),
  ),

  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: AppRadius.borderRadiusMd,
    ),
  ),

  dividerColor: AppColors.divider,
);