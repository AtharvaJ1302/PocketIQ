import 'package:flutter/material.dart';

import '../../../../../core/features/constants/app_chart_colors.dart';

class CashFlowLegend extends StatelessWidget {
  const CashFlowLegend({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [

        _LegendItem(
          color: AppChartColors.income,
          label: 'Income',
        ),

        SizedBox(width: 20),

        _LegendItem(
          color: AppChartColors.expense,
          label: 'Expense',
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),

        const SizedBox(width: 6),

        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodySmall,
        )
      ],
    );
  }
}