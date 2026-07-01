import 'package:flutter/material.dart';

import '../../../../core/constants/app_duration.dart';
import '../../../../core/constants/app_spacing.dart';

class OnboardingBottomBar extends StatelessWidget {
  final bool isLastPage;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingBottomBar({
    super.key,
    required this.isLastPage,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          24,
          20,
          24,
          28,
        ),
        child: Row(
          children: [
            if (!isLastPage)
              TextButton(
                onPressed: onSkip,
                child: const Text(
                  'Skip →',
                ),
              ),

            if (!isLastPage)
              const Spacer(),

            Expanded(
              child: FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(AppSpacing.buttonHeight),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(AppSpacing.buttonRadius),
                  ),
                ),
                onPressed: onNext,
                child: AnimatedSwitcher(
                  duration: AppDuration.normal,
                  child: Text(
                    isLastPage
                        ? 'Get Started →'
                        : 'Next →',
                    key: ValueKey(isLastPage),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}