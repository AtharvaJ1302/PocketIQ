class FinanceCategories {
  FinanceCategories._();

  // Expense Categories
  static const food = 'Food';
  static const groceries = 'Groceries';
  static const shopping = 'Shopping';
  static const fuel = 'Fuel';
  static const bills = 'Bills';
  static const otherExpense = 'Other';

  // Income Categories
  static const salary = 'Salary';
  static const bonus = 'Bonus';
  static const gift = 'Gift';
  static const otherIncome = 'Other';

  static const expenseCategories = [
    food,
    groceries,
    shopping,
    // transport,
    fuel,
    bills,
    // entertainment,
    // health,
    // education,
    // travel,
    // rent,
    // emi,
    // investment,
    otherExpense,
  ];

  static const incomeCategories = [
    salary,
    bonus,
    // freelance,
    // cashback,
    // interest,
    gift,
    otherIncome,
  ];
}