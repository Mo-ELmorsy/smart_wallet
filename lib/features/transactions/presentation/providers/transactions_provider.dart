import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_wallet/core/di/injection.dart';
import 'package:smart_wallet/features/transactions/domain/models/transaction.dart';
import 'package:smart_wallet/features/transactions/domain/models/transaction_type.dart';
import 'package:smart_wallet/features/transactions/domain/repositories/transaction_repository.dart';

part 'transactions_provider.g.dart';

@riverpod
class TransactionsNotifier extends _$TransactionsNotifier {
  @override
  Future<List<Transaction>> build() async {
    final repo = getIt<TransactionRepository>();
    final result = await repo.getAllTransactions();
    return result.fold(
      (l) => throw Exception(l.message),
      (r) {
        // Sort descending by date
        r.sort((a, b) => b.date.compareTo(a.date));
        return r;
      },
    );
  }

  Future<void> addTransaction(Transaction transaction) async {
    final repo = getIt<TransactionRepository>();
    final result = await repo.addTransaction(transaction);
    result.fold(
      (l) => throw Exception(l.message),
      (r) => ref.invalidateSelf(),
    );
  }

  Future<void> deleteTransaction(String id) async {
    final repo = getIt<TransactionRepository>();
    final result = await repo.deleteTransaction(id);
    result.fold(
      (l) => throw Exception(l.message),
      (r) => ref.invalidateSelf(),
    );
  }

  Future<void> updateTransaction(Transaction transaction) async {
    final repo = getIt<TransactionRepository>();
    final result = await repo.updateTransaction(transaction);
    result.fold(
      (l) => throw Exception(l.message),
      (r) => ref.invalidateSelf(),
    );
  }
}

@riverpod
class DashboardSummaryNotifier extends _$DashboardSummaryNotifier {
  @override
  Future<Map<String, double>> build() async {
    final repo = getIt<TransactionRepository>();
    
    // Simplification for MVP: getting all transactions and calculating
    // Ideally should use a specific usecase or repo method.
    final result = await repo.getAllTransactions();
    
    return result.fold(
      (l) => {'balance': 0.0, 'income': 0.0, 'expense': 0.0},
      (transactions) {
        double income = 0;
        double expense = 0;
        
        
        
        for (var t in transactions) {
          if (t.type == TransactionType.income) {
            income += t.amount;
          } else if (t.type == TransactionType.expense) {
            expense += t.amount;
          }
        }
        
        return {
          'balance': income - expense,
          'income': income,
          'expense': expense,
        };
      },
    );
  }
}
