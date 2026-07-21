import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_animation.dart';
import '../../../../core/features/constants/app_spacing.dart';

class SplashFooter extends StatelessWidget {
  final AnimationController controller;

  const SplashFooter({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        FadeTransition(
          opacity: CurvedAnimation(
            parent: controller,
            curve: AppAnimation.footerInterval,
          ),
          child: Text(
            'Version 1.0.0',
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: .75),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}