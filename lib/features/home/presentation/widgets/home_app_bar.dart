import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/features/constants/app_spacing.dart';
import '../../../analytics/presentation/providers/analytics_provider.dart';
import '../../../setup/presentation/providers/preferences_provider.dart';
import '../providers/home_provider.dart';

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final home = ref.watch(homeProvider);
    final preferences = ref.watch(preferencesProvider);

    final userName = preferences.preferences.userName;

    final analytics =
    ref.watch(analyticsProvider);

    final heroInsight =
        analytics.heroInsight;

    return Padding(
      padding: AppSpacing.screenPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  home.greeting,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  '$userName 👋',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -.8,
                    color: theme.colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: 6),
              ],
            ),
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHigh,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: .10),
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    // TODO: Notifications
                  },
                  splashRadius: 22,
                  icon: Icon(
                    Icons.notifications_none_rounded,
                    color: theme.colorScheme.onSurface,
                    size: 22,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              CircleAvatar(
                radius: 23,
                backgroundColor: const Color(0xFF6D5BFF),
                child: Text(
                  userName.isNotEmpty
                      ? userName[0].toUpperCase()
                      : 'U',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}