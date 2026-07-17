import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/utils/currency_formatter.dart';
import '../../domain/models/statement_period.dart';
import '../providers/statement_data_provider.dart';
import '../providers/statement_pdf_provider.dart';

class StatementPreviewScreen extends ConsumerWidget {
  const StatementPreviewScreen({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final theme = Theme.of(context);

    final statement =
    ref.watch(statementDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Statement Preview',
        ),
      ),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [

          Card(
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(
                AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(
                    'PocketIQ',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Financial Statement',
                    style: theme.textTheme.titleMedium,
                  ),

                  const SizedBox(height: 4),

                  Text(
                    _periodLabel(
                      statement.period,
                    ),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),

                  Text(
                    '${statement.transactions.length} transaction${statement.transactions.length == 1 ? '' : 's'}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),

                  const Divider(height: 32),

                  _SummaryRow(
                    title: 'Income',
                    value: CurrencyFormatter.format(
                      statement.summary.income,
                    ),
                  ),

                  _SummaryRow(
                    title: 'Expenses',
                    value: CurrencyFormatter.format(
                      statement.summary.expense,
                    ),
                  ),

                  _SummaryRow(
                    title: 'Savings',
                    value: CurrencyFormatter.format(
                      statement.summary.savings,
                    ),
                  ),

                  const Divider(height: 40),

                  Text(
                    'Transactions',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  if (statement.transactions.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 36,
                      ),
                      child: Column(
                        children: [

                          Icon(
                            Icons.receipt_long_outlined,
                            size: 48,
                            color: theme.colorScheme.outline,
                          ),

                          const SizedBox(height: 12),

                          Text(
                            'No transactions found',
                            style: theme.textTheme.titleMedium,
                          ),

                          const SizedBox(height: 4),

                          Text(
                            'Try selecting another statement period.',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    )
                  else
                    ...statement.transactions
                        .take(10)
                        .map(
                          (transaction) => Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: theme.dividerColor,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [

                            Expanded(
                              flex: 3,
                              child: Text(
                                transaction.category,
                              ),
                            ),

                            Expanded(
                              flex: 2,
                              child: Text(
                                '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
                                style: theme.textTheme.bodySmall,
                              ),
                            ),

                            Text(
                              CurrencyFormatter.signed(
                                transaction.isIncome
                                    ? transaction.amount
                                    : -transaction.amount,
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: transaction.isIncome
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  if (statement.categories.isNotEmpty) ...[
                    const Divider(
                      height: 40,
                    ),

                    Text(
                      'Category Summary',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    ...statement.categories.map(
                          (category) => Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                        ),
                        child: Row(
                          children: [

                            Expanded(
                              child: Text(
                                category.category,
                              ),
                            ),

                            Text(
                              CurrencyFormatter.format(
                                category.amount,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  if (statement.budgets.isNotEmpty) ...[
                    const Divider(
                      height: 40,
                    ),

                    Text(
                      'Budget Summary',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    ...statement.budgets.map(
                          (budget) => Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [

                            Row(
                              children: [

                                Expanded(
                                  child: Text(
                                    budget.budget.category,
                                    style: theme.textTheme.titleSmall
                                        ?.copyWith(
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                ),

                                Text(
                                  budget.percentageLabel,
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),

                            const SizedBox(height: 6),

                            LinearProgressIndicator(
                              value: budget.progress,
                              minHeight: 6,
                              borderRadius:
                              BorderRadius.circular(12),
                            ),

                            const SizedBox(height: 6),

                            Row(
                              children: [

                                Expanded(
                                  child: Text(
                                    '${CurrencyFormatter.format(budget.spent)} / ${CurrencyFormatter.format(budget.budget.budgetAmount)}',
                                  ),
                                ),

                                Text(
                                  budget.isExceeded
                                      ? 'Over Budget'
                                      : 'Remaining ${CurrencyFormatter.format(budget.remaining)}',
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  if (statement.notedTransactions.isNotEmpty) ...[
                    const Divider(
                      height: 40,
                    ),

                    Text(
                      'Transaction Notes',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    ...statement.notedTransactions.map(
                          (transaction) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(
                                  children: [

                                    Expanded(
                                      child: Text(
                                        transaction.category,
                                        style: theme.textTheme.titleSmall?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    Text(
                                      CurrencyFormatter.signed(
                                        transaction.isIncome
                                            ? transaction.amount
                                            : -transaction.amount,
                                      ),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: transaction.isIncome
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.surfaceContainer,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    transaction.note!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(
            height: AppSpacing.section,
          ),

          SizedBox(
            height: 56,
            child: FilledButton.icon(
              onPressed: () async {
                final pdf =
                ref.read(statementPdfProvider);

                await Printing.layoutPdf(
                  onLayout: (format) async {
                    return pdf.generate(
                      statement,
                    );
                  },
                );
              },

              icon: const Icon(
                Icons.picture_as_pdf_rounded,
              ),

              label: const Text(
                'Generate PDF',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String title;
  final String value;

  const _SummaryRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        children: [

          Expanded(
            child: Text(
              title,
            ),
          ),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

String _periodLabel(
    StatementPeriod period,
    ) {
  switch (period) {
    case StatementPeriod.thisMonth:
      return 'This Month';

    case StatementPeriod.lastMonth:
      return 'Last Month';

    case StatementPeriod.last3Months:
      return 'Last 3 Months';

    case StatementPeriod.thisYear:
      return 'This Year';

    // case StatementPeriod.custom:
    //   return 'Custom Range';
  }
}