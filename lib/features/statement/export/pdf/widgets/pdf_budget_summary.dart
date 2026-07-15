import 'package:pdf/widgets.dart' as pw;

import '../../../../../core/features/utils/currency_formatter.dart';
import '../../../domain/models/statement_data.dart';

class PdfBudgetSummary {
  static pw.Widget build(
      StatementData statement,
      ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [

        pw.Text(
          'Budget Summary',
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
          ),
        ),

        pw.SizedBox(height: 8),

        pw.Table.fromTextArray(
          headers: const [
            'Category',
            'Spent',
            'Budget',
            'Remaining',
            'Status',
          ],

          headerStyle: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
          ),

          headerDecoration: pw.BoxDecoration(
            border: pw.Border(
              bottom: pw.BorderSide(
                width: 1,
              ),
            ),
          ),

          columnWidths: {
            0: const pw.FlexColumnWidth(3),
            1: const pw.FlexColumnWidth(2),
            2: const pw.FlexColumnWidth(2),
            3: const pw.FlexColumnWidth(2),
            4: const pw.FlexColumnWidth(2),
          },

          cellAlignments: {
            0: pw.Alignment.centerLeft,
            1: pw.Alignment.centerRight,
            2: pw.Alignment.centerRight,
            3: pw.Alignment.centerRight,
            4: pw.Alignment.center,
          },

          data: statement.budgets.map(
                (budget) {
              return [

                budget.budget.category,

                CurrencyFormatter.format(
                  budget.spent,
                ),

                CurrencyFormatter.format(
                  budget.budget.budgetAmount,
                ),

                CurrencyFormatter.format(
                  budget.remaining,
                ),

                budget.isExceeded
                    ? 'Exceeded'
                    : budget.percentageLabel,
              ];
            },
          ).toList(),
        ),
      ],
    );
  }
}