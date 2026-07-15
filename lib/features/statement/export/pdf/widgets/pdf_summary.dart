import 'package:pdf/widgets.dart' as pw;

import '../../../../../core/features/utils/currency_formatter.dart';
import '../../../domain/models/statement_data.dart';

class PdfSummary {
  static pw.Widget build(
      StatementData statement,
      ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),

      decoration: pw.BoxDecoration(
        border: pw.Border.all(),
      ),

      child: pw.Column(
        children: [

          _row(
            'Income',
            CurrencyFormatter.format(
              statement.summary.income,
            ),
          ),

          pw.SizedBox(height: 8),

          _row(
            'Expenses',
            CurrencyFormatter.format(
              statement.summary.expense,
            ),
          ),

          pw.SizedBox(height: 8),

          _row(
            'Savings',
            CurrencyFormatter.format(
              statement.summary.savings,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _row(
      String title,
      String value,
      ) {
    return pw.Row(
      mainAxisAlignment:
      pw.MainAxisAlignment.spaceBetween,
      children: [

        pw.Text(title),

        pw.Text(
          value,
          style: pw.TextStyle(
            fontWeight:
            pw.FontWeight.bold,
          ),
        ),
      ],
    );
  }
}