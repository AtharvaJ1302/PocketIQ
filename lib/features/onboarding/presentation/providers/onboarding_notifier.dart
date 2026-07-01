import 'package:flutter/foundation.dart';

class OnboardingNotifier extends ChangeNotifier {
  final int totalPages;

  OnboardingNotifier({
    required this.totalPages,
  });

  int _currentPage = 0;

  int get currentPage => _currentPage;

  void updatePage(int page) {
    if (_currentPage == page) return;

    _currentPage = page;
    notifyListeners();
  }

  bool get isLastPage =>
      _currentPage == totalPages - 1;
}