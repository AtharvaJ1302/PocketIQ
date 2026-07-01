import 'package:flutter_riverpod/legacy.dart';

import '../../data/onboarding_data.dart';
import 'onboarding_notifier.dart';

final onboardingProvider =
ChangeNotifierProvider<OnboardingNotifier>(
      (ref) => OnboardingNotifier(
    totalPages: onboardingItems.length,
  ),
);