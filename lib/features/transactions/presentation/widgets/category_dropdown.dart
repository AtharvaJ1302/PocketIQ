import 'package:flutter/material.dart';

import '../../../../core/features/finance/categories.dart';
import '../../../../core/features/utils/validators.dart';
import '../../../../shared/components/dropdown/pocket_dropdown.dart';
import '../../domain/models/transaction_type.dart';

class CategoryDropdown extends StatelessWidget {
  final TransactionType type;
  final String? value;
  final ValueChanged<String?> onChanged;

  const CategoryDropdown({
    super.key,
    required this.type,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final categories = type == TransactionType.expense
        ? FinanceCategories.expenseCategories
        : FinanceCategories.incomeCategories;

    return PocketDropdown<String>(
      validator: Validators.dropdown,
      label: 'Category',
      value: value,
      prefixIcon: const Icon(
        Icons.category_outlined,
      ),
      onChanged: onChanged,
      items: categories.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category),
        );
      }).toList(),
    );
  }
}