import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'budget.freezed.dart';
part 'budget.g.dart';

@freezed
class Budget with _$Budget {
  @HiveType(typeId: 3, adapterName: 'BudgetAdapter')
  const factory Budget({
    @HiveField(0) required String id,
    @HiveField(1) required String categoryId,
    @HiveField(2) required double amount,
    @HiveField(3) required int month,
    @HiveField(4) required int year,
  }) = _Budget;

  factory Budget.fromJson(Map<String, dynamic> json) => _$BudgetFromJson(json);
}
