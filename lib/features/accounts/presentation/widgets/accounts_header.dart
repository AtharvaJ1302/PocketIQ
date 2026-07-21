import 'package:flutter/material.dart';

class AccountsHeader extends StatelessWidget {
  const AccountsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        24,
        16,
        24,
        24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                  "My Accounts",
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
              "Manage and track all your bank accounts",
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.35,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          const SizedBox(height: 42),

          Text(
            "Accounts",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: -.3,
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}