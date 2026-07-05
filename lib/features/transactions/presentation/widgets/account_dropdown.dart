import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketiq/core/utils/validators.dart';

import '../../../../core/finance/bank_info.dart';
import '../../../../shared/components/dropdown/pocket_dropdown.dart';
import '../../../accounts/presentation/providers/account_provider.dart';

class AccountDropdown extends ConsumerWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const AccountDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(accountProvider);

    return PocketDropdown<String>(
      validator: Validators.dropdown,
      label: 'Account',
      value: value,
      prefixIcon: const Icon(
        Icons.account_balance_outlined,
      ),
      onChanged: onChanged,
      items: notifier.accounts.map((account) {
        return DropdownMenuItem(
          value: account.id,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                account.accountName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${BankInfo.getName(account.bankCode)} •••• ${account.lastFourDigits}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}