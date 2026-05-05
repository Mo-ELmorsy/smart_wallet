import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:smart_wallet/features/budgets/data/datasources/budget_local_data_source.dart';
import 'package:smart_wallet/features/budgets/data/repositories/budget_repository_impl.dart';
import 'package:smart_wallet/features/budgets/domain/models/budget.dart';
import 'budget_repository_impl_test.mocks.dart';

@GenerateMocks([BudgetLocalDataSource])
void main() {
  late BudgetRepositoryImpl repository;
  late MockBudgetLocalDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockBudgetLocalDataSource();
    repository = BudgetRepositoryImpl(mockDataSource);
  });

  const tBudget = Budget(
    id: '1',
    categoryId: 'food',
    amount: 1000.0,
    month: 5,
    year: 2026,
  );

  test('should return list of budgets from local data source', () async {
    when(mockDataSource.getAllBudgets()).thenAnswer((_) async => [tBudget]);
    
    final result = await repository.getAllBudgets();
    
    expect(result.isRight(), true);
    verify(mockDataSource.getAllBudgets());
  });

  test('should return CacheFailure when local data source throws on get', () async {
    when(mockDataSource.getAllBudgets()).thenThrow(Exception());
    
    final result = await repository.getAllBudgets();
    
    expect(result.isLeft(), true);
  });
}
