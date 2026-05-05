import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'transaction_type.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
class Transaction with _$Transaction {
  @HiveType(typeId: 0, adapterName: 'TransactionAdapter')
  const factory Transaction({
    @HiveField(0) required String id,
    @HiveField(1) required double amount,
    @HiveField(2) required TransactionType type,
    @HiveField(3) required String categoryId,
    @HiveField(4) required DateTime date,
    @HiveField(5) String? note,
    @HiveField(6) String? receiptPath,
    @HiveField(7) DateTime? createdAt,
    @HiveField(8) DateTime? updatedAt,
    @HiveField(9) String? categoryName,
    @HiveField(10) int? categoryColorCode,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
}
