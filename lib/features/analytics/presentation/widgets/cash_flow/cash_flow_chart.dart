import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/features/constants/app_chart_colors.dart';
import '../../../../../core/features/services/financial_insights_service_provider.dart';
import '../../providers/analytics_provider.dart';

class CashFlowChart extends ConsumerWidget {
  const CashFlowChart({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final analytics =
    ref.watch(analyticsProvider);

    final service =
    ref.read(
      financialInsightsServiceProvider,
    );

    final data =
    service.getCashFlowData(
      analytics.filteredTransactions,
    );

    if (data.isEmpty) {
      return SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [

            Icon(
              Icons.bar_chart_rounded,
              size: 52,
              color: Theme.of(context)
                  .colorScheme
                  .outline,
            ),

            const SizedBox(height: 16),

            Text(
              'No cash flow available',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium,
            ),

            const SizedBox(height: 8),

            Text(
              'Add some income or expense transactions\nto view your cash flow.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    double maxY = 0;

    for (final item in data) {
      if (item.income > maxY) {
        maxY = item.income;
      }

      if (item.expense > maxY) {
        maxY = item.expense;
      }
    }

    maxY *= 1.15;

    return SizedBox(
      height: 300,
      child: BarChart(
        duration: const Duration(
          milliseconds: 700,
        ),
        curve: Curves.easeOutCubic,
        BarChartData(
          maxY: maxY,

          alignment:
          BarChartAlignment.spaceAround,

          gridData: FlGridData(
            drawVerticalLine: false,
            horizontalInterval: maxY / 4,
            getDrawingHorizontalLine: (_) {
              return FlLine(
                color: Colors.white.withValues(
                  alpha: 0.06,
                ),
                strokeWidth: 1,
              );
            },
          ),

          borderData:
          FlBorderData(show: false),

          barTouchData: BarTouchData(
            enabled: true,

            touchTooltipData: BarTouchTooltipData(
              tooltipRoundedRadius: 12,
              tooltipPadding: const EdgeInsets.all(12),
              tooltipMargin: 12,

              getTooltipItem: (
                  group,
                  groupIndex,
                  rod,
                  rodIndex,
                  ) {
                final item = data[group.x];

                const months = [
                  '',
                  'January',
                  'February',
                  'March',
                  'April',
                  'May',
                  'June',
                  'July',
                  'August',
                  'September',
                  'October',
                  'November',
                  'December',
                ];

                final title =
                rodIndex == 0
                    ? 'Income'
                    : 'Expense';

                final amount =
                rodIndex == 0
                    ? item.income
                    : item.expense;

                return BarTooltipItem(
                  '${months[item.month]} ${item.year}\n\n'
                      '$title\n'
                      '₹${amount.toStringAsFixed(0)}',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                  ),
                );
              },
            ),
          ),

          titlesData: FlTitlesData(
            topTitles:
            const AxisTitles(),
            rightTitles:
            const AxisTitles(),

            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: maxY / 4,
                getTitlesWidget: (
                    value,
                    meta,
                    ) {
                  if (value == 0) {
                    return const Text('0');
                  }

                  return Text(
                    '${(value / 1000).round()}K',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall,
                  );
                },
              ),
            ),

            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,

                getTitlesWidget:
                    (value, meta) {
                  if (value >= data.length) {
                    return const SizedBox();
                  }

                  final month =
                      data[value.toInt()]
                          .month;

                  const months = [
                    '',
                    'Jan',
                    'Feb',
                    'Mar',
                    'Apr',
                    'May',
                    'Jun',
                    'Jul',
                    'Aug',
                    'Sep',
                    'Oct',
                    'Nov',
                    'Dec',
                  ];

                  return Padding(
                    padding:
                    const EdgeInsets.only(
                      top: 8,
                    ),
                    child: Text(
                      months[month],
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          barGroups:
          List.generate(
            data.length,
                (index) {
              final item =
              data[index];

              return BarChartGroupData(
                x: index,

                barsSpace: 6,

                barRods: [

                  BarChartRodData(
                    toY: item.income,

                    width: 16,

                    borderRadius:
                    BorderRadius.circular(
                      8,
                    ),

                    color:
                    AppChartColors
                        .income,
                  ),

                  BarChartRodData(
                    toY: item.expense,

                    width: 16,

                    borderRadius:
                    BorderRadius.circular(
                      8,
                    ),

                    color:
                    AppChartColors
                        .expense,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}