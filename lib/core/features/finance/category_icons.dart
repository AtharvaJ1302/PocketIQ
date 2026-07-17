import 'package:flutter/material.dart';

import 'categories.dart';

class CategoryIcons {
  CategoryIcons._();

  static IconData get(String category) {
    switch (category) {
      case FinanceCategories.food:
        return Icons.restaurant;

      case FinanceCategories.shopping:
        return Icons.shopping_bag;

      case FinanceCategories.groceries:
        return Icons.local_grocery_store_outlined;


      case FinanceCategories.bills:
        return Icons.receipt;
      // case FinanceCategories.transport:
        return Icons.directions_car;

      case FinanceCategories.fuel:
        return Icons.local_gas_station;

      case FinanceCategories.otherExpense:
        return Icons.apps_rounded;

      // case FinanceCategories.health:
        return Icons.favorite;

      // case FinanceCategories.education:
        return Icons.school;

      // case FinanceCategories.travel:
        return Icons.flight;

      case FinanceCategories.salary:
        return Icons.work;

      // case FinanceCategories.cashback:
        return Icons.savings;

      // case FinanceCategories.interest:
        return Icons.trending_up;

      default:
        return Icons.category;
    }
  }
}