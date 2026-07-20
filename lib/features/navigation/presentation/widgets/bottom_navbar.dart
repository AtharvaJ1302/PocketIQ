import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/navigation_provider.dart';

class PocketBottomNavBar extends ConsumerWidget {
  const PocketBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigation = ref.watch(navigationProvider);

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Padding(
        padding: EdgeInsets.zero,
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: isDark
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1C2038), Color(0xFF14182D)],
                  )
                : const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFFFFFF), Color(0xFFF8F5FF)],
                  ),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: .06)
                  : const Color(0xFFE7DEFF),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? .30 : .08),
                blurRadius: 28,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              const itemCount = 4;
              final itemWidth = constraints.maxWidth / itemCount;

              return Stack(
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(end: navigation.currentIndex.toDouble()),
                    duration: const Duration(milliseconds: 420),
                    curve: Curves.easeOutQuart,
                    builder: (context, value, child) {
                      return Positioned(
                        left: value * itemWidth,
                        top: 8,
                        bottom: 8,
                        width: itemWidth,
                        child: child!,
                      );
                    },
                    child: Center(
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(end: navigation.currentIndex.toDouble()),
                        duration: const Duration(milliseconds: 420),
                        curve: Curves.easeOutQuart,
                        builder: (context, _, __) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: itemWidth - 14,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF7C3AED,
                                  ).withValues(alpha: .32),
                                  blurRadius: 24,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _NavItem(
                          icon: Icons.home_rounded,
                          label: 'Home',
                          selected: navigation.currentIndex == 0,
                          onTap: () => navigation.changeTab(0),
                        ),
                      ),
                      Expanded(
                        child: _NavItem(
                          icon: Icons.bar_chart_rounded,
                          label: 'Analytics',
                          selected: navigation.currentIndex == 1,
                          onTap: () => navigation.changeTab(1),
                        ),
                      ),
                      Expanded(
                        child: _NavItem(
                          icon: Icons.savings_rounded,
                          label: 'Budget',
                          selected: navigation.currentIndex == 2,
                          onTap: () => navigation.changeTab(2),
                        ),
                      ),
                      Expanded(
                        child: _NavItem(
                          icon: Icons.settings_rounded,
                          label: 'Settings',
                          selected: navigation.currentIndex == 3,
                          onTap: () => navigation.changeTab(3),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(end: selected ? 1 : 0),
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0, -2 * value),
                    child: Transform.scale(
                      scale: 1 + (0.08 * value),
                      child: Opacity(
                        opacity: 0.75 + (0.25 * value),
                        child: Icon(
                          icon,
                          size: 23,
                          color: selected
                              ? Colors.white
                              : (isDark ? Colors.white70 : Colors.black54),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 2),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 220),
                opacity: selected ? 1 : .75,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  style: theme.textTheme.labelSmall!.copyWith(
                    fontSize: 12,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: selected
                        ? Colors.white
                        : theme.colorScheme.onSurface.withValues(alpha: .65),
                  ),
                  child: Text(label),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
