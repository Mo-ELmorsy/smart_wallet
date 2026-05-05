import 'package:dartz/dartz.dart';
import 'package:smart_wallet/shared/failures/app_failure.dart';
import '../models/transaction.dart';
import '../models/category.dart';

abstract class TransactionRepository {
  Future<Either<AppFailure, List<Transaction>>> getAllTransactions();
  Future<Either<AppFailure, void>> addTransaction(Transaction transaction);
  Future<Either<AppFailure, void>> updateTransaction(Transaction transaction);
  Future<Either<AppFailure, void>> deleteTransaction(String id);
  
  Future<Either<AppFailure, List<Transaction>>> getTransactionsByDateRange(DateTime start, DateTime end);
  Future<Either<AppFailure, List<Transaction>>> getTransactionsByCategory(String categoryId);
  Future<Either<AppFailure, List<Transaction>>> getMonthlyTransactions(int year, int month);
  
  Future<Either<AppFailure, List<Category>>> getCategories();
  Future<Either<AppFailure, void>> addCategory(Category category);
}
