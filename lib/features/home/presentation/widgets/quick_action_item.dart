import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_radius.dart';

class QuickActionItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final VoidCallback onPressed;

  const QuickActionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
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

    final isDark = theme.brightness == Brightness.dark;

    return AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _pressed ? 0.95 : 1,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: AppRadius.borderRadiusLg,
            onTap: widget.onPressed,
            onTapDown: (_) => setState(() => _pressed = true),
            onTapUp: (_) => setState(() => _pressed = false),
            onTapCancel: () => setState(() => _pressed = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              height: 125,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: isDark
                    ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF18233E),
                    Color(0xFF111827),
                  ],
                )
                    : null,
                color: isDark ? null : Colors.white,
                border: Border.all(
                  color: Colors.white.withValues(alpha: .06),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.iconColor.withValues(alpha: .18),
                      ),
                      child: Icon(
                        widget.icon,
                        size: 22,
                        color: widget.iconColor,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      widget.subtitle,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 10,
                        color: theme.colorScheme.onSurface.withValues(alpha: .60),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ),
        ),
      );
  }
}