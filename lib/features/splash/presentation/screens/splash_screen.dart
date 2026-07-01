import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_duration.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/services/startup_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    final results = await Future.wait([
      Future.delayed(const Duration(seconds: 4)),
      StartupService.getInitialRoute(),
    ]);

    if (!mounted) return;

    final route = results[1] as String;

    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        body: SafeArea(
            child: Center(
              child: Padding(
                padding: AppSpacing.screenPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.account_balance_wallet_rounded,
                      size: 90,
                    ).animate().scale(duration: AppDurations.slow).fadeIn(),

                    const SizedBox(height: AppSpacing.lg),

                    Text(
                      AppStrings.tagline,
                      style: textTheme.bodyLarge,
                    ).animate(delay: 600.ms).fadeIn(),

                    const SizedBox(height: 50),

                    const SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                          strokeWidth: 2.5
                      ),
                    ).animate(delay: 900.ms).fadeIn(),
                  ],
                ),
              ),
            ),
        ),
    );
  }
}
