import 'package:pdf/widgets.dart' as pw;

import '../../../domain/models/statement_data.dart';

class PdfHeader {
  static pw.Widget build(
      StatementData statement,
      ) {
    return pw.Column(
      crossAxisAlignment:
      pw.CrossAxisAlignment.start,
      children: [

        pw.Text(
          'PocketIQ',
          style: pw.TextStyle(
            fontSize: 24,
            fontWeight: pw.FontWeight.bold,
          ),
        ),

        pw.SizedBox(height: 4),

        pw.Text(
          'Financial Statement',
          style: const pw.TextStyle(
            fontSize: 16,
          ),
        ),

        pw.SizedBox(height: 10),

        pw.Text(
          'Generated on ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
        ),
      ],
    );
  }
}