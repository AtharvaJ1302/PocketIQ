import 'package:flutter/material.dart';

import '../../../core/features/constants/app_spacing.dart';

class PocketBottomSheet {
  PocketBottomSheet._();

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    String? description,
    required Widget child,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor:
      Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (_) {
        final theme = Theme.of(context);

        return Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.sm,
            bottom:
            MediaQuery.of(context).viewInsets.bottom +
                AppSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              if (description != null) ...[
                const SizedBox(height: AppSpacing.xs),

                Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],

              const SizedBox(height: AppSpacing.xl),

              child,
            ],
          ),
        );
      },
    );
  }
}