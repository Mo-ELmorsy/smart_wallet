import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_wallet/shared/failures/app_failure.dart';
import 'package:smart_wallet/features/insights/data/datasources/gemini_data_source.dart';
import 'package:smart_wallet/features/insights/domain/repositories/insights_repository.dart';

@LazySingleton(as: InsightsRepository)
class InsightsRepositoryImpl implements InsightsRepository {
  final GeminiDataSource dataSource;

  InsightsRepositoryImpl(this.dataSource);

  @override
  Future<Either<AppFailure, String>> generateMonthlyInsight(String prompt) async {
    try {
      final result = await dataSource.generateInsight(prompt);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
