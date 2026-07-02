import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/components/sections/section_header.dart';
import '../../../accounts/presentation/providers/account_provider.dart';
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
          actionText: 'View All',
          onPressed: () {
            context.push(AppRoutes.accounts);
          },
        ),

        const SizedBox(height: AppSpacing.md),

        SizedBox(
          height: 240,
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