import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/onboarding_data.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/onboarding_bottom_bar.dart';
import '../widgets/onboarding_indicator.dart';
import '../widgets/onboarding_page.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends ConsumerState<OnboardingScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    final notifier = ref.read(onboardingProvider);

    if (notifier.isLastPage) {
      // TODO:
      // Save onboarding completed
      // Navigate to Login
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  void _skip() {
    _pageController.animateToPage(
      onboardingItems.length - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(onboardingProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingItems.length,
                onPageChanged: notifier.updatePage,
                itemBuilder: (_, index) {
                  return OnboardingPage(
                    item: onboardingItems[index],
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 8),
              child: OnboardingIndicator(
                currentPage: notifier.currentPage,
                totalPages: onboardingItems.length,
              ),
            ),

            OnboardingBottomBar(
              isLastPage: notifier.isLastPage,
              onNext: _nextPage,
              onSkip: _skip,
            ),
          ],
        ),
      ),
    );
  }
}