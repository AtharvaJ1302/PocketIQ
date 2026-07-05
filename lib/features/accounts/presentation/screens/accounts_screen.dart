import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/finance/bank_info.dart';
import '../../../../shared/dialogs/confirm_delete_dialog.dart';
import '../providers/account_provider.dart';
import '../widgets/account_list_card.dart';
import '../widgets/accounts_empty_state.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(accountProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Accounts')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppRoutes.addAccount);
        },
        child: const Icon(Icons.add),
      ),
      body: notifier.loading
          ? const Center(child: CircularProgressIndicator())
          : notifier.accounts.isEmpty
          ? AccountsEmptyState(
        onAddAccount: () {
          context.push(AppRoutes.addAccount);
        },
      )
          : ListView.separated(
              padding: AppSpacing.screenPadding,
              itemCount: notifier.accounts.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.md),
              itemBuilder: (_, index) {
                final account = notifier.accounts[index];

                return AccountListCard(
                  account: account,

                  onDelete: () async {
                    await ref
                        .read(accountProvider)
                        .deleteAccount(account.id);

                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Account deleted successfully',
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
