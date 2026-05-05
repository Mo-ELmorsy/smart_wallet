import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_wallet/shared/failures/app_failure.dart';
import '../models/transaction.dart';
import '../repositories/transaction_repository.dart';

@injectable
class GetTransactionsUseCase {
  final TransactionRepository repository;

  GetTransactionsUseCase(this.repository);

  Future<Either<AppFailure, List<Transaction>>> call() {
    return repository.getAllTransactions();
  }
}
