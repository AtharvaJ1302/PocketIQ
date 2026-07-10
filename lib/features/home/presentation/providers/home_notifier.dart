import 'package:flutter/foundation.dart';

class HomeNotifier extends ChangeNotifier {
  bool hideBalance = false;

  void toggleBalanceVisibility() {
    hideBalance = !hideBalance;
    notifyListeners();
  }

  String get greeting {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    }

    if (hour < 17) {
      return 'Good Afternoon';
    }

    if (hour < 21) {
      return 'Good Evening';
    }

    return 'Welcome Back';
  }
}