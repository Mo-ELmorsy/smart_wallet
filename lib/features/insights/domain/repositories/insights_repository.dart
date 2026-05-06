import 'package:dartz/dartz.dart';
import 'package:smart_wallet/shared/failures/app_failure.dart';

abstract class InsightsRepository {
  Future<Either<AppFailure, String>> generateMonthlyInsight(String prompt);
}
