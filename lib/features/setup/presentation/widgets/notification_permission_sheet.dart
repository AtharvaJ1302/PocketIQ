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
    return SafeArea(
      child: SingleChildScrollView(
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

          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_active_rounded,
              size: 72,
              color: Theme.of(context)
                  .colorScheme
                  .primary,
            ),
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
            'PocketIQ can remind you before you exceed your budget, helping you stay in control of your finances.\n\n'
                'Later, you can choose which individual budgets should receive notifications.',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge,
          ),

          const SizedBox(
            height: AppSpacing.xl,
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
      ),
    );
  }
}