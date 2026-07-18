import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/services/app_reset_service_provider.dart';
import '../../../accounts/presentation/providers/account_provider.dart';
import '../../../setup/presentation/providers/preferences_provider.dart';
import '../../../transactions/presentation/providers/transaction_provider.dart';

class ResetAppDialog extends ConsumerStatefulWidget {
  const ResetAppDialog({super.key});

  @override
  ConsumerState<ResetAppDialog> createState() =>
      _ResetAppDialogState();
}

class _ResetAppDialogState
    extends ConsumerState<ResetAppDialog> {

  bool _loading = false;

  Future<void> _reset() async {
    setState(() {
      _loading = true;
    });

    try {
      await ref
          .read(appResetServiceProvider)
          .reset();

      await ref
          .read(accountProvider)
          .loadAccounts();

      await ref
          .read(transactionProvider)
          .loadTransactions();

      await ref
          .read(preferencesProvider)
          .loadPreferences();

      if (!mounted) return;

      context.go(
        AppRoutes.onboarding,
      );
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.delete_forever_outlined,
        size: 36,
      ),

      title: const Text(
        'Reset PocketIQ',
      ),

      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Text(
            'This will permanently delete:',
          ),

          SizedBox(
            height: AppSpacing.md,
          ),

          Text('• All Accounts'),
          Text('• All Transactions'),
          Text('• Your Budgets'),

          SizedBox(
            height: AppSpacing.md,
          ),

          Text(
            'This action cannot be undone.',
          ),
        ],
      ),

      actions: [

        TextButton(
          onPressed: _loading
              ? null
              : () => Navigator.pop(context),
          child: const Text(
            'Cancel',
          ),
        ),

        FilledButton(
          onPressed:
          _loading ? null : _reset,
          child: _loading
              ? const SizedBox(
            width: 18,
            height: 18,
            child:
            CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
              : const Text(
            'Reset',
          ),
        ),
      ],
    );
  }
}