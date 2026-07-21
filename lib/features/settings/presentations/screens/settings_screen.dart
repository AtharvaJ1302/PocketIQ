import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/colors/app_gradients.dart';
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
    final preferencesNotifier = ref.watch(preferencesProvider);
    final preferences = preferencesNotifier.preferences;
    final theme = Theme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;


    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? AppGradients.screenBackground
              : AppGradients.screenBackgroundLight,
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppSpacing.screenPadding,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Settings',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Manage your preferences and app settings.',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color:
                                theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary
                              .withValues(alpha: .12),
                          borderRadius:
                          BorderRadius.circular(18),
                        ),
                        child: Icon(
                          Icons.settings_rounded,
                          color: theme.colorScheme.primary,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverPadding(
                padding: AppSpacing.screenPadding.copyWith(top: 0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    /// Profile
                    SettingsSection(
                      title: 'Profile',
                      children: [
                        SettingsTile(
                          icon: Icons.person_outline_rounded,
                          accentColor: Colors.blue,
                          title: 'Name',
                          subtitle: 'Your display name',
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
                          accentColor: Colors.green,
                          title: 'Currency',
                          subtitle: 'Default currency',
                          value: 'INR',
                          enabled: false,
                        ),
                      ],
                    ),

                    /// Security
                    SettingsSection(
                      title: 'Security',
                      children: [
                        SettingsSwitchTile(
                          icon: Icons.lock_outline_rounded,
                          accentColor: Colors.green,
                          title: 'App Lock',
                          subtitle:
                          'Protect PocketIQ using biometrics',
                          value: preferences.appLockEnabled,
                          onChanged: (_) async {
                            if (!preferences.appLockEnabled) {
                              final success = await ref
                                  .read(appLockProvider)
                                  .unlock();

                              if (!success) return;
                            }

                            await preferencesNotifier
                                .toggleAppLock();
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
                          accentColor: Colors.red,
                          title: 'Reset App',
                          subtitle:
                          'Delete all accounts and transactions',
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
                        SettingsTile(
                          icon: Icons.info_outline_rounded,
                          accentColor: Colors.indigo,
                          title: 'PocketIQ',
                          subtitle:
                          'Offline Personal Finance Manager',
                          value: 'v1.0.0',
                          enabled: false,
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius:
                        BorderRadius.circular(28),
                        border: Border.all(
                          color: theme.colorScheme
                              .outlineVariant
                              .withValues(alpha: .45),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.green
                                  .withValues(alpha: .12),
                              borderRadius:
                              BorderRadius.circular(18),
                            ),
                            child: const Icon(
                              Icons.shield_outlined,
                              color: Colors.green,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your data stays private',
                                  style: theme
                                      .textTheme.titleMedium
                                      ?.copyWith(
                                    fontWeight:
                                    FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'PocketIQ stores all your financial data locally on your device. Nothing is uploaded to the cloud.',
                                  style: theme
                                      .textTheme.bodyMedium
                                      ?.copyWith(
                                    color: theme
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: AppSpacing.xxxl,
                    ),
                    SizedBox(
                      height: 40
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}