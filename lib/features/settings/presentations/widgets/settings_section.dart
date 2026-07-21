import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_radius.dart';
import '../../../../core/features/constants/app_spacing.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppSpacing.xxl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 6,
              bottom: 14,
            ),
            child: Text(
              title.toUpperCase(),
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.4,
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: AppRadius.borderRadiusXl,
              border: Border.all(
                color: theme.colorScheme.outlineVariant.withValues(
                  alpha: .45,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .04),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: List.generate(
                children.length,
                    (index) => Column(
                  children: [
                    children[index],

                    if (index != children.length - 1)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 92,
                          right: 18,
                        ),
                        child: Divider(
                          height: 1,
                          color: theme.colorScheme.outlineVariant
                              .withValues(alpha: .55),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}