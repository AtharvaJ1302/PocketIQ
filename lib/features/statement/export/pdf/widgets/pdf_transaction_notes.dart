import 'package:pdf/widgets.dart' as pw;

import '../../../../../core/features/utils/currency_formatter.dart';
import '../../../domain/models/statement_data.dart';

class PdfTransactionNotes {
  static pw.Widget build(
      StatementData statement,
      ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [

        pw.Text(
          'Transaction Notes',
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
          ),
        ),

        pw.SizedBox(height: 8),

        ...statement.notedTransactions.map(
              (transaction) {
            return pw.Container(
              margin: const pw.EdgeInsets.only(
                bottom: 16,
              ),

              padding: const pw.EdgeInsets.all(
                12,
              ),

              decoration: pw.BoxDecoration(
                border: pw.Border.all(),
              ),

              child: pw.Column(
                crossAxisAlignment:
                pw.CrossAxisAlignment.start,
                children: [

                  pw.Row(
                    mainAxisAlignment:
                    pw.MainAxisAlignment.spaceBetween,
                    children: [

                      pw.Text(
                        transaction.category,
                        style: pw.TextStyle(
                          fontWeight:
                          pw.FontWeight.bold,
                        ),
                      ),

                      pw.Text(
                        CurrencyFormatter.signed(
                          transaction.isIncome
                              ? transaction.amount
                              : -transaction.amount,
                        ),
                      ),
                    ],
                  ),

                  pw.SizedBox(height: 4),

                  pw.Text(
                    _formatDate(
                      transaction.date,
                    ),
                  ),

                  pw.SizedBox(height: 8),

                  pw.Text(
                    transaction.note!,
                  ),
                ],
              ),
            );
          },
        ),
      ],
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