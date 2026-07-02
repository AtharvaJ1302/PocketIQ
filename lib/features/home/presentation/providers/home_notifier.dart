import 'package:flutter/foundation.dart';

class HomeNotifier extends ChangeNotifier {
  double totalBalance = 58420.75;
  double income = 78200.00;
  double expenses = 19779.25;

  String userName = 'Atharva';

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

    return 'Good Evening';
  }
}