import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/statement/domain/services/statement_service.dart';
import 'financial_insights_service_provider.dart';

final statementServiceProvider =
Provider<StatementService>(
      (ref) {
    return StatementService(
      ref.read(
        financialInsightsServiceProvider,
      ),
    );
  },
);