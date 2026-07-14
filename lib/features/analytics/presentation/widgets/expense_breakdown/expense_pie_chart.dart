import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/features/constants/app_chart_colors.dart';
import '../../../../../core/features/constants/app_spacing.dart';
import '../../../../../core/features/services/financial_insights_service_provider.dart';
import '../../../../transactions/presentation/providers/transaction_provider.dart';
import '../../providers/analytics_provider.dart';

class ExpensePieChart extends ConsumerStatefulWidget {
  const ExpensePieChart({
    super.key,
  });

  @override
  ConsumerState<ExpensePieChart> createState() =>
      _ExpensePieChartState();
}

class _ExpensePieChartState
    extends ConsumerState<ExpensePieChart> {
  int _selectedIndex = -1;

  @override
  Widget build(
      BuildContext context,
      ) {
    final theme = Theme.of(context);

    final service =
    ref.read(financialInsightsServiceProvider);

    final transactions =
        ref.watch(analyticsProvider)
            .filteredTransactions;

    final categories =
    service.getCategorySummary(transactions);

    if (categories.isEmpty) {
      return const SizedBox.shrink();
    }

    final totalExpense = transactions
        .where((transaction) => transaction.isExpense)
        .fold<double>(
      0,
          (sum, transaction) => sum + transaction.amount,
    );

    return Padding(
      padding: AppSpacing.screenPadding,
      child: SizedBox(
        height: 300,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (_selectedIndex != -1) {
              setState(() {
                _selectedIndex = -1;
              });
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: [

              PieChart(
                duration: const Duration(
                  milliseconds: 250,
                ),
                curve: Curves.easeOutCubic,
                PieChartData(
                  centerSpaceRadius: 75,
                  sectionsSpace: 3,

                  pieTouchData: PieTouchData(
                      enabled: true,
                    touchCallback: (event, response) {
                      if (response?.touchedSection == null) {
                        return;
                      }

                      // Only react to a completed tap
                      if (event is! FlTapUpEvent) {
                        return;
                      }

                      final tappedIndex =
                          response!.touchedSection!.touchedSectionIndex;

                      setState(() {
                        if (_selectedIndex == tappedIndex) {
                          _selectedIndex = -1;
                        } else {
                          _selectedIndex = tappedIndex;
                        }
                      });
                    },
                  ),

                  sections: List.generate(
                    categories.length,
                        (index) {
                      final category =
                      categories[index];

                      return PieChartSectionData(
                        value: category.percentage * 100,

                        title: category.percentage >= 0.05
                            ? '${(category.percentage * 100).toStringAsFixed(0)}%'
                            : '',

                        titleStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),

                        radius: _selectedIndex == index
                            ? 88
                            : 75,

                        badgePositionPercentageOffset: 1.15,
                        color: AppChartColors
                            .gradients[index %
                            AppChartColors.gradients.length]
                            .colors
                            .first
                            .withValues(
                          alpha: _selectedIndex == -1 ||
                              _selectedIndex == index
                              ? 1.0
                              : 0.35,
                        ),
                      );
                    },
                  ),
                ),
              ),

              AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: 300,
                ),
                switchInCurve: Curves.easeOutBack,
                switchOutCurve: Curves.easeIn,

                transitionBuilder: (
                    child,
                    animation,
                    ) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween<double>(
                        begin: .92,
                        end: 1,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },

                child: _selectedIndex == -1
                    ? Column(
                  key: const ValueKey(
                    'total',
                  ),
                  mainAxisSize:
                  MainAxisSize.min,
                  children: [

                    Icon(
                      Icons.account_balance_wallet_rounded,
                      size: 30,
                      color: theme.colorScheme.primary,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Total Expenses',
                      style: theme.textTheme.bodyMedium,
                    ),

                    const SizedBox(
                      height: 6,
                    ),

                    Text(
                      '₹${totalExpense.toStringAsFixed(0)}',
                      style: theme
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ],
                )
                    : Builder(
                  builder: (_) {
                    final category =
                    categories[
                    _selectedIndex];

                    return Column(
                      key: ValueKey(
                        category.category,
                      ),
                      mainAxisSize:
                      MainAxisSize.min,
                      children: [

                        Icon(
                          _getCategoryIcon(
                            category.category,
                          ),
                          size: 30,
                          color: theme.colorScheme.primary,
                        ),

                        const SizedBox(height: 8),

                        Text(
                          category.category,
                          textAlign:
                          TextAlign.center,
                          style: theme
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 6,
                        ),

                        Text(
                          '₹${category.amount.toStringAsFixed(0)}',
                          style: theme
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 4,
                        ),

                        Text(
                          '${(category.percentage * 100).toStringAsFixed(1)}% of expenses',
                          style: theme
                              .textTheme
                              .bodyMedium,
                        ),
                      ],
                    );
                  },
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}

IconData _getCategoryIcon(
    String category,
    ) {
  switch (category.toLowerCase()) {
    case 'food':
      return Icons.restaurant_rounded;

    case 'fuel':
      return Icons.local_gas_station_rounded;

    case 'shopping':
      return Icons.shopping_bag_rounded;

    case 'bills':
      return Icons.receipt_long_rounded;

    case 'entertainment':
      return Icons.movie_rounded;

    case 'travel':
      return Icons.flight_rounded;

    case 'health':
      return Icons.local_hospital_rounded;

    case 'education':
      return Icons.school_rounded;

    default:
      return Icons.category_rounded;
  }
}