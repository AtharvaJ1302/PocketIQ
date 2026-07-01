import 'package:flutter/material.dart';

import '../../../../core/constants/app_duration.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/components/buttons/pocket_button.dart';

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
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!isLastPage)
              Padding(
                padding: const EdgeInsets.only(
                  left: AppSpacing.xs,
                ),
                child: TextButton(
                  onPressed: onSkip,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    animationDuration: AppDuration.fast,
                  ),
                  child: const Text(
                    'Skip →',
                  ),
                ),
              ),

            if (!isLastPage) const Spacer(),

            SizedBox(
              width: 160,
              child: AnimatedSwitcher(
                duration: AppDuration.normal,
                child: PocketButton(
                  key: ValueKey(isLastPage),
                  label: isLastPage
                      ? 'Get Started →'
                      : 'Next →',
                  onPressed: onNext,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}