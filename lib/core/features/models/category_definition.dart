import 'package:flutter/material.dart';

class CategoryDefinition {
  final String name;

  final IconData icon;

  final Color color;

  final bool supportsBudget;

  final bool isIncome;

  const CategoryDefinition({
    required this.name,
    required this.icon,
    required this.color,
    required this.supportsBudget,
    required this.isIncome,
  });
}