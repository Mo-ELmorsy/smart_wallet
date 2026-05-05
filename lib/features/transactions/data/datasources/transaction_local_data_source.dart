import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../domain/models/transaction.dart';
import '../../domain/models/transaction_type.dart';
import '../../domain/models/category.dart';

abstract class TransactionLocalDataSource {
  Future<List<Transaction>> getAllTransactions();
  Future<void> addTransaction(Transaction transaction);
  Future<void> updateTransaction(Transaction transaction);
  Future<void> deleteTransaction(String id);
  
  Future<List<Transaction>> getTransactionsByDateRange(DateTime start, DateTime end);
  Future<List<Transaction>> getTransactionsByCategory(String categoryId);
  Future<List<Transaction>> getMonthlyTransactions(int year, int month);
  
  Future<List<Category>> getCategories();
  Future<void> addCategory(Category category);
}

@LazySingleton(as: TransactionLocalDataSource)
class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  final Box<Transaction> transactionBox;
  final Box<Category> categoryBox;

  TransactionLocalDataSourceImpl(this.transactionBox, this.categoryBox);

  @override
  Future<List<Transaction>> getAllTransactions() async {
    return transactionBox.values.toList();
  }

  @override
  Future<void> addTransaction(Transaction transaction) async {
    await transactionBox.put(transaction.id, transaction);
  }

  @override
  Future<void> updateTransaction(Transaction transaction) async {
    await transactionBox.put(transaction.id, transaction);
  }

  @override
  Future<void> deleteTransaction(String id) async {
    await transactionBox.delete(id);
  }

  @override
  Future<List<Transaction>> getTransactionsByDateRange(DateTime start, DateTime end) async {
    return transactionBox.values.where((t) => 
      t.date.isAfter(start.subtract(const Duration(days: 1))) && 
      t.date.isBefore(end.add(const Duration(days: 1)))
    ).toList();
  }

  @override
  Future<List<Transaction>> getTransactionsByCategory(String categoryId) async {
    return transactionBox.values.where((t) => t.categoryId == categoryId).toList();
  }

  @override
  Future<List<Transaction>> getMonthlyTransactions(int year, int month) async {
    return transactionBox.values.where((t) => t.date.year == year && t.date.month == month).toList();
  }

  @override
  Future<List<Category>> getCategories() async {
    if (categoryBox.isEmpty) {
      await _initDefaultCategories();
    }
    return categoryBox.values.toList();
  }

  Future<void> _initDefaultCategories() async {
    final defaultExpenses = ['Food', 'Transport', 'Rent', 'Bills', 'Shopping', 'Health', 'Education', 'Entertainment', 'Other'];
    final defaultIncomes = ['Salary', 'Freelance', 'Investment', 'Gift', 'Other'];

    for (var name in defaultExpenses) {
      final c = Category(id: 'exp_${name.toLowerCase()}', name: name, colorCode: 0xFFF44336, iconData: 'money_off', type: TransactionType.expense);
      await categoryBox.put(c.id, c);
    }
    for (var name in defaultIncomes) {
      final c = Category(id: 'inc_${name.toLowerCase()}', name: name, colorCode: 0xFF4CAF50, iconData: 'attach_money', type: TransactionType.income);
      await categoryBox.put(c.id, c);
    }
  }

  @override
  Future<void> addCategory(Category category) async {
    await categoryBox.put(category.id, category);
  }
}
