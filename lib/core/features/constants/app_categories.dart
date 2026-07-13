import 'package:flutter/material.dart';

import '../models/category_definition.dart';

class AppCategories {
  AppCategories._();

  static const all = [

    CategoryDefinition(
      name: 'Salary',
      icon: Icons.payments_rounded,
      color: Color(0xFF10B981),
      supportsBudget: false,
      isIncome: true,
    ),

    CategoryDefinition(
      name: 'Investment',
      icon: Icons.trending_up_rounded,
      color: Color(0xFF2563EB),
      supportsBudget: false,
      isIncome: true,
    ),

    CategoryDefinition(
      name: 'Food',
      icon: Icons.restaurant_rounded,
      color: Color(0xFFF97316),
      supportsBudget: true,
      isIncome: false,
    ),

    CategoryDefinition(
      name: 'Fuel',
      icon: Icons.local_gas_station_rounded,
      color: Color(0xFF0EA5E9),
      supportsBudget: true,
      isIncome: false,
    ),

    CategoryDefinition(
      name: 'Shopping',
      icon: Icons.shopping_bag_rounded,
      color: Color(0xFF8B5CF6),
      supportsBudget: true,
      isIncome: false,
    ),

    CategoryDefinition(
      name: 'Entertainment',
      icon: Icons.movie_rounded,
      color: Color(0xFFEC4899),
      supportsBudget: true,
      isIncome: false,
    ),

    CategoryDefinition(
      name: 'Bills',
      icon: Icons.receipt_long_rounded,
      color: Color(0xFFEF4444),
      supportsBudget: true,
      isIncome: false,
    ),

    CategoryDefinition(
      name: 'Transport',
      icon: Icons.directions_bus_rounded,
      color: Color(0xFF14B8A6),
      supportsBudget: true,
      isIncome: false,
    ),
  ];

  static CategoryDefinition? byName(
      String name,
      ) {
    try {
      return all.firstWhere(
            (category) => category.name == name,
      );
    } catch (_) {
      return null;
    }
  }

  static List<CategoryDefinition>
  expenseCategories() {
    return all
        .where(
          (category) =>
      !category.isIncome,
    )
        .toList();
  }

  static List<CategoryDefinition>
  budgetCategories() {
    return all
        .where(
          (category) =>
      category.supportsBudget,
    )
        .toList();
  }
}