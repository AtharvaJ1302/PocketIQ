class FinanceCategories {
  FinanceCategories._();

  // Expense Categories
  static const food = 'Food';
  static const groceries = 'Groceries';
  static const shopping = 'Shopping';
  // static const transport = 'Transport';
  static const fuel = 'Fuel';
  static const bills = 'Bills';
  // static const entertainment = 'Entertainment';
  // static const health = 'Health';
  // static const education = 'Education';
  // static const travel = 'Travel';
  // static const rent = 'Rent';
  // static const emi = 'EMI';
  // static const investment = 'Investment';
  static const otherExpense = 'Other';

  // Income Categories
  static const salary = 'Salary';
  static const bonus = 'Bonus';
  // static const freelance = 'Freelance';
  // static const cashback = 'Cashback';
  // static const interest = 'Interest';
  static const gift = 'Gift';
  static const otherIncome = 'Other Income';

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