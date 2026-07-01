import 'package:flutter_riverpod/legacy.dart';

import 'splash_controller.dart';

final splashControllerProvider =
ChangeNotifierProvider<SplashController>(
      (ref) => SplashController(),
);