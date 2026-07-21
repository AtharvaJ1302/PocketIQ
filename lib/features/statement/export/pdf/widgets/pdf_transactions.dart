import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../../core/features/utils/currency_formatter.dart';
import '../../../../transactions/domain/models/transaction.dart';
import '../../../domain/models/statement_data.dart';

class PdfTransactions {
  static pw.Widget build(
      StatementData statement,
      ) {
    if (statement.transactions.isEmpty) {
      return pw.Container(
        padding: const pw.EdgeInsets.all(20),
        alignment: pw.Alignment.center,
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.grey300),
          borderRadius: pw.BorderRadius.circular(6),
        ),
        child: pw.Text(
          'No transactions available for this period.',
          style: const pw.TextStyle(fontSize: 10),
        ),
      );
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [

        pw.Text(
          'TRANSACTION HISTORY',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: PdfColor.fromHex('#243B6B'),
          ),
        ),

        pw.SizedBox(height: 12),

        _tableHeader(),

        ...List.generate(
          statement.transactions.length,
              (index) => _transactionRow(
            statement.transactions[index],
            index,
          ),
        ),
      ],
    );
  }

  static pw.Widget _tableHeader() {
    return pw.Container(
      color: PdfColor.fromHex('#243B6B'),
      padding: const pw.EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      child: pw.Row(
        children: [

          _headerCell('Date', 2),

          _headerCell('Category', 2),

          _headerCell('Type', 1.4),

          _headerCell(
            'Amount',
            1.6,
            align: pw.TextAlign.right,
          ),
        ],
      ),
    );
  }

  static pw.Widget _transactionRow(
      Transaction transaction,
      int index,
      ) {
    final income = transaction.isIncome;

    return pw.Container(
      color: index.isEven
          ? PdfColors.white
          : PdfColor.fromHex('#F8F9FC'),

      padding: const pw.EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),

      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [

          _cell(
            _formatDate(transaction.date),
            2,
          ),

          _cell(
            transaction.category,
            2,
          ),

          _typeBadge(income),

          _cell(
            CurrencyFormatter.signed(
              income
                  ? transaction.amount
                  : -transaction.amount,
            ),
            1.6,
            align: pw.TextAlign.right,
            bold: true,
            color: income
                ? PdfColor.fromHex('#2E7D32')
                : PdfColor.fromHex('#C62828'),
          ),
        ],
      ),
    );
  }

  static pw.Widget _headerCell(
      String title,
      double flex, {
        pw.TextAlign align = pw.TextAlign.left,
      }) {
    return pw.Expanded(
      flex: (flex * 10).toInt(),
      child: pw.Text(
        title,
        textAlign: align,
        style: pw.TextStyle(
          fontSize: 10,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.white,
        ),
      ),
    );
  }

  static pw.Widget _cell(
      String value,
      double flex, {
        pw.TextAlign align = pw.TextAlign.left,
        PdfColor? color,
        bool bold = false,
      }) {
    return pw.Expanded(
      flex: (flex * 10).toInt(),
      child: pw.Text(
        value,
        textAlign: align,
        style: pw.TextStyle(
          fontSize: 9,
          color: color ?? PdfColors.black,
          fontWeight: bold
              ? pw.FontWeight.bold
              : pw.FontWeight.normal,
        ),
      ),
    );
  }

  static pw.Widget _typeBadge(bool income) {
    final background = income
        ? PdfColor.fromHex('#E8F5E9')
        : PdfColor.fromHex('#FDECEC');

    final text = income
        ? PdfColor.fromHex('#2E7D32')
        : PdfColor.fromHex('#C62828');

    return pw.Expanded(
      flex: 14,
      child: pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: pw.Container(
          padding: const pw.EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 3,
          ),
          decoration: pw.BoxDecoration(
            color: background,
            borderRadius: pw.BorderRadius.circular(20),
          ),
          child: pw.Text(
            income ? 'INCOME' : 'EXPENSE',
            style: pw.TextStyle(
              fontSize: 8,
              fontWeight: pw.FontWeight.bold,
              color: text,
            ),
          ),
        ),
      ),
    );
  }
}

String _formatDate(DateTime date) {
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