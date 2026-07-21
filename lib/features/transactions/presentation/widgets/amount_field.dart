import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/features/utils/validators.dart';

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
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [

        Transform.translate(
          offset: const Offset(0, -8),
          child: Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Text(
              "₹",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ),

        ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 120,
            maxWidth: 280,
          ),
          child: IntrinsicWidth(
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              validator: Validators.amount,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.next,
              style: theme.textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -3,
                height: 1,
              ),
              cursorWidth: 2.5,
              cursorHeight: 52,
              decoration: const InputDecoration(
                filled: false,
                fillColor: Colors.transparent,
                hintText: "0.00",
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*\.?\d{0,2}'),
                ),
              ],
              onFieldSubmitted: onFieldSubmitted,
            ),
          ),
        ),
      ],
    );
  }
}