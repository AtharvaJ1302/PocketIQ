import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/features/constants/app_spacing.dart';
import '../../../setup/presentation/providers/preferences_provider.dart';
import '../providers/home_provider.dart';

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final home = ref.watch(homeProvider);

    final preferencesNotifier =
    ref.watch(preferencesProvider);

    return Padding(
      padding: AppSpacing.screenPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  home.greeting,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(
                  height: AppSpacing.xs,
                ),

                Text(
                  '${preferencesNotifier.preferences.userName} 👋',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),

          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme
                  .surfaceContainerHighest
                  .withValues(alpha: .35),
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.outline
                    .withValues(alpha: .12),
              ),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none_rounded,
              ),
            ),
          ),
        ],
      ),
    );
  }
}