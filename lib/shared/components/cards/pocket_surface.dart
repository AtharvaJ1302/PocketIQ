import 'package:flutter/material.dart';
import '../../../app/theme/colors/app_colors.dart';

class PocketSurface extends StatelessWidget {
  final Widget child;

  final EdgeInsetsGeometry padding;

  final double radius;

  final VoidCallback? onTap;

  final bool glow;

  final bool bordered;

  const PocketSurface({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.radius = 28,
    this.onTap,
    this.glow = false,
    this.bordered = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final dark =
        theme.brightness == Brightness.dark;

    final background =
    dark
        ? AppColors.cardDark
        : AppColors.cardLight;

    final border =
    dark
        ? AppColors.borderDark
        : AppColors.borderLight;

    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 220,
      ),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: background,
        borderRadius:
        BorderRadius.circular(radius),
        border:
        bordered
            ? Border.all(
          color: border,
        )
            : null,
        boxShadow: glow
            ? [
          BoxShadow(
            color:
            AppColors.glow.withOpacity(
              dark ? .22 : .12,
            ),
            blurRadius: 30,
            spreadRadius: -8,
          ),
        ]
            : [
          BoxShadow(
            color: Colors.black.withOpacity(
              dark ? .18 : .05,
            ),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius:
          BorderRadius.circular(radius),
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}