import 'package:flutter/material.dart';

import '../../../../core/constants/app_animation.dart';
import '../../../../core/constants/app_duration.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/components/pocket_progress_bar.dart';
import '../providers/splash_notifier.dart';

class SplashLoading extends StatelessWidget {
  final AnimationController animationController;
  final SplashNotifier controller;

  const SplashLoading({
    super.key,
    required this.animationController,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        AnimatedBuilder(
          animation: animationController,
          builder: (_, __) {
            return PocketProgressBar(
              progress: AppAnimation.progressInterval
                  .transform(animationController.value),
            );
          },
        ),

        const SizedBox(height: AppSpacing.md),

        AnimatedSwitcher(
          duration: AppDuration.medium,
          child: Text(
            controller.status,
            key: ValueKey(controller.status),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}