import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/features/constants/app_radius.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../domain/models/statement_type.dart';
import '../providers/statement_provider.dart';

class StatementTypeSelector extends ConsumerWidget {
  const StatementTypeSelector({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final theme = Theme.of(context);

    final notifier = ref.watch(statementProvider);

    return Container(
      decoration: BoxDecoration(
        borderRadius: AppRadius.borderRadiusXl,
        color: theme.brightness == Brightness.dark
            ? const Color(0xFF1B1D38).withValues(alpha: .85)
            : theme.colorScheme.surface.withValues(alpha: .92),
        border: Border.all(
          color: theme.brightness == Brightness.dark
              ? const Color(0xFF6F63FF).withValues(alpha: .18)
              : theme.colorScheme.outlineVariant.withValues(alpha: .30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: .08),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                Icons.picture_as_pdf_rounded,
                color: theme.colorScheme.primary,
                size: 34,
              ),
            ),

            const SizedBox(width: AppSpacing.lg),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    'Statement Format',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Text(
                  //   'Choose the format for your statement',
                  //   style: theme.textTheme.bodyMedium?.copyWith(
                  //     color: theme.colorScheme.onSurfaceVariant,
                  //   ),
                  // ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: .08),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: .18),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Icon(
                    Icons.check_rounded,
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),

                  const SizedBox(width: 8),

                  Text(
                    notifier.options.type == StatementType.pdf
                        ? 'PDF'
                        : 'CSV',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.primary,
                    ),
                  ),

                  const SizedBox(width: 6),

                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}