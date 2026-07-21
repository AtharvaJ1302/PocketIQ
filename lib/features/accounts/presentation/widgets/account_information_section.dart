import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/utils/validators.dart';
import '../../../../shared/components/form/pocket_input_card.dart';
import '../../../../shared/components/form/pocket_card_accent.dart';
import '../../../../shared/components/inputs/pocket_text_field.dart';

class AccountInformationSection extends StatelessWidget {
  final bool isEditing;

  final TextEditingController accountNameController;
  final TextEditingController accountNumberController;

  final FocusNode accountNameFocusNode;
  final FocusNode accountNumberFocusNode;

  const AccountInformationSection({
    super.key,
    required this.isEditing,
    required this.accountNameController,
    required this.accountNumberController,
    required this.accountNameFocusNode,
    required this.accountNumberFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PocketInputCard(
          controller: accountNameController,
          focusNode: accountNameFocusNode,
          title: 'Account Alias',
          hintText: 'Salary Account',
          icon: Icons.badge_outlined,
          accent: PocketCardAccent.green,
          validator: Validators.requiredField,
          textInputAction: isEditing
              ? TextInputAction.done
              : TextInputAction.next,
          onFieldSubmitted: (_) {
            if (!isEditing) {
              accountNumberFocusNode.requestFocus();
            } else {
              FocusScope.of(context).unfocus();
            }
          },
        ),

        if (!isEditing) ...[
          const SizedBox(height: AppSpacing.lg),

          PocketInputCard(
            controller: accountNumberController,
            focusNode: accountNumberFocusNode,
            title: 'Account Number',
            hintText: '1234567890',
            icon: Icons.pin_outlined,
            accent: PocketCardAccent.orange,
            keyboardType: TextInputType.number,
            validator: Validators.accountNumber,
            textInputAction: TextInputAction.done,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onFieldSubmitted: (_) {
              FocusScope.of(context).unfocus();
            },
          ),
        ],
      ],
    );
  }
}