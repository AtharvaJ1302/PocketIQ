import 'package:flutter/material.dart';

import '../../../../core/constants/app_animation.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/startup_strings.dart';
import '../../../../shared/components/pocket_progress_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  String startupStatus = StartupStrings.initializing;
  late final AnimationController _controller;


  @override
  void initState() {
    super.initState();
    // _changeStatus();
    _controller = AnimationController(
      vsync: this,
      duration: AppAnimation.splashDuration,
    );

    _controller.addListener(() {
      final value = _controller.value;

      if (value < .25) {
        startupStatus = StartupStrings.initializing;
      } else if (value < .50) {
        startupStatus = StartupStrings.loadingPreferences;
      } else if (value < .75) {
        startupStatus = StartupStrings.checkingAuthentication;
      } else if (value < .95) {
        startupStatus = StartupStrings.preparingDashboard;
      } else {
        startupStatus = StartupStrings.almostReady;
      }

      setState(() {});
    });

    _controller.forward().whenComplete(() {
      // TODO:
      // await StartupService.getInitialRoute();
      // context.go(route);
    });
  }

  // Future<void> _changeStatus() async {
  //   await Future.delayed(const Duration(seconds: 1));
  //
  //   if (!mounted) return;
  //   setState(() {
  //     startupStatus = StartupStrings.loadingPreferences;
  //   });
  //
  //   await Future.delayed(const Duration(seconds: 1));
  //
  //   if (!mounted) return;
  //   setState(() {
  //     startupStatus = StartupStrings.checkingAuthentication;
  //   });
  //
  //   await Future.delayed(const Duration(seconds: 1));
  //
  //   if (!mounted) return;
  //   setState(() {
  //     startupStatus = StartupStrings.preparingDashboard;
  //   });
  //
  //   await Future.delayed(const Duration(milliseconds: 700));
  //
  //   if (!mounted) return;
  //   setState(() {
  //     startupStatus = StartupStrings.almostReady;
  //   });
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? const [
              Color(0xff111827),
              Color(0xff020617),
            ]
                : const [
              Colors.white,
              Color(0xffEEF6FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: AppSpacing.screenPadding,
            child: Column(
              children: [
                const Spacer(flex: 3),

                ScaleTransition(
                  scale: Tween<double>(
                    begin: .85,
                    end: 1,
                  ).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: AppAnimation.logoInterval,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: isDark
                          ? [
                        BoxShadow(
                          color: const Color(0xff06B6D4).withValues(alpha: 0.20),
                          blurRadius: 40,
                          spreadRadius: 4,
                        ),
                      ]
                          : [],
                    ),
                    child: Image.asset(
                      isDark
                          ? AppAssets.logoLight
                          : AppAssets.logoDark,
                      height: 145,
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _controller,
                    curve: AppAnimation.titleInterval,
                  ),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, .15),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: AppAnimation.titleInterval,
                      ),
                    ),
                  child: Text(
                    AppStrings.appName,
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                ),

                const SizedBox(height: AppSpacing.sm),

                FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _controller,
                    curve: AppAnimation.taglineInterval,
                  ),
                  child: Text(
                    AppStrings.tagline,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                // TweenAnimationBuilder<double>(
                //   tween: Tween(begin: 0, end: 1),
                //   duration: const Duration(seconds: 4),
                //   curve: Curves.easeInOut,
                //   builder: (context, value, child) {
                //     return PocketProgressBar(
                //       progress: value,
                //     );
                //   },
                // ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    return PocketProgressBar(
                      progress: AppAnimation.progressInterval
                          .transform(_controller.value),
                    );
                  },
                ),

                const SizedBox(height: AppSpacing.md),

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    startupStatus,
                    key: ValueKey(startupStatus),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _controller,
                    curve: AppAnimation.footerInterval,
                  ),
                  child: Text(
                    'Version 0.1.0',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.75),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}