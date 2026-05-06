import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_wallet/core/utils/constants.dart';
import 'package:smart_wallet/features/transactions/domain/models/transaction.dart';
import 'package:smart_wallet/features/transactions/domain/models/category.dart';
import 'package:smart_wallet/features/budgets/domain/models/budget.dart';
import 'package:smart_wallet/features/budgets/domain/models/goal.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<Box<Transaction>> get transactionBox => Hive.openBox<Transaction>(AppConstants.transactionsBox);
  
  @preResolve
  Future<Box<Category>> get categoryBox => Hive.openBox<Category>('categories');
  
  @preResolve
  Future<Box<Budget>> get budgetBox => Hive.openBox<Budget>(AppConstants.budgetsBox);
  
  @preResolve
  Future<Box<Goal>> get goalBox => Hive.openBox<Goal>('goals');
  
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
