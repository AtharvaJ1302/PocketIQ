import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/colors/app_gradients.dart';
import '../../../../core/features/services/local_notification_service.dart';
import '../../../../shared/components/buttons/pocket_button.dart';
import '../../../../shared/components/cards/pocket_surface.dart';
import '../providers/preferences_provider.dart';

class NotificationPermissionSheet
    extends ConsumerStatefulWidget {
  const NotificationPermissionSheet({
    super.key,
  });

  @override
  ConsumerState<NotificationPermissionSheet>
  createState() =>
      _NotificationPermissionSheetState();
}

class _NotificationPermissionSheetState
    extends ConsumerState<
        NotificationPermissionSheet> {

  Future<void> _enableNotifications() async {
    final granted =
    await LocalNotificationService.instance
        .requestPermission();

    final notifier =
    ref.read(preferencesProvider);

    await notifier.updatePreferences(
      notifier.preferences.copyWith(
        notificationPermissionAsked: true,
        notificationsEnabled: granted,
      ),
    );

    if (mounted) {
      Navigator.pop(context, granted);
    }
  }

  Future<void> _skip() async {
    final notifier =
    ref.read(preferencesProvider);

    await notifier.updatePreferences(
      notifier.preferences.copyWith(
        notificationPermissionAsked: true,
        notificationsEnabled: false,
      ),
    );

    if (mounted) {
      Navigator.pop(context, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: dark
            ? AppGradients.darkBackground
            : AppGradients.lightBackground,
        borderRadius:
        const BorderRadius.vertical(
          top: Radius.circular(36),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 16,
            bottom:
            MediaQuery.of(context)
                .viewInsets
                .bottom +
                24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              /// Handle
              // Container(
              //   width: 48,
              //   height: 5,
              //   decoration: BoxDecoration(
              //     color: Colors.white24,
              //     borderRadius:
              //     BorderRadius.circular(50),
              //   ),
              // ),

              const SizedBox(height: 24),

              Image.asset(
                "assets/images/setup/setup_2.png",
                height: 140,
              ),

              const SizedBox(height: 32),

              Text(
                "Never miss a budget.",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(
                  fontWeight:
                  FontWeight.w800,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                "PocketIQ can remind you before you\nexceed your budget, helping you stay in\ncontrol of your finances\n\n Later, you can choose which budgets should receive alerts.",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(
                  height: 1.6,
                  color: dark
                      ? Colors.white70
                      : Colors.black54,
                ),
              ),

              const SizedBox(height: 28),

              // PocketSurface(
              //   glow: true,
              //   bordered: false,
              //   padding: EdgeInsets.zero,
              //   child: ClipRRect(
              //     borderRadius:
              //     BorderRadius.circular(28),
              //     child: Image.asset(
              //       "assets/images/setup/setup_3.png",
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              // Image.asset(
              //   "assets/images/setup/setup_3.png",
              //   fit: BoxFit.cover,
              // ),

              const SizedBox(height: 36),

              PocketButton(
                label:
                "Enable Notifications",
                icon:
                Icons.notifications_active,
                onPressed:
                _enableNotifications,
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: _skip,
                child: const Text(
                  "Skip for now",
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}