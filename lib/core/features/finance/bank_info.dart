import 'bank_codes.dart';

class BankInfo {
  BankInfo._();

  static const Map<String, String> _bankNames = {
    BankCodes.icici: 'ICICI Bank',
    BankCodes.sbi: 'State Bank of India',
    BankCodes.hdfc: 'HDFC Bank',
    BankCodes.axis: 'Axis Bank',
    BankCodes.kotak: 'Kotak Mahindra Bank',
    BankCodes.idfc: 'IDFC FIRST Bank',
    BankCodes.pnb: 'Punjab National Bank',
    BankCodes.bob: 'Bank of Baroda',
    BankCodes.canara: 'Canara Bank',
    BankCodes.union: 'Union Bank',
    BankCodes.cash: 'Cash',
    BankCodes.wallet: 'Wallet',
  };

  static String getName(String bankCode) {
    return _bankNames[bankCode] ?? 'Unknown Bank';
  }

  static List<String> get supportedBanks {
    return _bankNames.keys.toList();
  }

}