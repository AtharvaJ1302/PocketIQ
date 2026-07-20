import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/features/constants/app_duration.dart';
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
  late final ValueNotifier<double> _pageOffset;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _pageOffset = ValueNotifier(0);

    _pageController.addListener(() {
      _pageOffset.value = _pageController.page ?? 0;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    for (final item in onboardingItems) {
      precacheImage(
        AssetImage(item.image),
        context,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _pageOffset.dispose();
    super.dispose();
  }

  void _nextPage() {
    final notifier = ref.read(onboardingProvider);

    if (notifier.isLastPage) {
      context.go(AppRoutes.setup);
      return;
    }

    _pageController.nextPage(
      duration: AppDuration.medium,
      curve: Curves.easeOutCubic,
    );
  }

  void _skip() {
    _pageController.animateToPage(
      onboardingItems.length - 1,
      duration: AppDuration.medium,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(onboardingProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDark
                  ? const [
                Color(0xff060B18),
                Color(0xff0A1022),
                Color(0xff101938),
              ]
                  : const [
                Color(0xFFFCFAFF),
                Color(0xFFF7F4FF),
                Color(0xFFEFE7FF),
              ],
            ),
          ),
          child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                itemCount: onboardingItems.length,
                onPageChanged: notifier.updatePage,
                itemBuilder: (_, index) {
                  return OnboardingPage(
                    item: onboardingItems[index],
                    index: index,
                    pageOffset: _pageOffset,
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            OnboardingIndicator(
              currentPage: notifier.currentPage,
              totalPages: onboardingItems.length,
            ),

            const SizedBox(height: 18),

            OnboardingBottomBar(
              isLastPage: notifier.isLastPage,
              onNext: _nextPage,
              onSkip: _skip,
            ),
          ],
        ),
      ),
        ),
    );
  }
}