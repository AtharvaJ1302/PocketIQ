import 'package:flutter/material.dart';

import '../../../../core/features/finance/categories.dart';
import '../../../../core/features/utils/validators.dart';
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

    return FormField<String>(
      initialValue: value,
      validator: Validators.dropdown,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 20,
                crossAxisSpacing: 8,
                childAspectRatio: .78,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];

                return CategoryTile(
                  title: category,
                  icon: _categoryIcon(category),
                  color: _categoryColor(category),
                  selected: category == value,
                  onTap: () {
                    field.didChange(category);
                    onChanged(category);
                  },
                );
              },
            ),

            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  left: 12,
                ),
                child: Text(
                  field.errorText!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const CategoryTile({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: color.withOpacity(.12),
              shape: BoxShape.circle,
              border: Border.all(
                color: selected
                    ? theme.colorScheme.primary
                    : Colors.transparent,
                width: 2,
              ),
              boxShadow: selected
                  ? [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(.12),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
                  : null,
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    icon,
                    color: color,
                    size: 30,
                  ),
                ),

                if (selected)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight:
              selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

IconData _categoryIcon(String category) {
  switch (category.toLowerCase()) {
    case 'food':
      return Icons.restaurant_rounded;

    case 'groceries':
      return Icons.shopping_cart_outlined;

    case 'shopping':
      return Icons.shopping_bag_outlined;

    case 'bills':
      return Icons.receipt_long_outlined;

    case 'fuel':
      return Icons.local_gas_station_outlined;

    case 'salary':
      return Icons.account_balance_wallet_outlined;

    case 'bonus':
      return Icons.savings_outlined;

    case 'gift':
      return Icons.redeem_outlined;

    default:
      return Icons.more_horiz_rounded;
  }
}

Color _categoryColor(String category) {
  switch (category.toLowerCase()) {
    case 'food':
      return Colors.orange;

    case 'transport':
      return Colors.blue;

    case 'shopping':
      return Colors.green;

    case 'bills':
      return Colors.amber;

    case 'entertainment':
      return Colors.deepPurple;

    case 'health':
      return Colors.red;

    case 'education':
      return Colors.teal;

    case 'travel':
      return Colors.indigo;

    case 'salary':
      return Colors.green;

    case 'investment':
      return Colors.purple;

    case 'gift':
      return Colors.pink;

    default:
      return Colors.grey;
  }
}