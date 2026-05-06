import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_wallet/core/di/injection.dart';
import 'package:smart_wallet/features/transactions/domain/models/category.dart';
import 'package:smart_wallet/features/transactions/domain/models/transaction_type.dart';
import 'package:smart_wallet/features/transactions/domain/repositories/transaction_repository.dart';

part 'categories_provider.g.dart';

@riverpod
class CategoriesNotifier extends _$CategoriesNotifier {
  @override
  Future<List<Category>> build() async {
    return _loadCategories();
  }

  Future<List<Category>> _loadCategories() async {
    final repo = getIt<TransactionRepository>();
    final result = await repo.getCategories();
    
    return result.fold(
      (l) => [],
      (r) async {
        if (r.isEmpty) {
          await _seedDefaultCategories();
          final reFetch = await repo.getCategories();
          return reFetch.getOrElse(() => []);
        }
        return r;
      },
    );
  }

  Future<void> _seedDefaultCategories() async {
    final repo = getIt<TransactionRepository>();
    
    final defaults = [
      // Expenses
      Category(id: 'cat_food', name: 'Food', colorCode: Colors.orange.toARGB32(), iconData: 'restaurant', type: TransactionType.expense),
      Category(id: 'cat_transport', name: 'Transport', colorCode: Colors.blue.toARGB32(), iconData: 'directions_car', type: TransactionType.expense),
      Category(id: 'cat_rent', name: 'Rent', colorCode: Colors.brown.toARGB32(), iconData: 'home', type: TransactionType.expense),
      Category(id: 'cat_bills', name: 'Bills', colorCode: Colors.red.toARGB32(), iconData: 'receipt', type: TransactionType.expense),
      Category(id: 'cat_shopping', name: 'Shopping', colorCode: Colors.pink.toARGB32(), iconData: 'shopping_bag', type: TransactionType.expense),
      Category(id: 'cat_health', name: 'Health', colorCode: Colors.redAccent.toARGB32(), iconData: 'favorite', type: TransactionType.expense),
      Category(id: 'cat_education', name: 'Education', colorCode: Colors.teal.toARGB32(), iconData: 'school', type: TransactionType.expense),
      Category(id: 'cat_entertainment', name: 'Entertainment', colorCode: Colors.purple.toARGB32(), iconData: 'movie', type: TransactionType.expense),
      Category(id: 'cat_other_exp', name: 'Other', colorCode: Colors.grey.toARGB32(), iconData: 'more_horiz', type: TransactionType.expense),
      
      // Incomes
      Category(id: 'cat_salary', name: 'Salary', colorCode: Colors.green.toARGB32(), iconData: 'attach_money', type: TransactionType.income),
      Category(id: 'cat_freelance', name: 'Freelance', colorCode: Colors.cyan.toARGB32(), iconData: 'computer', type: TransactionType.income),
      Category(id: 'cat_investment', name: 'Investment', colorCode: Colors.indigo.toARGB32(), iconData: 'trending_up', type: TransactionType.income),
      Category(id: 'cat_gift', name: 'Gift', colorCode: Colors.amber.toARGB32(), iconData: 'card_giftcard', type: TransactionType.income),
      Category(id: 'cat_other_inc', name: 'Other', colorCode: Colors.blueGrey.toARGB32(), iconData: 'more_horiz', type: TransactionType.income),
    ];

    for (var cat in defaults) {
      await repo.addCategory(cat);
    }
  }

  Future<void> addCategory(Category category) async {
    final repo = getIt<TransactionRepository>();
    final result = await repo.addCategory(category);
    result.fold((l) {}, (r) {
      ref.invalidateSelf();
    });
  }
}
