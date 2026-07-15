import 'package:pdf/widgets.dart' as pw;

import '../../../../../core/features/utils/currency_formatter.dart';
import '../../../domain/models/statement_data.dart';

class PdfTransactions {
  static pw.Widget build(
      StatementData statement,
      ) {
    if (statement.transactions.isEmpty) {
      return pw.Text(
        'No transactions available.',
      );
    }

    return pw.Table.fromTextArray(
      headers: const [
        'Category',
        'Date',
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

      cellStyle: const pw.TextStyle(
        fontSize: 9,
      ),

      headerAlignment: pw.Alignment.centerLeft,

      cellAlignment: pw.Alignment.centerLeft,

      columnWidths: {
        0: const pw.FlexColumnWidth(3),
        1: const pw.FlexColumnWidth(2),
        2: const pw.FlexColumnWidth(2),
      },

      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.center,
        2: pw.Alignment.centerRight,
      },

      data: statement.transactions.map(
            (transaction) {
          return [
            transaction.category,
            _formatDate(
              transaction.date,
            ),
            CurrencyFormatter.signed(
              transaction.isIncome
                  ? transaction.amount
                  : -transaction.amount,
            ),
          ];
        },
      ).toList(),
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