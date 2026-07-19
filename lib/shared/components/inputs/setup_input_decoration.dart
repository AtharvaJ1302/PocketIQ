import 'package:flutter/material.dart';

class SetupInputDecoration {
  SetupInputDecoration._();

  static InputDecoration build(
      BuildContext context, {
        required String hint,
      }) {
    final theme = Theme.of(context);

    return InputDecoration(
      hintText: hint,

      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,

      filled: false,
      fillColor: Colors.transparent,

      isDense: true,

      contentPadding: EdgeInsets.zero,

      hintStyle: theme.textTheme.titleMedium?.copyWith(
        color: theme.hintColor.withOpacity(.8),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}