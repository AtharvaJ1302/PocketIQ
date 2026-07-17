import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfTheme {
  PdfTheme._();

  // Colors
  static const PdfColor primary = PdfColor.fromInt(0xFF7C5CFF);
  static const PdfColor success = PdfColor.fromInt(0xFF22C55E);
  static const PdfColor danger = PdfColor.fromInt(0xFFEF4444);
  static const PdfColor surface = PdfColor.fromInt(0xFFF8FAFC);
  static const PdfColor border = PdfColor.fromInt(0xFFE5E7EB);
  static const PdfColor textPrimary = PdfColor.fromInt(0xFF1E293B);
  static const PdfColor textSecondary = PdfColor.fromInt(0xFF64748B);

  // Sizes
  static const double titleSize = 28;
  static const double headingSize = 18;
  static const double bodySize = 11;
  static const double smallSize = 9;

  // Radius
  static const double radius = 12;

  static pw.BoxDecoration cardDecoration({
    PdfColor color = surface,
  }) {
    return pw.BoxDecoration(
      color: color,
      borderRadius: pw.BorderRadius.circular(radius),
      border: pw.Border.all(
        color: border,
      ),
    );
  }
}