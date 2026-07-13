class MonthlySummary {
  final int year;
  final int month;
  final double income;
  final double expense;

  const MonthlySummary({
    required this.year,
    required this.month,
    required this.income,
    required this.expense,
  });

  double get savings => income - expense;
}