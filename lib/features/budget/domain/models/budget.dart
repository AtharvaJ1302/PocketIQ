import '../../../../core/database/database_constants.dart';

class Budget {
  final int? id;

  final String category;

  final double budgetAmount;

  final bool notificationsEnabled;

  final int notificationThreshold;

  final int lastNotificationThreshold;

  final DateTime createdAt;

  final DateTime updatedAt;

  const Budget({
    this.id,
    required this.category,
    required this.budgetAmount,
    required this.notificationsEnabled,
    required this.notificationThreshold,
    required this.lastNotificationThreshold,
    required this.createdAt,
    required this.updatedAt,
  });

  Budget copyWith({
    int? id,
    String? category,
    double? budgetAmount,
    bool? notificationsEnabled,
    int? notificationThreshold,
    int? lastNotificationThreshold,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Budget(
      id: id ?? this.id,
      category: category ?? this.category,
      budgetAmount:
      budgetAmount ?? this.budgetAmount,
      notificationsEnabled:
      notificationsEnabled ??
          this.notificationsEnabled,
      notificationThreshold:
      notificationThreshold ??
          this.notificationThreshold,
      lastNotificationThreshold:
      lastNotificationThreshold ??
          this.lastNotificationThreshold,
      createdAt:
      createdAt ?? this.createdAt,
      updatedAt:
      updatedAt ?? this.updatedAt,
    );
  }

  factory Budget.fromMap(
      Map<String, dynamic> map,
      ) {
    return Budget(
      id: map[BudgetColumns.id],
      category:
      map[BudgetColumns.category],
      budgetAmount:
      (map[BudgetColumns.budgetAmount]
      as num)
          .toDouble(),
      notificationsEnabled:
      map[BudgetColumns
          .notificationsEnabled] ==
          1,
      notificationThreshold:
      map[BudgetColumns
          .notificationThreshold],
      lastNotificationThreshold:
      map[BudgetColumns
          .lastNotificationThreshold],
      createdAt: DateTime.parse(
        map[BudgetColumns.createdAt],
      ),
      updatedAt: DateTime.parse(
        map[BudgetColumns.updatedAt],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      BudgetColumns.id: id,
      BudgetColumns.category: category,
      BudgetColumns.budgetAmount:
      budgetAmount,
      BudgetColumns.notificationsEnabled:
      notificationsEnabled ? 1 : 0,
      BudgetColumns.notificationThreshold:
      notificationThreshold,
      BudgetColumns.lastNotificationThreshold:
      lastNotificationThreshold,
      BudgetColumns.createdAt:
      createdAt.toIso8601String(),
      BudgetColumns.updatedAt:
      updatedAt.toIso8601String(),
    };
  }
}