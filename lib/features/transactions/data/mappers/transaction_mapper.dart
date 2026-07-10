import '../../../../core/database/database_constants.dart';
import '../../domain/models/transaction.dart';
import '../../domain/models/transaction_type.dart';

class TransactionMapper {
  TransactionMapper._();

  static Map<String, dynamic> toMap(
      Transaction transaction,
      ) {
    return {
      TransactionColumns.id: transaction.id,
      TransactionColumns.accountId:
      transaction.accountId,
      TransactionColumns.category:
      transaction.category,
      TransactionColumns.amount:
      transaction.amount,
      TransactionColumns.type:
      transaction.type.name,
      TransactionColumns.note:
      transaction.note,
      TransactionColumns.date:
      transaction.date.toIso8601String(),
    };
  }

  static Transaction fromMap(
      Map<String, dynamic> map,
      ) {
    return Transaction(
      id: map[TransactionColumns.id],
      accountId:
      map[TransactionColumns.accountId],
      category:
      map[TransactionColumns.category],
      amount:
      (map[TransactionColumns.amount] as num)
          .toDouble(),
      type: TransactionType.values.firstWhere(
            (type) =>
        type.name ==
            map[TransactionColumns.type],
      ),
      note: map[TransactionColumns.note],
      date: DateTime.parse(
        map[TransactionColumns.date],
      ),
    );
  }
}