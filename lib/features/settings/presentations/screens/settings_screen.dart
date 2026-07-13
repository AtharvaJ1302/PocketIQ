import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/features/constants/app_spacing.dart';
import '../../../../shared/components/sheets/pocket_bottom_sheet.dart';
import '../../../security/presentation/providers/app_lock_provider.dart';
import '../../../setup/presentation/providers/preferences_provider.dart';
import '../widgets/edit_name_sheet.dart';
import '../widgets/reset_app_dialog.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_switch_tile.dart';
import '../widgets/settings_tile.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferencesNotifier =
    ref.watch(preferencesProvider);

    final preferences =
        preferencesNotifier.preferences;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          /// Profile
          SettingsSection(
            title: 'Profile',
            children: [
              SettingsTile(
                icon: Icons.person_outline_rounded,
                title: 'Name',
                value: preferences.userName,
                onTap: () {
                  PocketBottomSheet.show(
                    context: context,
                    title: 'Change Name',
                    description:
                    'This name will be shown on your dashboard.',
                    child: const EditNameSheet(),
                  );
                },
              ),
              SettingsTile(
                icon: Icons.currency_rupee_rounded,
                title: 'Currency',
                value: 'INR',
                enabled: false,
              ),
            ],
          ),

          // Security
          SettingsSection(
            title: 'Security',
            children: [
              SettingsSwitchTile(
                icon: Icons.lock_outline_rounded,
                title: 'App Lock',
                value: preferences.appLockEnabled,
                onChanged: (_) async {
                  if (!preferences.appLockEnabled) {
                    final success = await ref
                        .read(appLockProvider)
                        .unlock();

                    if (!success) {
                      return;
                    }
                  }

                  await preferencesNotifier.toggleAppLock();
                },
              ),
            ],
          ),

          /// Display
          SettingsSection(
            title: 'Display',
            children: [
              SettingsSwitchTile(
                icon: Icons.visibility_outlined,
                title: 'Hide Balance',
                value: preferences.hideBalance,
                onChanged: (_) async {
                  await preferencesNotifier.toggleHideBalance();
                },
              ),
            ],
          ),

          /// Data
          SettingsSection(
            title: 'Data',
            children: [
              SettingsTile(
                icon: Icons.delete_outline_rounded,
                title: 'Reset App',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) =>
                    const ResetAppDialog(),
                  );
                },
              ),
            ],
          ),

          /// About
          SettingsSection(
            title: 'About',
            children: const [
              ListTile(
                leading: Icon(
                  Icons.info_outline_rounded,
                ),
                title: Text(
                  'PocketIQ',
                ),
                subtitle: Text(
                  'Version 1.0.0',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}