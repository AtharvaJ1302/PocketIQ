class Currencies {
  Currencies._();

  static const inr = 'INR';

  static const supported = [
    inr,
  ];

  static String getName(String code) {
    switch (code) {
      case inr:
        return '₹ Indian Rupee';
      default:
        return code;
    }
  }
}