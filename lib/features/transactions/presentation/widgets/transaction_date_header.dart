import 'package:flutter/material.dart';

class TransactionDateHeader extends StatelessWidget {
  final String title;

  const TransactionDateHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        4,
        20,
        4,
        12,
      ),
      child: Row(
        children: [
          Text(
            title.toUpperCase(),
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: theme.colorScheme.primary,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Divider(
              thickness: .8,
              color: theme.dividerColor.withValues(
                alpha: .4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}