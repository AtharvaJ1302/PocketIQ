import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'financial_insights_service.dart';

final financialInsightsServiceProvider =
Provider<FinancialInsightsService>(
      (ref) {
    return const FinancialInsightsService();
  },
);