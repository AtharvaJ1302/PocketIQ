import 'package:flutter/foundation.dart';

class OnboardingNotifier extends ChangeNotifier {
  final int totalPages;

  OnboardingNotifier({
    required this.totalPages,
  });

  int _currentPage = 0;

  int get currentPage => _currentPage;

  bool get isLastPage => _currentPage == totalPages - 1;

  void updatePage(int page) {
    if (_currentPage == page) return;

    _currentPage = page;
    notifyListeners();
  }

  int get nextPage =>
      isLastPage ? _currentPage : _currentPage + 1;
}