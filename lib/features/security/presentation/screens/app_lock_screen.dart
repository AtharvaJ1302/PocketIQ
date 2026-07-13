import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../shared/components/buttons/pocket_button.dart';
import '../providers/app_lock_provider.dart';

class AppLockScreen extends ConsumerStatefulWidget {
  const AppLockScreen({super.key});

  @override
  ConsumerState<AppLockScreen> createState() =>
      _AppLockScreenState();
}

class _AppLockScreenState
    extends ConsumerState<AppLockScreen> {

  bool _showUnlockButton = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      _unlock();
    });
  }

  Future<void> _unlock() async {
    final notifier = ref.read(appLockProvider);

    final success = await notifier.unlock();

    if (!mounted) return;

    if (success) {
      context.go(AppRoutes.main);
      return;
    }

    setState(() {
      _showUnlockButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier =
    ref.watch(appLockProvider);

    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: AppSpacing.screenPadding,
            child: Center(
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fingerprint_rounded,
                    size: 90,
                    color:
                    theme.colorScheme.primary,
                  ),

                  const SizedBox(
                    height: AppSpacing.xl,
                  ),

                  Text(
                    'Welcome Back',
                    style: theme
                        .textTheme.headlineMedium,
                  ),

                  const SizedBox(
                    height: AppSpacing.md,
                  ),

                  Text(
                    'Unlock PocketIQ using your fingerprint or device credential.',
                    textAlign: TextAlign.center,
                    style: theme
                        .textTheme.bodyLarge,
                  ),

                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: _showUnlockButton
                        ? AppSpacing.xxxl
                        : AppSpacing.lg,
                  ),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: !_showUnlockButton
                        ? const SizedBox.shrink()
                        : PocketButton(
                      key: const ValueKey('unlock'),
                      label: 'Unlock',
                      loading: notifier.loading,
                      onPressed:
                      notifier.loading ? null : _unlock,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}