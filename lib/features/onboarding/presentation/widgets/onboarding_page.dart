import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pocketiq/core/constants/app_duration.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../domain/models/onboarding_item.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingPage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: AppSpacing.screenPadding,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: AppDuration.slow,
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: child,
              ),
            );
          },
          child: Column(
            children: [
              const Spacer(),

              SizedBox(
                height: AppSpacing.animationHeight,
                child: Lottie.asset(
                  item.animation,
                  repeat: true,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: AppSpacing.xxl),

              Text(
                item.category,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelMedium?.copyWith(
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              Text(
                item.title,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                  height: 1.15,
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppSpacing.contentMaxWidth,
                ),
                child: Text(
                  item.description,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.65,
                  ),
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}