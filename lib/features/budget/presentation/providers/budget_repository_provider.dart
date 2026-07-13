import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_service.dart';
import '../../data/repositories/budget_repository_impl.dart';

final budgetRepositoryProvider =
Provider<BudgetRepositoryImpl>(
      (ref) {
    return BudgetRepositoryImpl(
      DatabaseService.instance,
    );
  },
);