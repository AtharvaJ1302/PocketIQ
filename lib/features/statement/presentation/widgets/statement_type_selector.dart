import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    final notifier =
    ref.watch(statementProvider);

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            Text(
              'Statement Format',
              style: theme.textTheme.titleMedium
                  ?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            SegmentedButton<StatementType>(
              segments: const [

                ButtonSegment(
                  value: StatementType.pdf,
                  label: Text('PDF'),
                  icon: Icon(
                    Icons.picture_as_pdf_rounded,
                  ),
                ),

                // ButtonSegment(
                //   value: StatementType.csv,
                //   label: Text('CSV'),
                //   icon: Icon(
                //     Icons.lock_outline_rounded,
                //   ),
                //   enabled: false,
                // ),
              ],

              selected: {
                notifier.options.type,
              },

              onSelectionChanged: (
                  selection,
                  ) {
                notifier.changeType(
                  selection.first,
                );
              },
            ),

            const SizedBox(height: 12),

            // Text(
            //   'CSV export will be available in a future update.',
            //   style: theme.textTheme.bodySmall?.copyWith(
            //     color: theme.colorScheme.onSurfaceVariant,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}