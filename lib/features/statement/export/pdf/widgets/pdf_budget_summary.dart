import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../../core/features/utils/currency_formatter.dart';
import '../../../domain/models/statement_data.dart';
import '../../../../budget/domain/models/budget_summary.dart';

class PdfBudgetSummary {
  static pw.Widget build(
      StatementData statement,
      ) {
    if (statement.budgets.isEmpty) {
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
          'No budget summary available.',
        ),
      );
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [

        pw.Text(
          'BUDGET SUMMARY',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: PdfColor.fromHex('#243B6B'),
          ),
        ),

        pw.SizedBox(height: 12),

        _header(),

        ...List.generate(
          statement.budgets.length,
              (index) => _row(
            statement.budgets[index],
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

          _headerCell('Category', 3),

          _headerCell(
            'Spent',
            2,
            align: pw.TextAlign.right,
          ),

          _headerCell(
            'Budget',
            2,
            align: pw.TextAlign.right,
          ),

          _headerCell(
            'Remaining',
            2,
            align: pw.TextAlign.right,
          ),

          _headerCell(
            'Status',
            2,
            align: pw.TextAlign.center,
          ),
        ],
      ),
    );
  }

  static pw.Widget _row(
      BudgetSummary budget,
      int index,
      ) {
    final remainingColor = budget.remaining >= 0
        ? PdfColor.fromHex('#2E7D32')
        : PdfColor.fromHex('#C62828');

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

          _cell(
            budget.budget.category,
            3,
          ),

          _cell(
            CurrencyFormatter.format(
              budget.spent,
            ),
            2,
            align: pw.TextAlign.right,
          ),

          _cell(
            CurrencyFormatter.format(
              budget.budget.budgetAmount,
            ),
            2,
            align: pw.TextAlign.right,
          ),

          _cell(
            CurrencyFormatter.format(
              budget.remaining,
            ),
            2,
            align: pw.TextAlign.right,
            color: remainingColor,
            bold: true,
          ),

          pw.Expanded(
            flex: 2,
            child: pw.Align(
              alignment: pw.Alignment.center,
              child: _statusBadge(budget),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _headerCell(
      String text,
      int flex, {
        pw.TextAlign align = pw.TextAlign.left,
      }) {
    return pw.Expanded(
      flex: flex,
      child: pw.Text(
        text,
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
      String text,
      int flex, {
        pw.TextAlign align = pw.TextAlign.left,
        PdfColor? color,
        bool bold = false,
      }) {
    return pw.Expanded(
      flex: flex,
      child: pw.Text(
        text,
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

  static pw.Widget _statusBadge(
      BudgetSummary budget,
      ) {
    late String text;
    late PdfColor background;
    late PdfColor foreground;

    if (budget.isExceeded) {
      text = 'OVER';
      background = PdfColor.fromHex('#FDECEC');
      foreground = PdfColor.fromHex('#C62828');
    } else if (budget.progress >= 0.8) {
      text = 'NEAR';
      background = PdfColor.fromHex('#FFF4E5');
      foreground = PdfColor.fromHex('#EF6C00');
    } else {
      text = 'HEALTHY';
      background = PdfColor.fromHex('#E8F5E9');
      foreground = PdfColor.fromHex('#2E7D32');
    }

    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 3,
      ),
      decoration: pw.BoxDecoration(
        color: background,
        borderRadius: pw.BorderRadius.circular(12),
      ),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 8,
          fontWeight: pw.FontWeight.bold,
          color: foreground,
        ),
      ),
    );
  }
}