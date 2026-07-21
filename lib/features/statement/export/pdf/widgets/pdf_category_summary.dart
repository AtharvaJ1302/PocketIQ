import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../../core/features/utils/currency_formatter.dart';
import '../../../domain/models/statement_data.dart';
import '../../../../analytics/domain/models/category_summary.dart';

class PdfCategorySummary {
  static pw.Widget build(
      StatementData statement,
      ) {
    if (statement.categories.isEmpty) {
      return pw.Container(
        width: double.infinity,
        padding: const pw.EdgeInsets.all(20),
        alignment: pw.Alignment.center,
        decoration: pw.BoxDecoration(
          border: pw.Border.all(
            color: PdfColors.grey300,
          ),
          borderRadius: pw.BorderRadius.circular(6),
        ),
        child: pw.Text(
          'No category summary available.',
        ),
      );
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [

        pw.Text(
          'CATEGORY SUMMARY',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: PdfColor.fromHex('#243B6B'),
          ),
        ),

        pw.SizedBox(height: 12),

        _header(),

        ...List.generate(
          statement.categories.length,
              (index) => _row(
            statement.categories[index],
            index,
          ),
        ),
      ],
    );
  }

  static pw.Widget _header() {
    return pw.Container(
      color: PdfColor.fromHex('#243B6B'),
      padding: const pw.EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      child: pw.Row(
        children: [

          pw.Expanded(
            child: pw.Text(
              'Category',
              style: pw.TextStyle(
                color: PdfColors.white,
                fontWeight: pw.FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),

          pw.Text(
            'Amount',
            style: pw.TextStyle(
              color: PdfColors.white,
              fontWeight: pw.FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _row(
      CategorySummary category,
      int index,
      ) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        color: index.isEven
            ? PdfColors.white
            : PdfColor.fromHex('#F8F9FC'),
        border: pw.Border(
          bottom: pw.BorderSide(
            color: PdfColors.grey300,
            width: .5,
          ),
        ),
      ),
      padding: const pw.EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      child: pw.Row(
        children: [

          pw.Expanded(
            child: pw.Text(
              category.category,
              style: const pw.TextStyle(
                fontSize: 10,
              ),
            ),
          ),

          pw.Text(
            CurrencyFormatter.format(
              category.amount,
            ),
            style: pw.TextStyle(
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromHex('#243B6B'),
            ),
          ),
        ],
      ),
    );
  }
}