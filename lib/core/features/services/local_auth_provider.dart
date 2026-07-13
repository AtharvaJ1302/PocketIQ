import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'local_auth_service.dart';

final localAuthProvider =
Provider<LocalAuthService>((ref) {
  return LocalAuthService();
});