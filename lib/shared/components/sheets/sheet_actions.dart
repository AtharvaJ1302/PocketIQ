import 'package:flutter/material.dart';

import '../../../core/features/constants/app_spacing.dart';
import '../buttons/pocket_button.dart';

class SheetActions extends StatelessWidget {
  final VoidCallback onSave;

  final String label;

  const SheetActions({
    super.key,
    required this.onSave,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.xl,
      ),
      child: PocketButton(
        label: label,
        onPressed: onSave,
      ),
    );
  }
}