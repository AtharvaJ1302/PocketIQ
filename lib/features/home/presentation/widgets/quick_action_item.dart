import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_radius.dart';
import '../../../../core/features/constants/app_spacing.dart';

class QuickActionItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final VoidCallback onPressed;

  const QuickActionItem({
    super.key,
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  State<QuickActionItem> createState() => _QuickActionItemState();
}

class _QuickActionItemState extends State<QuickActionItem> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _pressed ? 0.96 : 1,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: AppRadius.borderRadiusLg,

            onTapDown: (_) {
              setState(() => _pressed = true);
            },

            onTapCancel: () {
              setState(() => _pressed = false);
            },

            onTapUp: (_) {
              setState(() => _pressed = false);
            },

            onTap: widget.onPressed,

            child: Ink(
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.xl,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainer,
                borderRadius: AppRadius.borderRadiusLg,
                border: Border.all(
                  color: theme.colorScheme.outline.withOpacity(0.15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: widget.iconColor.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      widget.icon,
                      size: 28,
                      color: widget.iconColor,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  Text(
                    widget.label,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}