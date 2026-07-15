import 'statement_period.dart';
import 'statement_type.dart';

class StatementOptions {
  final StatementType type;

  final StatementPeriod period;

  final bool includeCategories;
  final bool includeBudgetSummary;
  final bool includeNotes;

  final DateTime? from;
  final DateTime? to;

  const StatementOptions({
    this.type = StatementType.pdf,
    this.period = StatementPeriod.thisMonth,
    this.includeCategories = true,
    this.includeBudgetSummary = true,
    this.includeNotes = true,
    this.from,
    this.to,
  });

  StatementOptions copyWith({
    StatementType? type,
    StatementPeriod? period,
    bool? includeCategories,
    bool? includeBudgetSummary,
    bool? includeNotes,
    DateTime? from,
    DateTime? to,
  }) {
    return StatementOptions(
      type: type ?? this.type,
      period: period ?? this.period,
      includeCategories:
      includeCategories ?? this.includeCategories,
      includeBudgetSummary:
      includeBudgetSummary ??
          this.includeBudgetSummary,
      includeNotes:
      includeNotes ?? this.includeNotes,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }
}