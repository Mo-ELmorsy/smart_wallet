import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_wallet/shared/failures/app_failure.dart';
import '../repositories/transaction_repository.dart';

@injectable
class DeleteTransactionUseCase {
  final TransactionRepository repository;

  DeleteTransactionUseCase(this.repository);

  Future<Either<AppFailure, void>> call(String id) {
    return repository.deleteTransaction(id);
  }
}
