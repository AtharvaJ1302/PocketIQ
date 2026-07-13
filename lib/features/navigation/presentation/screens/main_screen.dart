import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/features/services/deep_link_manager.dart';
import '../../../analytics/presentation/screens/analytics_screen.dart';
import '../../../budget/presentation/screens/budget_screen.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../settings/presentations/screens/settings_screen.dart';
import '../providers/navigation_provider.dart';
import '../widgets/bottom_navbar.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  ConsumerState<MainScreen> createState() =>
      _MainScreenState();
}

class _MainScreenState
    extends ConsumerState<MainScreen> {

  @override
  void initState() {
    super.initState();

    DeepLinkManager.instance.onDeepLink =
        _handleDeepLink;
  }

  @override
  void dispose() {
    DeepLinkManager.instance.onDeepLink =
    null;

    super.dispose();
  }

  void _handleDeepLink(
      String payload,
      ) {
    debugPrint(
      'DeepLink received: $payload',
    );

    if (payload.startsWith('budget/')) {
      ref
          .read(navigationProvider)
          .changeTab(2);
    }
  }

  @override
  Widget build(
      BuildContext context,
      ) {
    final navigation = ref.watch(
      navigationProvider,
    );

    return Scaffold(
      body: IndexedStack(
        index: navigation.currentIndex,
        children: const [
          HomeScreen(),
          AnalyticsScreen(),
          BudgetScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar:
      const PocketBottomNavBar(),
    );
  }
}