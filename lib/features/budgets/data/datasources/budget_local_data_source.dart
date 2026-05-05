import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../domain/models/budget.dart';
import '../../domain/models/goal.dart';

abstract class BudgetLocalDataSource {
  Future<List<Budget>> getAllBudgets();
  Future<Budget?> getBudgetByCategory(String categoryId);
  Future<void> addBudget(Budget budget);
  Future<void> updateBudget(Budget budget);
  Future<void> deleteBudget(String id);
  
  Future<List<Goal>> getAllGoals();
  Future<void> addGoal(Goal goal);
  Future<void> updateGoal(Goal goal);
  Future<void> deleteGoal(String id);
}

@LazySingleton(as: BudgetLocalDataSource)
class BudgetLocalDataSourceImpl implements BudgetLocalDataSource {
  final Box<Budget> budgetBox;
  final Box<Goal> goalBox;

  BudgetLocalDataSourceImpl(this.budgetBox, this.goalBox);

  @override
  Future<List<Budget>> getAllBudgets() async {
    return budgetBox.values.toList();
  }

  @override
  Future<Budget?> getBudgetByCategory(String categoryId) async {
    try {
      return budgetBox.values.firstWhere((b) => b.categoryId == categoryId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> addBudget(Budget budget) async {
    await budgetBox.put(budget.id, budget);
  }

  @override
  Future<void> updateBudget(Budget budget) async {
    await budgetBox.put(budget.id, budget);
  }

  @override
  Future<void> deleteBudget(String id) async {
    await budgetBox.delete(id);
  }

  @override
  Future<List<Goal>> getAllGoals() async {
    return goalBox.values.toList();
  }

  @override
  Future<void> addGoal(Goal goal) async {
    await goalBox.put(goal.id, goal);
  }

  @override
  Future<void> updateGoal(Goal goal) async {
    await goalBox.put(goal.id, goal);
  }

  @override
  Future<void> deleteGoal(String id) async {
    await goalBox.delete(id);
  }
}
