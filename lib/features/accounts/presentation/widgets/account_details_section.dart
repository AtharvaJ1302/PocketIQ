import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/finance/account_types.dart';
import '../../../../core/features/finance/bank_info.dart';
import '../../../../core/features/utils/validators.dart';
import '../../../../shared/components/dropdown/pocket_dropdown.dart';
import '../../../../shared/components/form/pocket_card_accent.dart';
import '../../../../shared/components/form/pocket_dropdown_card.dart';
import '../../../../shared/components/info/info_tile.dart';

class AccountDetailsSection extends StatelessWidget {
  final bool isEditing;

  final String? selectedBank;
  final String? selectedAccountType;

  final ValueChanged<String?> onBankChanged;
  final ValueChanged<String?> onAccountTypeChanged;

  final String? bankCode;
  final String? accountType;
  final String? lastFourDigits;

  const AccountDetailsSection({
    super.key,
    required this.isEditing,
    required this.selectedBank,
    required this.selectedAccountType,
    required this.onBankChanged,
    required this.onAccountTypeChanged,
    this.bankCode,
    this.accountType,
    this.lastFourDigits,
  });

  @override
  Widget build(BuildContext context) {
    if (!isEditing) {
      return Column(
        children: [
          PocketDropdownCard<String>(
            title: 'Bank',
            hint: 'Select Account',
            value: selectedBank,
            icon: Icons.account_balance_outlined,
            accent: PocketCardAccent.blue,
            validator: Validators.dropdown,
            onChanged: onBankChanged,
            items: BankInfo.supportedBanks
                .map(
                  (bank) => DropdownMenuItem(
                value: bank,
                child: Text(BankInfo.getName(bank)),
              ),
            )
                .toList(),
          ),

          const SizedBox(height: AppSpacing.lg),

          PocketDropdownCard<String>(
            title: 'Account Type',
            hint: 'Select Account Type',
            value: selectedAccountType,
            icon: Icons.credit_card_outlined,
            accent: PocketCardAccent.purple,
            validator: Validators.dropdown,
            onChanged: onAccountTypeChanged,
            items: AccountTypes.values
                .map(
                  (type) => DropdownMenuItem(
                value: type,
                child: Text(type),
              ),
            )
                .toList(),
          ),
        ],
      );
    }

    return Column(
      children: [
        InfoTile(
          icon: Icons.account_balance_outlined,
          label: 'Bank',
          value: BankInfo.getName(bankCode!),
        ),

        const SizedBox(height: AppSpacing.md),

        InfoTile(
          icon: Icons.credit_card_outlined,
          label: 'Account Type',
          value: accountType!,
        ),

        const SizedBox(height: AppSpacing.md),

        InfoTile(
          icon: Icons.pin_outlined,
          label: 'Account Number',
          value: '•••• $lastFourDigits',
        ),
      ],
    );
  }
}