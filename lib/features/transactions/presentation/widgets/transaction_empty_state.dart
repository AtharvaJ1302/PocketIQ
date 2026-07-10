import 'package:flutter/material.dart';

class TransactionEmptyState extends StatelessWidget {
  final String? message;

  const TransactionEmptyState({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 72,
          ),
          SizedBox(height: 16),
          Text(
            'No transactions yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tap + to add your first transaction.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}