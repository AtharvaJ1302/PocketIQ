import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_animation.dart';
import '../../../../core/constants/app_spacing.dart';
import '../providers/splash_provider.dart';
import '../widgets/splash_background.dart';
import '../widgets/splash_footer.dart';
import '../widgets/splash_loading.dart';
import '../widgets/splash_logo.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: AppAnimation.splashDuration,
    );

    final splashNotifier = ref.read(splashProvider);

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

    // TODO:
    // final route = await StartupService.getInitialRoute();
    // context.go(route);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(splashProvider);

    return Scaffold(
      body: SplashBackground(
        child: Column(
          children: [
            const Spacer(flex: 3),

            SplashLogo(
              controller: _animationController,
            ),

            const Spacer(flex: 2),

            SplashLoading(
              animationController: _animationController,
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