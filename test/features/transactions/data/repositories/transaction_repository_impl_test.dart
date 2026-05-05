import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:smart_wallet/features/transactions/data/datasources/transaction_local_data_source.dart';
import 'package:smart_wallet/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:smart_wallet/features/transactions/domain/models/transaction.dart';
import 'package:smart_wallet/features/transactions/domain/models/transaction_type.dart';
import 'package:smart_wallet/features/transactions/domain/models/category.dart';
import 'transaction_repository_impl_test.mocks.dart';

@GenerateMocks([TransactionLocalDataSource])
void main() {
  late TransactionRepositoryImpl repository;
  late MockTransactionLocalDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockTransactionLocalDataSource();
    repository = TransactionRepositoryImpl(mockDataSource);
  });

  final tTransaction = Transaction(
    id: '1',
    amount: 10.0,
    type: TransactionType.expense,
    categoryId: '1',
    date: DateTime.now(),
  );

  test('should return list of transactions from local data source', () async {
    when(mockDataSource.getAllTransactions()).thenAnswer((_) async => [tTransaction]);
    
    final result = await repository.getAllTransactions();
    
    expect(result.isRight(), true);
    result.fold(
      (failure) => fail('Expected Right'),
      (transactions) => expect(transactions, [tTransaction]),
    );
    verify(mockDataSource.getAllTransactions());
    verifyNoMoreInteractions(mockDataSource);
  });

  test('should return CacheFailure when local data source throws on get', () async {
    when(mockDataSource.getAllTransactions()).thenThrow(Exception());
    
    final result = await repository.getAllTransactions();
    
    expect(result.isLeft(), true);
  });

  test('should call addTransaction on data source and return Right', () async {
    when(mockDataSource.addTransaction(any)).thenAnswer((_) async => Future.value());
    
    final result = await repository.addTransaction(tTransaction);
    
    expect(result.isRight(), true);
    verify(mockDataSource.addTransaction(tTransaction));
    verifyNoMoreInteractions(mockDataSource);
  });

  test('should call deleteTransaction on data source and return Right', () async {
    when(mockDataSource.deleteTransaction(any)).thenAnswer((_) async => Future.value());
    
    final result = await repository.deleteTransaction('1');
    
    expect(result.isRight(), true);
    verify(mockDataSource.deleteTransaction('1'));
    verifyNoMoreInteractions(mockDataSource);
  });
}
