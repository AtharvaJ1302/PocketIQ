import 'package:flutter_riverpod/legacy.dart';

import 'navigation_notifier.dart';

final navigationProvider =
ChangeNotifierProvider<NavigationNotifier>(
      (ref) => NavigationNotifier(),
);