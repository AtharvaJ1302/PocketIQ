import 'package:flutter/material.dart';

import 'categories.dart';

class CategoryColors {
  CategoryColors._();

  static Color get(String category) {
    switch (category) {
      case FinanceCategories.food:
        return Colors.orange;

      case FinanceCategories.shopping:
        return Colors.purple;

      case FinanceCategories.transport:
        return Colors.blue;

      case FinanceCategories.health:
        return Colors.red;

      case FinanceCategories.salary:
        return Colors.green;

      default:
        return Colors.grey;
    }
  }
}