import 'package:dartz/dartz.dart';
import 'package:smart_wallet/shared/failures/app_failure.dart';
import '../models/budget.dart';
import '../models/goal.dart';

abstract class BudgetRepository {
  Future<Either<AppFailure, List<Budget>>> getAllBudgets();
  Future<Either<AppFailure, Budget?>> getBudgetByCategory(String categoryId);
  Future<Either<AppFailure, void>> addBudget(Budget budget);
  Future<Either<AppFailure, void>> updateBudget(Budget budget);
  Future<Either<AppFailure, void>> deleteBudget(String id);
  
  Future<Either<AppFailure, List<Goal>>> getAllGoals();
  Future<Either<AppFailure, void>> addGoal(Goal goal);
  Future<Either<AppFailure, void>> updateGoal(Goal goal);
  Future<Either<AppFailure, void>> deleteGoal(String id);
}
