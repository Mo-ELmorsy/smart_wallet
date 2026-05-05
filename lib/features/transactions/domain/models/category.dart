import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'transaction_type.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
class Category with _$Category {
  @HiveType(typeId: 1, adapterName: 'CategoryAdapter')
  const factory Category({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required int colorCode,
    @HiveField(3) required String iconData,
    @HiveField(4) required TransactionType type,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
}
