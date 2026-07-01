import 'package:flutter/material.dart';
import 'package:pocketiq/core/constants/app_duration.dart';

import '../../../../core/constants/app_spacing.dart';

class OnboardingIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const OnboardingIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
            (index) {
          final selected = index == currentPage;

          return AnimatedContainer(
            duration: AppDuration.normal,
            curve: Curves.easeOut,

            margin: const EdgeInsets.symmetric(horizontal: 5),

            height: AppSpacing.indicatorHeight,

            width: selected ? AppSpacing.indicatorWidth
                : AppSpacing.indicatorHeight,

            decoration: BoxDecoration(
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context)
                  .colorScheme
                  .outlineVariant,

              borderRadius: BorderRadius.circular(100),
            ),
          );
        },
      ),
    );
  }
}