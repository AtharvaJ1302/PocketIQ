import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_spacing.dart';
import '../providers/account_provider.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(accountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Accounts'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO:
          // Navigate to Add Account
        },
        child: const Icon(Icons.add),
      ),
        body: notifier.loading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : notifier.accounts.isEmpty
            ? const Center(
          child: Text(
            'No accounts added yet.',
          ),
        )
            : ListView.separated(
          padding: AppSpacing.screenPadding,
          itemCount: notifier.accounts.length,
          separatorBuilder: (_, __) =>
          const SizedBox(height: AppSpacing.md),
          itemBuilder: (_, index) {
            final account = notifier.accounts[index];

            return ListTile(
              leading: const CircleAvatar(
                child: Icon(
                  Icons.account_balance,
                ),
              ),
              title: Text(account.bankName),
              subtitle: Text(
                '${account.accountName} •••• ${account.lastFourDigits}',
              ),
              trailing: Text(
                '₹${account.balance.toStringAsFixed(2)}',
              ),
            );
          },
        ),
    );
  }
}