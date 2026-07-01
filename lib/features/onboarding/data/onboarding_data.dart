import '../../../core/constants/app_lottie.dart';
import '../domain/models/onboarding_item.dart';

const onboardingItems = [
  OnboardingItem(
    animation: AppLottie.wallet,
    title: 'Track Every Rupee',
    description:
    'Every payment and every expense, automatically organized into one beautiful dashboard.',
  ),

  OnboardingItem(
    animation: AppLottie.analytics,
    title: 'Understand Your Spending',
    description:
    'Interactive charts and smart insights that help you understand where your money goes.',
  ),

  OnboardingItem(
    animation: AppLottie.budget,
    title: 'Stay In Control',
    description:
    'Set budgets, receive alerts and build better financial habits every month.',
  ),
];