import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../export/pdf/pdf_generator.dart';

final statementPdfProvider =
Provider<PdfGenerator>(
      (ref) {
    return PdfGenerator();
  },
);