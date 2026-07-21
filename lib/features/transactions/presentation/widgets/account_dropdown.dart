import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/features/finance/bank_info.dart';
import '../../../../core/features/utils/validators.dart';
import '../../../../shared/components/dropdown/pocket_dropdown.dart';
import '../../../accounts/presentation/providers/account_provider.dart';

class AccountDropdown extends ConsumerWidget {
  final String? value;
  final ValueChanged<String?> onChanged;
  final bool enabled;

  const AccountDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(accountProvider);
    final theme = Theme.of(context);

    return PocketDropdown<String>(
      label: enabled ? 'Account' : 'Selected Account',
      value: value,
      validator: Validators.dropdown,
      onChanged: enabled ? onChanged : null,

      decoration: InputDecoration(
        // labelText: enabled ? 'Account' : 'Selected Account',
        hintText: 'Select Account',

        filled: true,
        fillColor: theme.colorScheme.surface,

        prefixIcon: Icon(
          Icons.account_balance_outlined,
          color: theme.colorScheme.primary,
        ),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: theme.colorScheme.outlineVariant,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: theme.colorScheme.outlineVariant,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 1.6,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: theme.colorScheme.error,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: theme.colorScheme.error,
            width: 1.6,
          ),
        ),
      ),

        items: notifier.accounts.map((account) {
          return DropdownMenuItem<String>(
            value: account.id,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.account_balance_rounded,
                      size: 20,
                      color: theme.colorScheme.primary,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          account.accountName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${BankInfo.getName(account.bankCode)} •••• ${account.lastFourDigits}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),

        selectedItemBuilder: (context) {
          return notifier.accounts.map((account) {
            return Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${account.accountName}       •••• ${account.lastFourDigits}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList();
        }
    );
  }
}