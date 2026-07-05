import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../shared/components/inputs/pocket_text_field.dart';
import '../../../../core/utils/validators.dart';

class AmountField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String>? onFieldSubmitted;

  const AmountField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return PocketTextField(
      controller: controller,
      focusNode: focusNode,
      label: 'Amount',
      hint: '0.00',
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
      prefixIcon: const Icon(Icons.currency_rupee),
      validator: Validators.amount,
      textInputAction: TextInputAction.next,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'^\d*\.?\d{0,2}'),
        ),
      ],
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}