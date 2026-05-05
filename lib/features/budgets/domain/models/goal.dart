import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'goal.freezed.dart';
part 'goal.g.dart';

@freezed
class Goal with _$Goal {
  @HiveType(typeId: 4, adapterName: 'GoalAdapter')
  const factory Goal({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required double targetAmount,
    @HiveField(3) required double currentAmount,
    @HiveField(4) required DateTime targetDate,
    @HiveField(5) required int colorCode,
  }) = _Goal;

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);
}
