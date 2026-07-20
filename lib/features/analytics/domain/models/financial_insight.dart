import 'package:flutter/material.dart';

class FinancialInsight {
  final IconData icon;
  final String title;
  final String description;
  final String? badge;

  const FinancialInsight({
    required this.icon,
    required this.title,
    required this.description,
    this.badge,
  });
}