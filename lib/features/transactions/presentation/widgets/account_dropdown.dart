import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/finance/bank_info.dart';
import '../../../../core/utils/validators.dart';
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
      label: 'Account',
      value: value,
      validator: Validators.dropdown,
      prefixIcon: const Icon(
        Icons.account_balance_outlined,
      ),
      onChanged: onChanged,

      // Dropdown menu (2 lines)
      items: notifier.accounts.map((account) {
        return DropdownMenuItem<String>(
          value: account.id,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
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

      // Selected value (1 line)
      selectedItemBuilder: (context) {
        return notifier.accounts.map((account) {
          return Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${account.accountName} •••• ${account.lastFourDigits}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList();
      },
    );
  }
}