import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../shared/components/sections/section_header.dart';
import '../../../accounts/presentation/providers/account_provider.dart';
import '../../../accounts/presentation/widgets/account_empty_state.dart';
import 'account_card.dart';

class AccountsSection extends ConsumerWidget {
  const AccountsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountNotifier = ref.watch(accountProvider);

    if (accountNotifier.loading) {
      return const Padding(
        padding: EdgeInsets.all(AppSpacing.xl),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Column(
      children: [
        SectionHeader(
          title: 'My Accounts',
          actionText: accountNotifier.accounts.isEmpty
              ? null
              : 'View All',
          onPressed: accountNotifier.accounts.isEmpty
              ? null
              : () {
            context.push(AppRoutes.accounts);
          },
        ),

        // const SizedBox(height: 2),

        if (accountNotifier.accounts.isEmpty)
          const Padding(
            padding: AppSpacing.screenPadding,
            child: AccountEmptyState(),
          )
        else
          SizedBox(
            height: 215,
            child: ListView.separated(
              padding: AppSpacing.screenPadding,
              scrollDirection: Axis.horizontal,
              itemCount: accountNotifier.accounts.length,
              separatorBuilder: (_, __) =>
              const SizedBox(width: AppSpacing.md),
              itemBuilder: (_, index) {
                return AccountCard(
                  account: accountNotifier.accounts[index],
                );
              },
            ),
          ),
      ],
    );
  }
}