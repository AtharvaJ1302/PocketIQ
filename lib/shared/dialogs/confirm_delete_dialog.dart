import 'package:flutter/material.dart';

import '../../../core/features/constants/app_radius.dart';
import '../../../core/features/constants/app_spacing.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onDelete;

  const ConfirmDeleteDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      backgroundColor: theme.colorScheme.surfaceContainer,

      elevation: 12,

      shadowColor: Colors.black.withValues(
        alpha: .25,
      ),

      insetPadding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.borderRadiusXl,
        side: BorderSide(
          color: theme.colorScheme.outline.withValues(
            alpha: .12,
          ),
        ),
      ),

      titlePadding: const EdgeInsets.fromLTRB(
        24,
        24,
        24,
        0,
      ),

      contentPadding: const EdgeInsets.fromLTRB(
        24,
        20,
        24,
        0,
      ),

      actionsPadding: const EdgeInsets.fromLTRB(
        24,
        0,
        24,
        24,
      ),

      title: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: .12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.red,
              size: 34,
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),

      content: Text(
        message,
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          height: 1.5,
        ),
      ),

      actions: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF7C5CFF),
                      Color(0xFF5B4DFF),
                    ],
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => Navigator.pop(context),
                    child: const Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: AppSpacing.md),

            Expanded(
              child: SizedBox(
                height: 50,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(
                      0xFFFF3B30,
                    ),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    onDelete();
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}