import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/components/buttons/pocket_button.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/services/local_notification_service.dart';
import '../providers/preferences_provider.dart';

class NotificationPermissionSheet
    extends ConsumerWidget {
  const NotificationPermissionSheet({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom:
        MediaQuery.of(context)
            .viewInsets
            .bottom +
            24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Icon(
            Icons.notifications_active_rounded,
            size: 72,
            color: Theme.of(context)
                .colorScheme
                .primary,
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          Text(
            'Budget Alerts',
            style: Theme.of(context)
                .textTheme
                .headlineSmall,
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          Text(
            'PocketIQ can notify you when you are approaching or exceeding your budgets.\n\n'
                'Later, you can choose which individual budgets should receive notifications.',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge,
          ),

          const SizedBox(
            height: AppSpacing.xxxl,
          ),

          PocketButton(
            label: 'Enable Alerts',
            onPressed: () async {

              final granted =
              await LocalNotificationService
                  .instance
                  .requestPermission();

              final notifier =
              ref.read(
                preferencesProvider,
              );

              await notifier.updatePreferences(
                notifier.preferences.copyWith(
                  notificationPermissionAsked: true,
                  notificationsEnabled: granted,
                ),
              );

              if (context.mounted) {
                Navigator.pop(
                  context,
                  granted,
                );
              }
            },
          ),

          TextButton(
            onPressed: () async {

              final notifier =
              ref.read(
                preferencesProvider,
              );

              await notifier.updatePreferences(
                notifier.preferences.copyWith(
                  notificationPermissionAsked: true,
                  notificationsEnabled: false,
                ),
              );

              if (context.mounted) {
                Navigator.pop(
                  context,
                  false,
                );
              }
            },
            child: const Text(
              'Not Now',
            ),
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),
        ],
      ),
    );
  }
}