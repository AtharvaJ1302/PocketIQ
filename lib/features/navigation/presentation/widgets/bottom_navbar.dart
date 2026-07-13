import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/navigation_provider.dart';

class PocketBottomNavBar extends ConsumerWidget {
  const PocketBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigation =
    ref.watch(navigationProvider);

    return NavigationBar(
      selectedIndex:
      navigation.currentIndex,

      onDestinationSelected:
      navigation.changeTab,

      destinations: const [

        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),

        NavigationDestination(
          icon: Icon(Icons.bar_chart_outlined),
          selectedIcon: Icon(Icons.bar_chart),
          label: 'Analytics',
        ),

        NavigationDestination(
          icon: Icon(Icons.savings_outlined),
          selectedIcon: Icon(Icons.savings),
          label: 'Budget',
        ),

        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}