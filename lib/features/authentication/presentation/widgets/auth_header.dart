import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_spacing.dart';
import '../../../../shared/components/branding/app_logo.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        const AppLogo(size: 90),

        const SizedBox(
          height: AppSpacing.xl,
        ),

        Text(
          title,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),

        const SizedBox(
          height: AppSpacing.md,
        ),

        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 320,
            ),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),
          ),
        ),
      ],
    );
  }
}