import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_wallet/shared/failures/app_failure.dart';
import 'package:smart_wallet/features/insights/domain/repositories/insights_repository.dart';

@injectable
class GenerateMonthlyInsightUseCase {
  final InsightsRepository repository;

  GenerateMonthlyInsightUseCase(this.repository);

  Future<Either<AppFailure, String>> call(String prompt) {
    return repository.generateMonthlyInsight(prompt);
  }
}
