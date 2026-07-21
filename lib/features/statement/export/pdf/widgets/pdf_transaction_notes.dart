import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../../core/features/utils/currency_formatter.dart';
import '../../../domain/models/statement_data.dart';

class PdfTransactionNotes {
  static pw.Widget build(
      StatementData statement,
      ) {
    if (statement.notedTransactions.isEmpty) {
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
          'No transaction notes available.',
        ),
      );
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [

        pw.Text(
          'TRANSACTION NOTES',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: PdfColor.fromHex('#243B6B'),
          ),
        ),

        pw.SizedBox(height: 12),

        ...List.generate(
          statement.notedTransactions.length,
              (index) => _noteCard(
            statement.notedTransactions[index],
          ),
        ),
      ],
    );
  }

  static pw.Widget _noteCard(transaction) {
    final income = transaction.isIncome;

    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 12),
      padding: const pw.EdgeInsets.all(14),
      decoration: pw.BoxDecoration(
        color: PdfColors.white,
        border: pw.Border.all(
          color: PdfColors.grey300,
        ),
        borderRadius: pw.BorderRadius.circular(6),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [

          /// Header
          pw.Row(
            mainAxisAlignment:
            pw.MainAxisAlignment.spaceBetween,
            children: [

              pw.Text(
                transaction.category,
                style: pw.TextStyle(
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.Text(
                CurrencyFormatter.signed(
                  income
                      ? transaction.amount
                      : -transaction.amount,
                ),
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                  color: income
                      ? PdfColor.fromHex('#2E7D32')
                      : PdfColor.fromHex('#C62828'),
                ),
              ),
            ],
          ),

          pw.SizedBox(height: 4),

          /// Date
          pw.Text(
            _formatDate(transaction.date),
            style: pw.TextStyle(
              fontSize: 8,
              color: PdfColors.grey700,
            ),
          ),

          pw.SizedBox(height: 10),

          pw.Container(
            height: .5,
            color: PdfColors.grey300,
          ),

          pw.SizedBox(height: 10),

          /// Note
          pw.Text(
            transaction.note!,
            style: const pw.TextStyle(
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

String _formatDate(
    DateTime date,
    ) {
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

  return '${date.day} ${months[date.month]} ${date.year}';
}