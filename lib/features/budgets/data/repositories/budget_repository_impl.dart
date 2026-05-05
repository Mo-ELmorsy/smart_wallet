import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_wallet/shared/failures/app_failure.dart';
import '../../domain/models/budget.dart';
import '../../domain/models/goal.dart';
import '../../domain/repositories/budget_repository.dart';
import '../datasources/budget_local_data_source.dart';

@LazySingleton(as: BudgetRepository)
class BudgetRepositoryImpl implements BudgetRepository {
  final BudgetLocalDataSource localDataSource;

  BudgetRepositoryImpl(this.localDataSource);

  @override
  Future<Either<AppFailure, List<Budget>>> getAllBudgets() async {
    try {
      final budgets = await localDataSource.getAllBudgets();
      return Right(budgets);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, Budget?>> getBudgetByCategory(String categoryId) async {
    try {
      final budget = await localDataSource.getBudgetByCategory(categoryId);
      return Right(budget);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> addBudget(Budget budget) async {
    try {
      await localDataSource.addBudget(budget);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> updateBudget(Budget budget) async {
    try {
      await localDataSource.updateBudget(budget);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> deleteBudget(String id) async {
    try {
      await localDataSource.deleteBudget(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, List<Goal>>> getAllGoals() async {
    try {
      final goals = await localDataSource.getAllGoals();
      return Right(goals);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> addGoal(Goal goal) async {
    try {
      await localDataSource.addGoal(goal);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> updateGoal(Goal goal) async {
    try {
      await localDataSource.updateGoal(goal);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> deleteGoal(String id) async {
    try {
      await localDataSource.deleteGoal(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
