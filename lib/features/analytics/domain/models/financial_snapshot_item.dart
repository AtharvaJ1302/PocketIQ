import 'package:flutter/material.dart';

class FinancialSnapshotItem {
  final IconData icon;
  final String title;
  final String value;
  final String? subtitle;

  const FinancialSnapshotItem({
    required this.icon,
    required this.title,
    required this.value,
    this.subtitle,
  });
}