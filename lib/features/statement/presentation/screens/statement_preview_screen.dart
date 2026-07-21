import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';
import '../../../../app/theme/colors/app_gradients.dart';
import '../../../../core/features/constants/app_radius.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final theme = Theme.of(context);

    final statement =
    ref.watch(statementDataProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Statement Preview',
        ),
      ),
        body: Container(
          decoration: BoxDecoration(
            gradient: isDark
                ? AppGradients.screenBackground
                : AppGradients.screenBackgroundLight,
          ),
          child: ListView(
            padding: AppSpacing.screenPadding,
            children: [

              Card(
                elevation: 0,
                color: theme.brightness == Brightness.dark
                    ? const Color(0xFF182136)
                    : Colors.white,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Padding(
              padding: const EdgeInsets.all(
                AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      gradient: theme.brightness == Brightness.dark
                          ? const LinearGradient(
                        colors: [
                          Color(0xFF35396B),
                          Color(0xFF282C59),
                        ],
                      )
                          : const LinearGradient(
                        colors: [
                          Color(0xFFF8F7FF),
                          Color(0xFFF0F3FF),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [

                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(alpha: .12),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                Icons.description_rounded,
                                color: theme.colorScheme.primary,
                                size: 30,
                              ),
                            ),

                            const SizedBox(width: 16),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    'PocketIQ',
                                    style: theme.textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text(
                                    'Financial Statement',
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [

                            _InfoChip(
                              icon: Icons.calendar_month_rounded,
                              label: _periodLabel(statement.period),
                            ),

                            _InfoChip(
                              icon: Icons.receipt_long_rounded,
                              label:
                              '${statement.transactions.length} Transactions',
                            ),

                            _InfoChip(
                              icon: Icons.schedule_rounded,
                              label:
                              'Generated Today',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: AppSpacing.xl,
                  ),

                  Text(
                    'Overview',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: AppSpacing.lg,
                  ),

                  Column(
                    children: [

                      Row(
                        children: [

                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: _OverviewCard(
                                title: 'Income',
                                value: CurrencyFormatter.format(
                                  statement.summary.savings,
                                ),
                                icon: Icons.savings_rounded,
                                color: Colors.blue,
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: _OverviewCard(
                                title: 'Expense',
                                value: CurrencyFormatter.format(
                                  statement.summary.savings,
                                ),
                                icon: Icons.savings_rounded,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      SizedBox(
                        width: 150,
                        child: _OverviewCard(
                          title: 'Savings',
                          value: CurrencyFormatter.format(
                            statement.summary.savings,
                          ),
                          icon: Icons.savings_rounded,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSpacing.xl,
                    ),
                    child: Divider(),
                  ),

                  const _SectionHeader(
                    icon: Icons.receipt_long_rounded,
                    title: 'Transactions',
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
                          (transaction) => _TransactionTile(
                            transaction: transaction,
                          ),
                      //         Container(
                      //   padding: const EdgeInsets.symmetric(
                      //     vertical: 12,
                      //   ),
                      //   decoration: BoxDecoration(
                      //     border: Border(
                      //       bottom: BorderSide(
                      //         color: theme.dividerColor,
                      //       ),
                      //     ),
                      //   ),
                      //   child: Row(
                      //     children: [
                      //
                      //       Expanded(
                      //         flex: 3,
                      //         child: Text(
                      //           transaction.category,
                      //         ),
                      //       ),
                      //
                      //       Expanded(
                      //         flex: 2,
                      //         child: Text(
                      //           '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
                      //           style: theme.textTheme.bodySmall,
                      //         ),
                      //       ),
                      //
                      //       Text(
                      //         CurrencyFormatter.signed(
                      //           transaction.isIncome
                      //               ? transaction.amount
                      //               : -transaction.amount,
                      //         ),
                      //         style: TextStyle(
                      //           fontWeight: FontWeight.bold,
                      //           color: transaction.isIncome
                      //               ? Colors.green
                      //               : Colors.red,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ),

                  if (statement.categories.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppSpacing.xl,
                      ),
                      child: Divider(),
                    ),

                    const _SectionHeader(
                      icon: Icons.pie_chart_rounded,
                      title: 'Category Summary',
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
                              child: _CategoryTile(
                                category: category,
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  if (statement.budgets.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppSpacing.xl,
                      ),
                      child: Divider(),
                    ),

                    const _SectionHeader(
                      icon: Icons.account_balance_wallet_rounded,
                      title: 'Budget Summary',
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    ...statement.budgets.map(
                          (budget) => Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(
                            bottom: 16,
                          ),
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: _cardColor(context),
                            borderRadius: BorderRadius.circular(18),
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
                                minHeight: 8,
                                borderRadius:
                                BorderRadius.circular(30),
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
                    ),
                  ],

                  if (statement.notedTransactions.isNotEmpty) ...[
                    const Divider(
                      height: 40,
                    ),

                    const _SectionHeader(
                      icon: Icons.sticky_note_2_rounded,
                      title: 'Transaction Notes',
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    ...statement.notedTransactions.map(
                          (transaction) => _NoteCard(
                            transaction: transaction,
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

          Container(
            height: 56,
            decoration: BoxDecoration(
              borderRadius: AppRadius.borderRadiusMd,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff6D5BFF),
                  Color(0xff7D6DFF),
                  Color(0xff8C7DFF),
                ],
              ),
            ),
            child: FilledButton.icon(
              onPressed: () async {
                final pdf = ref.read(statementPdfProvider);

                await Printing.layoutPdf(
                  onLayout: (format) async {
                    return pdf.generate(statement);
                  },
                );
              },
              icon: const Icon(
                Icons.picture_as_pdf_rounded,
              ),
              label: const Text(
                'Generate PDF',
              ),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.borderRadiusMd,
                ),
              ).copyWith(
                overlayColor: WidgetStateProperty.all(
                  Colors.white.withValues(alpha: .08),
                ),
              ),
            ),
          )
        ],
      ),
        ),
    );
  }
}

class _OverviewCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _OverviewCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: _cardColor(context),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .12),
              borderRadius:
              BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              color:
              theme.colorScheme.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(
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

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          Icon(
            icon,
            size: 18,
            color: theme.colorScheme.primary,
          ),

          const SizedBox(width: 8),

          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionHeader({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
      ),
      child: Row(
        children: [

          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary
                  .withValues(alpha: .10),
              borderRadius:
              BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: theme.colorScheme.primary,
            ),
          ),

          const SizedBox(width: 14),

          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final dynamic transaction;

  const _TransactionTile({
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final amountColor = transaction.isIncome
        ? Colors.green
        : Colors.red;

    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: _cardColor(context),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [

          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: amountColor.withValues(alpha: .12),
              borderRadius:
              BorderRadius.circular(14),
            ),
            child: Icon(
              transaction.isIncome
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              color: amountColor,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  transaction.category,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(
                    color: theme.colorScheme
                        .onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment:
            CrossAxisAlignment.end,
            children: [

              Text(
                CurrencyFormatter.signed(
                  transaction.isIncome
                      ? transaction.amount
                      : -transaction.amount,
                ),
                style: theme.textTheme.titleMedium
                    ?.copyWith(
                  color: amountColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color:
                  amountColor.withValues(alpha: .10),
                  borderRadius:
                  BorderRadius.circular(20),
                ),
                child: Text(
                  transaction.isIncome
                      ? 'Income'
                      : 'Expense',
                  style: TextStyle(
                    color: amountColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final dynamic category;

  const _CategoryTile({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [

          CircleAvatar(
            radius: 20,
            backgroundColor:
            theme.colorScheme.primary
                .withValues(alpha: .12),
            child: Icon(
              Icons.pie_chart_rounded,
              color: theme.colorScheme.primary,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Text(
              category.category,
              style: theme.textTheme.titleMedium,
            ),
          ),

          Text(
            CurrencyFormatter.format(
              category.amount,
            ),
            style: theme.textTheme.titleMedium
                ?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  final dynamic transaction;

  const _NoteCard({
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final amountColor =
    transaction.isIncome
        ? Colors.green
        : Colors.red;

    return Container(
      margin: const EdgeInsets.only(
        bottom: AppSpacing.lg,
      ),
      padding: const EdgeInsets.all(
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: _cardColor(context),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: amountColor.withValues(alpha: .12),
                  borderRadius:
                  BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.sticky_note_2_rounded,
                  color: amountColor,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    Text(
                      transaction.category,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(
                        color: theme.colorScheme
                            .onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment:
                CrossAxisAlignment.end,
                children: [

                  Text(
                    CurrencyFormatter.signed(
                      transaction.isIncome
                          ? transaction.amount
                          : -transaction.amount,
                    ),
                    style: theme.textTheme.titleMedium
                        ?.copyWith(
                      color: amountColor,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: amountColor.withValues(
                        alpha: .10,
                      ),
                      borderRadius:
                      BorderRadius.circular(
                        30,
                      ),
                    ),
                    child: Text(
                      transaction.isIncome
                          ? 'Income'
                          : 'Expense',
                      style: TextStyle(
                        color: amountColor,
                        fontWeight:
                        FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(
              AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: theme.brightness ==
                  Brightness.dark
                  ? const Color(
                0xFF26294A,
              )
                  : const Color(
                0xFFF6F3FF,
              ),
              borderRadius:
              BorderRadius.circular(16),
              border: Border.all(
                color: theme.colorScheme.primary
                    .withValues(alpha: .12),
              ),
            ),
            child: Text(
              transaction.note!,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Color _cardColor(BuildContext context) {
  final theme = Theme.of(context);

  return theme.brightness == Brightness.dark
      ? const Color(0xFF222C49)
      : const Color(0xFFF8F9FD);
}