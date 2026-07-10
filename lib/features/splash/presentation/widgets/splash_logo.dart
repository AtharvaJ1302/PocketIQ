import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_animation.dart';
import '../../../../core/features/constants/app_assets.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/constants/app_strings.dart';

class SplashLogo extends StatelessWidget {
  final AnimationController controller;

  const SplashLogo({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        ScaleTransition(
          scale: Tween<double>(
            begin: .85,
            end: 1,
          ).animate(
            CurvedAnimation(
              parent: controller,
              curve: AppAnimation.logoInterval,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: isDark
                  ? [
                BoxShadow(
                  color: const Color(0xff06B6D4)
                      .withValues(alpha: .20),
                  blurRadius: 40,
                  spreadRadius: 4,
                ),
              ]
                  : [],
            ),
            child: Image.asset(
              isDark
                  ? AppAssets.logoLight
                  : AppAssets.logoDark,
              height: 145,
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        FadeTransition(
          opacity: CurvedAnimation(
            parent: controller,
            curve: AppAnimation.titleInterval,
          ),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, .15),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: controller,
                curve: AppAnimation.titleInterval,
              ),
            ),
            child: Text(
              AppStrings.appName,
              style: theme.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        FadeTransition(
          opacity: CurvedAnimation(
            parent: controller,
            curve: AppAnimation.taglineInterval,
          ),
          child: Text(
            AppStrings.tagline,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}