import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_wallet/core/di/injection.dart';
import 'package:smart_wallet/features/budgets/domain/models/goal.dart';
import 'package:smart_wallet/features/budgets/domain/repositories/budget_repository.dart';

part 'goals_provider.g.dart';

@riverpod
class GoalsNotifier extends _$GoalsNotifier {
  @override
  Future<List<Goal>> build() async {
    final repo = getIt<BudgetRepository>();
    final result = await repo.getAllGoals();
    return result.fold(
      (l) => throw Exception(l.message),
      (r) => r,
    );
  }

  Future<void> addGoal(Goal goal) async {
    final repo = getIt<BudgetRepository>();
    final result = await repo.addGoal(goal);
    result.fold(
      (l) => throw Exception(l.message),
      (r) => ref.invalidateSelf(),
    );
  }

  Future<void> deleteGoal(String id) async {
    final repo = getIt<BudgetRepository>();
    final result = await repo.deleteGoal(id);
    result.fold(
      (l) => throw Exception(l.message),
      (r) => ref.invalidateSelf(),
    );
  }
}
