import 'package:flutter/material.dart';

class AccountFormHeader extends StatelessWidget {
  final bool isEditing;

  const AccountFormHeader({
    super.key,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        24,
        12,
        24,
        24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 30,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Text(
                  isEditing
                      ? 'Edit Account'
                      : 'Add Account',
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -.8,
                    height: 1,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Text(
              isEditing
                  ? 'Update your account information.'
                  : 'Create a new account to track your money.',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}