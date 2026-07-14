import 'package:pocketiq/features/statement/domain/models/statement_data.dart';

import 'statement_type.dart';

class StatementOptions {
  final StatementType type;

  final bool includeIncome;
  final bool includeExpense;
  final bool includeCategories;
  final bool includeNotes;

  final DateTime? from;
  final DateTime? to;

  const StatementOptions({
    this.type = StatementType.pdf,
    this.includeIncome = true,
    this.includeExpense = true,
    this.includeCategories = true,
    this.includeNotes = true,
    this.from,
    this.to,
  });

  StatementOptions copyWith({
    StatementType? type,
    bool? includeIncome,
    bool? includeExpense,
    bool? includeCategories,
    bool? includeNotes,
    DateTime? from,
    DateTime? to,
  }) {
    return StatementOptions(
      type: type ?? this.type,
      includeIncome: includeIncome ?? this.includeIncome,
      includeExpense: includeExpense ?? this.includeExpense,
      includeCategories:
      includeCategories ?? this.includeCategories,
      includeNotes:
      includeNotes ?? this.includeNotes,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }
}