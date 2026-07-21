import 'package:flutter/material.dart';

class AccountSectionTitle extends StatelessWidget {
  final String title;

  const AccountSectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
      ),
      child: Text(
        title.toUpperCase(),
        style: theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}