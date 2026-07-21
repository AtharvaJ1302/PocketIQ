import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_spacing.dart';
import '../../../../shared/components/buttons/pocket_button.dart';

class AccountBottomBar extends StatelessWidget {
  final bool loading;
  final bool isEditing;
  final VoidCallback onPressed;

  const AccountBottomBar({
    super.key,
    required this.loading,
    required this.isEditing,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border(
            top: BorderSide(
              color: Theme.of(context)
                  .dividerColor
                  .withValues(alpha: .08),
            ),
          ),
        ),
        child: PocketButton(
          label: isEditing
              ? 'Update Account'
              : 'Add Account',
          loading: loading,
          onPressed: onPressed,
        ),
      ),
    );
  }
}