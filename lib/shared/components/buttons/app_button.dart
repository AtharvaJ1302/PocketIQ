import 'package:flutter/material.dart';
import 'package:pocketiq/shared/components/inputs/app_text.dart';

import '../../../core/features/constants/app_sizes.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: FilledButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: icon == null ? const SizedBox.shrink() : Icon(icon),
        label: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : AppText(text),
      ),
    );
  }
}
