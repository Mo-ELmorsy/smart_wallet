import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_wallet/core/di/injection.dart';
import 'package:smart_wallet/features/budgets/domain/models/budget.dart';
import 'package:smart_wallet/features/budgets/domain/repositories/budget_repository.dart';
import 'package:smart_wallet/features/transactions/domain/models/transaction_type.dart';
import 'package:smart_wallet/features/transactions/domain/repositories/transaction_repository.dart';

part 'budgets_provider.g.dart';

class BudgetWithProgress {
  final Budget budget;
  final double spent;
  
  BudgetWithProgress({required this.budget, required this.spent});

  double get progress => spent / budget.amount;
  bool get isOverBudget => spent > budget.amount;
  bool get isWarning => progress >= 0.8 && progress <= 1.0;
}

@riverpod
class BudgetsNotifier extends _$BudgetsNotifier {
  @override
  Future<List<BudgetWithProgress>> build() async {
    final repo = getIt<BudgetRepository>();
    final txRepo = getIt<TransactionRepository>();
    
    final budgetsRes = await repo.getAllBudgets();
    return budgetsRes.fold(
      (l) => throw Exception(l.message),
      (budgets) async {
        final now = DateTime.now();
        final txRes = await txRepo.getMonthlyTransactions(now.year, now.month);
        
        return txRes.fold(
          (l) => throw Exception(l.message),
          (transactions) {
            final List<BudgetWithProgress> result = [];
            for (var budget in budgets) {
              if (budget.month == now.month && budget.year == now.year) {
                double spent = 0;
                for (var tx in transactions) {
                  if (tx.categoryId == budget.categoryId && tx.type == TransactionType.expense) {
                    spent += tx.amount;
                  }
                }
                result.add(BudgetWithProgress(budget: budget, spent: spent));
              }
            }
            return result;
          },
        );
      },
    );
  }

  Future<void> addBudget(Budget budget) async {
    final repo = getIt<BudgetRepository>();
    final result = await repo.addBudget(budget);
    result.fold(
      (l) => throw Exception(l.message),
      (r) => ref.invalidateSelf(),
    );
  }

  Future<void> deleteBudget(String id) async {
    final repo = getIt<BudgetRepository>();
    final result = await repo.deleteBudget(id);
    result.fold(
      (l) => throw Exception(l.message),
      (r) => ref.invalidateSelf(),
    );
  }
}
