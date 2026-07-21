import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../domain/models/statement_data.dart';
import '../../../domain/models/statement_period.dart';

class PdfHeader {
  static pw.Widget build(
      StatementData statement,
      ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [

        /// Header
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [

            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [

                pw.Text(
                  'PocketIQ',
                  style: pw.TextStyle(
                    fontSize: 26,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex('#243B6B'),
                  ),
                ),

                pw.SizedBox(height: 4),

                pw.Text(
                  'FINANCIAL STATEMENT',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex('#243B6B'),
                  ),
                ),
              ],
            ),

            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [

                pw.Text(
                  'Generated On',
                  style: pw.TextStyle(
                    fontSize: 9,
                    color: PdfColors.grey700,
                  ),
                ),

                pw.SizedBox(height: 4),

                pw.Text(
                  '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),

        pw.SizedBox(height: 20),

        pw.Container(
          height: 2,
          color: PdfColor.fromHex('#243B6B'),
        ),

        pw.SizedBox(height: 20),

        /// Statement Information
        pw.Row(
          children: [

            _infoItem(
              'STATEMENT PERIOD',
              _dateRange(statement),
            ),

            _verticalDivider(),

            _infoItem(
              'TRANSACTIONS',
              '${statement.transactions.length}',
            ),

            _verticalDivider(),

            _infoItem(
              'CURRENCY',
              'INR',
            ),

            _verticalDivider(),

            _infoItem(
              'GENERATED',
              DateFormat('d MMM yyyy • hh:mm a').format(DateTime.now()),
            ),
          ],
        ),

        pw.SizedBox(height: 18),

        pw.Container(
          height: 1,
          color: PdfColors.grey300,
        ),
      ],
    );
  }

  static pw.Widget _infoItem(
      String title,
      String value,
      ) {
    return pw.Expanded(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [

          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 8,
              color: PdfColors.grey700,
            ),
          ),

          pw.SizedBox(height: 5),

          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _verticalDivider() {
    return pw.Container(
      width: 1,
      height: 34,
      margin: const pw.EdgeInsets.symmetric(
        horizontal: 16,
      ),
      color: PdfColors.grey300,
    );
  }

  static String _dateRange(
      StatementData statement,
      ) {
    final now = DateTime.now();

    DateTime start;
    DateTime end = now;

    switch (statement.period) {
      case StatementPeriod.thisMonth:
        start = DateTime(now.year, now.month, 1);
        break;

      case StatementPeriod.lastMonth:
        start = DateTime(now.year, now.month - 1, 1);
        end = DateTime(now.year, now.month, 0);
        break;

      case StatementPeriod.last3Months:
        start = DateTime(now.year, now.month - 2, 1);
        break;

      case StatementPeriod.thisYear:
        start = DateTime(now.year, 1, 1);
        break;
    }

    final formatter = DateFormat('d MMM yyyy');

    return '${formatter.format(start)} - ${formatter.format(end)}';
  }
}