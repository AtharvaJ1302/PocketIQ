import 'package:flutter/material.dart';

import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_sizes.dart';

class PocketButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final IconData? icon;

  const PocketButton({
    super.key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: loading ? null : onPressed,
      style: FilledButton.styleFrom(
        minimumSize: const Size(
          double.infinity,
          AppSizes.buttonHeight,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius:
          AppRadius.borderRadiusMd,
        ),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(
          milliseconds: 250,
        ),
        child: loading
            ? const SizedBox(
          width: 22,
          height: 22,
          child:
          CircularProgressIndicator(
            strokeWidth: 2.4,
          ),
        )
            : Row(
          mainAxisSize:
          MainAxisSize.min,
          children: [
            Text(label),

            if (icon != null) ...[
              const SizedBox(
                width: 8,
              ),
              Icon(icon, size: 18),
            ]
          ],
        ),
      ),
    );
  }
}