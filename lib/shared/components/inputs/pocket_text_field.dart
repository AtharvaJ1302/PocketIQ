import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/features/constants/app_radius.dart';
import '../../../core/features/constants/app_spacing.dart';

class PocketTextField extends StatelessWidget {
  final TextEditingController controller;

  final String? label;
  final String? hint;

  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final bool enabled;
  final bool autofocus;
  final bool obscureText;
  final bool readOnly;

  final int maxLines;
  final int? maxLength;

  final FocusNode? focusNode;

  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;

  final List<TextInputFormatter>? inputFormatters;

  final InputDecoration? decoration;


  const PocketTextField({
    super.key,
    required this.controller,
    // required this.label,
    this.hint,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.autofocus = false,
    this.obscureText = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.focusNode,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.decoration,
    this.label,
  });

  @override
  Widget build(BuildContext context) {

    final defaultDecoration = InputDecoration(
      labelText: label,
      hintText: hint,

      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,

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
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderRadiusMd,
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderRadiusMd,
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error,
          width: 2,
        ),
      ),
    );

    return TextFormField(
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),

      cursorColor: Theme.of(context).colorScheme.primary,

      controller: controller,
      focusNode: focusNode,

      enabled: enabled,
      autofocus: autofocus,
      obscureText: obscureText,
      readOnly: readOnly,

      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,

      maxLines: obscureText ? 1 : maxLines,
      maxLength: maxLength,

      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,

      decoration: defaultDecoration.copyWith(
        // labelText: decoration?.labelText,
        hintText: decoration?.hintText,
        helperText: decoration?.helperText,
        errorText: decoration?.errorText,

        prefixIcon: decoration?.prefixIcon,
        suffixIcon: decoration?.suffixIcon,

        border: decoration?.border,
        enabledBorder: decoration?.enabledBorder,
        focusedBorder: decoration?.focusedBorder,
        errorBorder: decoration?.errorBorder,
        focusedErrorBorder: decoration?.focusedErrorBorder,

        filled: decoration?.filled,
        fillColor: decoration?.fillColor,

        contentPadding: decoration?.contentPadding,

        counterText: decoration?.counterText,

        labelText: label,
      ),
    );
  }
}