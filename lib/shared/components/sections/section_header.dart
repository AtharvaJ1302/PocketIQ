import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../inputs/pocket_text_button.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onPressed;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: AppSpacing.screenPadding,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          if (actionText != null)
            PocketTextButton(
              label: actionText!,
              onPressed: onPressed,
            ),
        ],
      ),
    );
  }
}