import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../app/theme/colors/app_gradients.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/finance/bank_info.dart';
import '../../../../shared/dialogs/confirm_delete_dialog.dart';
import '../providers/account_provider.dart';
import '../widgets/account_list_card.dart';
import '../widgets/accounts_empty_state.dart';
import '../widgets/accounts_header.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(accountProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        heroTag: 'accountsFab',
        onPressed: () {
          context.push(AppRoutes.addAccount);
        },
        child: const Icon(Icons.add),
      ),
      body: notifier.loading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : notifier.accounts.isEmpty
          ? AccountsEmptyState(
        onAddAccount: () {
          context.push(AppRoutes.addAccount);
        },
      )
          : Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? AppGradients.screenBackground
              : AppGradients.screenBackgroundLight,
        ),
        child: SafeArea(
          child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: AccountsHeader(),
            ),

            SliverPadding(
              padding: AppSpacing.screenPadding.copyWith(
                top: 8,
              ),
              sliver: SliverList.separated(
                itemCount: notifier.accounts.length,
                separatorBuilder: (_, __) =>
                const SizedBox(height: 18),
                itemBuilder: (_, index) {
                  final account =
                  notifier.accounts[index];

                  return AccountListCard(
                    account: account,
                    onDelete: () async {
                      await ref
                          .read(accountProvider)
                          .deleteAccount(account.id);

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Account deleted successfully",
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 110),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
