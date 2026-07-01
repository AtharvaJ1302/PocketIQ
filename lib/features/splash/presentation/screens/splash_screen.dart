import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_animation.dart';
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

    final splashController = ref.read(splashProvider);

    _animationController.addListener(() {
      splashController.updateStatus(
        _animationController.value,
      );
    });

    _animationController.forward().whenComplete(() async {
      // TODO:
      // final route = await StartupService.getInitialRoute();
      // if (!mounted) return;
      // context.go(route);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final splashController = ref.watch(splashProvider);

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
              controller: splashController,
            ),

            const SizedBox(height: 32),

            SplashFooter(
              controller: _animationController,
            ),
          ],
        ),
      ),
    );
  }
}