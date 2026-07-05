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
    return SegmentedButton<TransactionType>(
      segments: const [
        ButtonSegment(
          value: TransactionType.expense,
          icon: Icon(Icons.arrow_upward_rounded),
          label: Text('Expense'),
        ),
        ButtonSegment(
          value: TransactionType.income,
          icon: Icon(Icons.arrow_downward_rounded),
          label: Text('Income'),
        ),
      ],
      selected: {selectedType},
      onSelectionChanged: (value) {
        onChanged(value.first);
      },
    );
  }
}