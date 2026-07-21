import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/features/constants/app_categories.dart';
import '../../../../core/features/constants/app_radius.dart';
import '../../../../core/features/constants/app_spacing.dart';
import '../../../../core/features/utils/currency_formatter.dart';
import '../../../shared/components/indicators/pocket_progress_bar.dart';
import '../domain/models/budget_summary.dart';
import '../presentation/providers/budget_scroll_provider.dart';
import '../presentation/providers/highlight_budget_provider.dart';

class BudgetTile extends ConsumerStatefulWidget {
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
  ConsumerState<BudgetTile> createState() =>
      _BudgetTileState();
}

class _BudgetTileState
    extends ConsumerState<BudgetTile> {

  final GlobalKey _tileKey = GlobalKey();

  bool _highlighted = false;

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

    final highlightedCategory = ref.watch(
      highlightBudgetProvider,
    ).highlightedCategory;

    final shouldHighlight =
        highlightedCategory ==
            widget.summary.budget.category;

    if (shouldHighlight != _highlighted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        setState(() {
          _highlighted = shouldHighlight;
        });
      });
    }

    final category = AppCategories.byName(
      widget.summary.budget.category,
    );

    return AnimatedScale(
        scale: _highlighted ? 1.03 : 1.0,
        duration: const Duration(
          milliseconds: 350,
        ),
        curve: Curves.easeOut,

        child: AnimatedContainer(
            duration: const Duration(
              milliseconds: 350,
            ),

          decoration: BoxDecoration(
            borderRadius: AppRadius.borderRadiusLg,

            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: theme.brightness == Brightness.dark
                  ? const [
                Color(0xFF25264A),
                Color(0xFF1B1D38),
              ]
                  : [
                theme.colorScheme.surface,
                theme.colorScheme.surfaceContainer,
              ],
            ),

            border: Border.all(
              color: theme.colorScheme.outlineVariant.withValues(alpha: .18),
              width: 1,
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .08),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
      child: Container(
        key: _tileKey,
        width: double.infinity,
        padding: const EdgeInsets.all(
          AppSpacing.lg,
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor:
                  category?.color.withValues(alpha: .15) ??
                      theme.colorScheme.primary.withValues(alpha: .15),
                  child: Icon(
                    category?.icon ?? Icons.category,
                    color: category?.color ?? theme.colorScheme.primary,
                    size: 24,
                  ),
                ),

                const SizedBox(width: AppSpacing.md),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.summary.budget.category,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        '${widget.summary.percentageLabel} of budget used',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
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

            PocketProgressBar(
              progress: widget.summary.progress,
            ),

            const SizedBox(
              height: AppSpacing.sm,
            ),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${widget.summary.percentageLabel} of budget used',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),

            const SizedBox(
              height: AppSpacing.xl,
            ),

            Row(
              children: [
                Expanded(
                  child: _BudgetMetric(
                    title: 'Budget',
                    value: CurrencyFormatter.format(
                      widget.summary.budget.budgetAmount,
                    ),
                    valueColor: const Color(0xFF7C5CFF),
                  ),
                ),

                Expanded(
                  child: _BudgetMetric(
                    title: 'Spent',
                    value: CurrencyFormatter.format(
                      widget.summary.spent,
                    ),
                    valueColor: const Color(0xFFFF8A34),
                  ),
                ),

                Expanded(
                  child: _BudgetMetric(
                    title: widget.summary.isExceeded
                        ? 'Exceeded'
                        : 'Remaining',
                    value: CurrencyFormatter.format(
                      widget.summary.isExceeded
                          ? widget.summary.exceeded
                          : widget.summary.remaining,
                    ),
                    valueColor: widget.summary.isExceeded
                        ? Colors.red
                        : const Color(0xFF38D67A),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
        ),
    );
  }
}

class _BudgetMetric extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;

  const _BudgetMetric({
    required this.title,
    required this.value,
    this.valueColor,
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
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}