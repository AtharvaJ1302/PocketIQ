import 'package:pdf/widgets.dart' as pw;

import '../../../../../core/features/utils/currency_formatter.dart';
import '../../../domain/models/statement_data.dart';

class PdfCategorySummary {
  static pw.Widget build(
      StatementData statement,
      ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [

        pw.Text(
          'Category Summary',
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
          ),
        ),

        pw.SizedBox(height: 8),

        pw.Table.fromTextArray(
          headers: const [
            'Category',
            'Amount',
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
          },

          cellAlignments: {
            0: pw.Alignment.centerLeft,
            1: pw.Alignment.centerRight,
          },

          data: statement.categories.map(
                (category) {
              return [
                category.category,
                CurrencyFormatter.format(
                  category.amount,
                ),
              ];
            },
          ).toList(),
        ),
      ],
    );
  }
}