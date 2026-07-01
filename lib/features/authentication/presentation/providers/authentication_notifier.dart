import 'package:flutter/foundation.dart';

class AuthenticationNotifier extends ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool value) {
    if (_loading == value) return;

    _loading = value;
    notifyListeners();
  }
}