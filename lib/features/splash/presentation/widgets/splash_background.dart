import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_spacing.dart';

class SplashBackground extends StatelessWidget {
  final Widget child;

  const SplashBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? const [
            Color(0xff111827),
            Color(0xff020617),
          ]
              : const [
            Colors.white,
            Color(0xffEEF6FF),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: child,
        ),
      ),
    );
  }
}