import 'package:flutter_riverpod/legacy.dart';

import 'analytics_notifier.dart';

final analyticsProvider =
ChangeNotifierProvider<AnalyticsNotifier>(
      (ref) {
    return AnalyticsNotifier();
  },
);