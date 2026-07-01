
import 'package:flutter/material.dart';

import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? color;
  final double? elevation;
  final BorderRadius? borderRadius;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.color,
    this.elevation,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final card = Card(
      color: color,
      elevation: elevation ?? 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? AppRadius.borderRadiusLg,
      ),
      child: Padding(padding: padding ?? AppSpacing.cardPadding, child: child),
    );

    if(onTap == null){
      return card;
    }

    return InkWell(
      borderRadius: borderRadius ?? AppRadius.borderRadiusLg,
      onTap: onTap,
        child: card,
    );
  }
}
