import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_wallet/shared/failures/app_failure.dart';
import '../models/transaction.dart';
import '../repositories/transaction_repository.dart';

@injectable
class UpdateTransactionUseCase {
  final TransactionRepository repository;

  UpdateTransactionUseCase(this.repository);

  Future<Either<AppFailure, void>> call(Transaction transaction) {
    return repository.updateTransaction(transaction);
  }
}
