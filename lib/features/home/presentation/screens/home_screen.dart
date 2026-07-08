import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../widgets/accounts_section.dart';
import '../widgets/balance_card.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/quick_actions.dart';
import '../widgets/recent_transactions_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: HomeAppBar(),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(
                height: AppSpacing.lg,
              ),
            ),

            const SliverToBoxAdapter(
              child: BalanceCard(),
            ),

            const SliverToBoxAdapter(
              child: QuickActions(),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(
                height: AppSpacing.xl,
              ),
            ),

            const SliverToBoxAdapter(
              child: AccountsSection(),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(
                height: AppSpacing.xl,
              ),
            ),

            const SliverToBoxAdapter(
              child: RecentTransactionsSection(),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(
                height: AppSpacing.xxxl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}