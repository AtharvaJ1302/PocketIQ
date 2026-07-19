import 'package:flutter/material.dart';

import '../../../core/features/constants/app_radius.dart';
import '../../../core/features/constants/app_spacing.dart';

class PocketDropdown<T> extends StatelessWidget {
  final String label;

  final T? value;

  final List<DropdownMenuItem<T>> items;

  final ValueChanged<T?>? onChanged;

  final String? Function(T?)? validator;

  final Widget? prefixIcon;

  final bool enabled;

  final DropdownButtonBuilder? selectedItemBuilder;

  /// Optional custom decoration.
  /// If null, the default Pocket decoration is used.
  final InputDecoration? decoration;

  const PocketDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.enabled = true,
    this.selectedItemBuilder,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final defaultDecoration = InputDecoration(
      labelText: label,

      prefixIcon: prefixIcon,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),

      border: const OutlineInputBorder(
        borderRadius: AppRadius.borderRadiusMd,
      ),

      enabledBorder: const OutlineInputBorder(
        borderRadius: AppRadius.borderRadiusMd,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderRadiusMd,
        borderSide: BorderSide(
          color: theme.colorScheme.primary,
          width: 2,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderRadiusMd,
        borderSide: BorderSide(
          color: theme.colorScheme.error,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderRadiusMd,
        borderSide: BorderSide(
          color: theme.colorScheme.error,
          width: 2,
        ),
      ),
    );

    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      selectedItemBuilder: selectedItemBuilder,
      onChanged: enabled ? onChanged : null,
      validator: validator,
      isExpanded: true,
      style: theme.textTheme.bodyLarge,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      decoration: decoration ?? defaultDecoration,
    );
  }
}