import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({
    super.key,
    this.size = 100,
  });

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Image.asset(
      isDark
          ? AppAssets.logoLight
          : AppAssets.logoDark,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}