import 'package:flutter_test/flutter_test.dart';
import 'package:smart_wallet/features/budgets/domain/models/budget.dart';
import 'package:smart_wallet/features/budgets/presentation/providers/budgets_provider.dart';

void main() {
  group('BudgetWithProgress', () {
    test('calculates progress correctly', () {
      const budget = Budget(
        id: '1',
        categoryId: 'cat1',
        amount: 1000.0,
        month: 5,
        year: 2026,
      );

      final withProgress = BudgetWithProgress(budget: budget, spent: 500.0);
      
      expect(withProgress.progress, 0.5);
      expect(withProgress.isOverBudget, false);
      expect(withProgress.isWarning, false);
    });

    test('identifies warning state', () {
      const budget = Budget(
        id: '1',
        categoryId: 'cat1',
        amount: 1000.0,
        month: 5,
        year: 2026,
      );

      final withProgress = BudgetWithProgress(budget: budget, spent: 850.0);
      
      expect(withProgress.progress, 0.85);
      expect(withProgress.isOverBudget, false);
      expect(withProgress.isWarning, true);
    });

    test('identifies over budget state', () {
      const budget = Budget(
        id: '1',
        categoryId: 'cat1',
        amount: 1000.0,
        month: 5,
        year: 2026,
      );

      final withProgress = BudgetWithProgress(budget: budget, spent: 1200.0);
      
      expect(withProgress.progress, 1.2);
      expect(withProgress.isOverBudget, true);
      expect(withProgress.isWarning, false); // isOverBudget takes precedence in UI, but technically > 1.0 is not between 0.8 and 1.0
    });
  });
}
