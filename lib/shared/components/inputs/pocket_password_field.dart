import 'package:flutter/material.dart';

import 'pocket_text_field.dart';

class PocketPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;

  const PocketPasswordField({
    super.key,
    required this.controller,
    this.label = 'Password',
    this.validator,
    this.textInputAction = TextInputAction.done,
    this.onFieldSubmitted,
    this.focusNode,
  });

  @override
  State<PocketPasswordField> createState() =>
      _PocketPasswordFieldState();
}

class _PocketPasswordFieldState
    extends State<PocketPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return PocketTextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      label: widget.label,
      hint: 'Enter your password',
      obscureText: _obscureText,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      keyboardType: TextInputType.visiblePassword,
      prefixIcon: const Icon(Icons.lock_outline),
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        icon: Icon(
          _obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
        ),
      ),
    );
  }
}