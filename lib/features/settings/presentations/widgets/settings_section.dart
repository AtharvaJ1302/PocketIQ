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
      padding:
      const EdgeInsets.only(bottom: AppSpacing.xl),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.sm,
              bottom: AppSpacing.sm,
            ),
            child: Text(
              title.toUpperCase(),
              style: theme.textTheme.labelLarge
                  ?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),

          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius:
              AppRadius.borderRadiusLg,
            ),
            child: Column(
              children: List.generate(
                children.length,
                    (index) {
                  return Column(
                    children: [
                      children[index],

                      if (index !=
                          children.length - 1)
                        Divider(
                          height: 1,
                          indent: 72,
                          endIndent: 16,
                          color: theme.colorScheme
                              .outlineVariant,
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}