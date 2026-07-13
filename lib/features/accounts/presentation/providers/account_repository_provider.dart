import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_service.dart';
import '../../data/repositories/account_repository_impl.dart';
import '../../domain/repositories/account_repository.dart';

final accountRepositoryProvider =
Provider<AccountRepository>((ref) {
  return AccountRepositoryImpl(
    DatabaseService.instance,
  );
});