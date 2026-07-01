import 'package:flutter_riverpod/legacy.dart';

import 'splash_notifier.dart';

final splashProvider =
ChangeNotifierProvider<SplashNotifier>(
      (ref) => SplashNotifier(),
);