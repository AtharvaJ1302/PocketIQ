import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/features/constants/app_animation.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../setup/presentation/providers/preferences_provider.dart';
import '../providers/splash_provider.dart';
import '../widgets/splash_background.dart';
import '../widgets/splash_footer.dart';
import '../widgets/splash_loading.dart';
import '../widgets/splash_logo.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {

  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: AppAnimation.splashDuration,
    );

    final splashNotifier = ref.read(
      splashProvider,
    );

    _animationController.addListener(() {
      splashNotifier.updateStatus(
        _animationController.value,
      );
    });

    _startApp();
  }

  Future<void> _startApp() async {
    await _animationController.forward();

    if (!mounted) return;

    final preferencesNotifier =
    ref.read(preferencesProvider);

    await preferencesNotifier.loadPreferences();

    if (!mounted) return;

    final preferences =
        preferencesNotifier.preferences;

    if (!preferences.onboardingCompleted) {
      context.go(
        AppRoutes.onboarding,
      );
      return;
    }

    if (preferences.appLockEnabled) {
      // App Lock screen
      context.go(
        AppRoutes.home,
      );
      return;
    }

    context.go(
      AppRoutes.home,
    );
  }

  // Future<void> _startApp() async {
  //   await _animationController.forward();
  //
  //   if (!mounted) return;
  //
  //   try {
  //     final preferencesNotifier =
  //     ref.read(preferencesProvider);
  //
  //     await preferencesNotifier.loadPreferences();
  //
  //     debugPrint('Preferences loaded successfully');
  //
  //     if (!mounted) return;
  //
  //     context.go(AppRoutes.onboarding);
  //   } catch (e, stackTrace) {
  //     debugPrint(e.toString());
  //     debugPrint(stackTrace.toString());
  //
  //     rethrow;
  //   }
  // }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(
      splashProvider,
    );

    return Scaffold(
      body: SplashBackground(
        child: Column(
          children: [
            const Spacer(
              flex: 3,
            ),

            SplashLogo(
              controller: _animationController,
            ),

            const Spacer(
              flex: 2,
            ),

            SplashLoading(
              animationController:
              _animationController,
              controller: notifier,
            ),

            const SizedBox(
              height: AppSpacing.xl,
            ),

            SplashFooter(
              controller: _animationController,
            ),
          ],
        ),
      ),
    );
  }
}