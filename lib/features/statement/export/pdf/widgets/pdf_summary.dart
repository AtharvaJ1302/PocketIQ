import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../../core/features/utils/currency_formatter.dart';
import '../../../domain/models/statement_data.dart';

class PdfSummary {
  static pw.Widget build(
      StatementData statement,
      ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [

        pw.Text(
          'ACCOUNT SUMMARY',
          style: pw.TextStyle(
            fontSize: 15,
            fontWeight: pw.FontWeight.bold,
            color: PdfColor.fromHex('#243B6B'),
          ),
        ),

        pw.SizedBox(height: 14),

        pw.Row(
          children: [

            pw.Expanded(
              child: _summaryCard(
                title: 'TOTAL INCOME',
                value: CurrencyFormatter.format(
                  statement.summary.income,
                ),
                subtitle: 'Total Credits',
                accent: PdfColor.fromHex('#2E7D32'),
              ),
            ),

            pw.SizedBox(width: 14),

            pw.Expanded(
              child: _summaryCard(
                title: 'TOTAL EXPENSES',
                value: CurrencyFormatter.format(
                  statement.summary.expense,
                ),
                subtitle: 'Total Debits',
                accent: PdfColor.fromHex('#C62828'),
              ),
            ),

            pw.SizedBox(width: 14),

            pw.Expanded(
              child: _summaryCard(
                title: 'TOTAL SAVINGS',
                value: CurrencyFormatter.format(
                  statement.summary.savings,
                ),
                subtitle: 'Net Savings',
                accent: PdfColor.fromHex('#1565C0'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _summaryCard({
    required String title,
    required String value,
    required String subtitle,
    required PdfColor accent,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),

      decoration: pw.BoxDecoration(
        color: PdfColor.fromHex('#FAFBFD'),

        border: pw.Border.all(
          color: PdfColor.fromHex('#D8E1EC'),
        ),

        borderRadius: const pw.BorderRadius.all(
          pw.Radius.circular(8),
        ),
      ),

      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [

          pw.Text(
            title,
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 9,
              color: accent,
              fontWeight: pw.FontWeight.bold,
            ),
          ),

          pw.SizedBox(height: 10),

          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
          ),

          pw.SizedBox(height: 8),

          pw.Container(
            width: 40,
            height: 3,
            color: accent,
          ),

          pw.SizedBox(height: 8),

          pw.Text(
            subtitle,
            style: pw.TextStyle(
              fontSize: 9,
              color: PdfColors.grey700,
            ),
          ),
        ],
      ),
    );
  }
}