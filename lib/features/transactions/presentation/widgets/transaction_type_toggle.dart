import 'package:flutter/material.dart';

import '../../domain/models/transaction_type.dart';

class TransactionTypeToggle extends StatelessWidget {
  final TransactionType selectedType;
  final ValueChanged<TransactionType> onChanged;

  const TransactionTypeToggle({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [

          Expanded(
            child: _ToggleItem(
              title: "Expense",
              icon: Icons.arrow_upward_rounded,
              selected: selectedType == TransactionType.expense,
              selectedColor: Colors.red,
              onTap: () => onChanged(TransactionType.expense),
            ),
          ),

          Expanded(
            child: _ToggleItem(
              title: "Income",
              icon: Icons.arrow_downward_rounded,
              selected: selectedType == TransactionType.income,
              selectedColor: Colors.green,
              onTap: () => onChanged(TransactionType.income),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final Color selectedColor;
  final VoidCallback onTap;

  const _ToggleItem({
    required this.title,
    required this.icon,
    required this.selected,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              color: selected
                  ? selectedColor.withValues(alpha: .12)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: selected
                    ? selectedColor
                    : Colors.transparent,
              ),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Icon(
                    icon,
                    size: 20,
                    color: selected
                        ? selectedColor
                        : theme.colorScheme.onSurfaceVariant,
                  ),

                  const SizedBox(width: 8),

                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: selected
                          ? selectedColor
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}