import 'package:flutter/material.dart';

import '../../../../core/features/constants/app_categories.dart';
import '../../../../core/features/constants/app_radius.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/utils/currency_formatter.dart';
import '../../../shared/components/indicators/pocket_progress_bar.dart';
import '../domain/models/budget_summary.dart';
import '../presentation/providers/budget_scroll_provider.dart';

class BudgetTile extends StatefulWidget {
  final BudgetSummary summary;

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const BudgetTile({
    super.key,
    required this.summary,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<BudgetTile> createState() =>
      _BudgetTileState();
}

class _BudgetTileState
    extends State<BudgetTile> {

  final GlobalKey _tileKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      BudgetScrollService.instance.register(
        widget.summary.budget.category,
        _tileKey,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final category = AppCategories.byName(
      widget.summary.budget.category,
    );

    return Container(
      key: _tileKey,
      width: double.infinity,
      padding: const EdgeInsets.all(
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius:
        AppRadius.borderRadiusLg,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor:
                category?.color.withValues(
                  alpha: .15,
                ) ??
                    theme.colorScheme.primary
                        .withValues(
                      alpha: .15,
                    ),
                child: Icon(
                  category?.icon ??
                      Icons.category,
                  color:
                  category?.color ??
                      theme.colorScheme
                          .primary,
                ),
              ),

              const SizedBox(
                width: AppSpacing.md,
              ),

              Expanded(
                child: Text(
                  widget.summary.budget.category,
                  style: theme
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),

              Text(
                widget.summary.percentageLabel,
                style: theme
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'edit':
                      widget.onEdit();
                      break;

                    case 'delete':
                      widget.onDelete();
                      break;
                  }
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit_outlined),
                        SizedBox(width: 12),
                        Text('Edit Budget'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline),
                        SizedBox(width: 12),
                        Text('Delete Budget'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          Row(
            children: [
              Expanded(
                child: _BudgetMetric(
                  title: 'Budget',
                  value: CurrencyFormatter
                      .format(
                    widget.summary.budget
                        .budgetAmount,
                  ),
                ),
              ),

              Expanded(
                child: _BudgetMetric(
                  title: 'Spent',
                  value: CurrencyFormatter
                      .format(
                    widget.summary.spent,
                  ),
                ),
              ),

              Expanded(
                child: _BudgetMetric(
                  title: widget
                      .summary.isExceeded
                      ? 'Exceeded'
                      : 'Remaining',
                  value: CurrencyFormatter
                      .format(
                    widget.summary.isExceeded
                        ? widget.summary
                        .exceeded
                        : widget.summary
                        .remaining,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          PocketProgressBar(
            progress:
            widget.summary.progress,
          ),
        ],
      ),
    );
  }
}

class _BudgetMetric extends StatelessWidget {
  final String title;
  final String value;

  const _BudgetMetric({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
          theme.textTheme.bodySmall,
        ),

        const SizedBox(
          height: AppSpacing.xs,
        ),

        Text(
          value,
          style: theme.textTheme
              .titleMedium
              ?.copyWith(
            fontWeight:
            FontWeight.bold,
          ),
        ),
      ],
    );
  }
}