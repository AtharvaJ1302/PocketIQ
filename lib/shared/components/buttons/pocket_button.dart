import 'package:flutter/material.dart';

import '../../../core/features/constants/app_radius.dart';
import '../../../core/features/constants/app_sizes.dart';

class PocketButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const PocketButton({
    super.key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: Material(
        color: Colors.transparent,
        borderRadius: AppRadius.borderRadiusMd,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: AppRadius.borderRadiusMd,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff6D5BFF),
                Color(0xff7D6DFF),
                Color(0xff8C7DFF),
              ],
            ),
          ),
          child: InkWell(
            borderRadius: AppRadius.borderRadiusMd,
            splashColor: Colors.white.withOpacity(.12),
            highlightColor: Colors.white.withOpacity(.05),
            onTap: loading ? null : onPressed,
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: loading
                    ? const SizedBox(
                  key: ValueKey("loading"),
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.4,
                    valueColor: AlwaysStoppedAnimation(
                      Colors.white,
                    ),
                  ),
                )
                    : Row(
                  key: const ValueKey("normal"),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    if (icon != null) ...[
                      const SizedBox(width: 8),
                      Icon(
                        icon,
                        size: 18,
                        color: Colors.white,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}