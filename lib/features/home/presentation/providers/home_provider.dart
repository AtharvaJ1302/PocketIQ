import 'package:flutter_riverpod/legacy.dart';

import 'home_notifier.dart';

final homeProvider =
ChangeNotifierProvider<HomeNotifier>((ref) {
  return HomeNotifier();
});