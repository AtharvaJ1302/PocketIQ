import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/budget/presentation/providers/budget_repository_provider.dart';
import 'budget_alert_service.dart';
import 'financial_insights_service_provider.dart';

final budgetAlertServiceProvider =
Provider<BudgetAlertService>(
      (ref) {
    return BudgetAlertService(
      budgetRepository: ref.read(
        budgetRepositoryProvider,
      ),
      financialInsightsService: ref.read(
        financialInsightsServiceProvider,
      ),
    );
  },
);