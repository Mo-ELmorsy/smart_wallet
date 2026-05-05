import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_wallet/shared/failures/app_failure.dart';
import '../../domain/models/transaction.dart';
import '../../domain/models/category.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_local_data_source.dart';

@LazySingleton(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDataSource localDataSource;

  TransactionRepositoryImpl(this.localDataSource);

  @override
  Future<Either<AppFailure, List<Transaction>>> getAllTransactions() async {
    try {
      final transactions = await localDataSource.getAllTransactions();
      return Right(transactions);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> addTransaction(Transaction transaction) async {
    try {
      await localDataSource.addTransaction(transaction);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> updateTransaction(Transaction transaction) async {
    try {
      await localDataSource.updateTransaction(transaction);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> deleteTransaction(String id) async {
    try {
      await localDataSource.deleteTransaction(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, List<Transaction>>> getTransactionsByDateRange(DateTime start, DateTime end) async {
    try {
      final transactions = await localDataSource.getTransactionsByDateRange(start, end);
      return Right(transactions);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, List<Transaction>>> getTransactionsByCategory(String categoryId) async {
    try {
      final transactions = await localDataSource.getTransactionsByCategory(categoryId);
      return Right(transactions);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, List<Transaction>>> getMonthlyTransactions(int year, int month) async {
    try {
      final transactions = await localDataSource.getMonthlyTransactions(year, month);
      return Right(transactions);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, List<Category>>> getCategories() async {
    try {
      final categories = await localDataSource.getCategories();
      return Right(categories);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> addCategory(Category category) async {
    try {
      await localDataSource.addCategory(category);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
