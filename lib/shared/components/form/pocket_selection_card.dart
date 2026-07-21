import 'package:flutter/material.dart';

import '../../../core/features/constants/app_spacing.dart';

class PocketSelectionCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  final bool enabled;
  final Widget? trailing;
  final bool showChevron;

  const PocketSelectionCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.onTap,
    this.enabled = true,
    this.trailing,
    this.showChevron = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: enabled ? onTap : null,
        child: Ink(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: theme.colorScheme.outlineVariant.withValues(alpha: .18),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 24,
                offset: const Offset(0, 10),
                color: Colors.black.withValues(alpha: .08),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: .16),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),

              const SizedBox(width: 18),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              trailing ??
                  (showChevron
                      ? Icon(
                    Icons.chevron_right_rounded,
                    color: theme.colorScheme.onSurfaceVariant,
                  )
                      : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}