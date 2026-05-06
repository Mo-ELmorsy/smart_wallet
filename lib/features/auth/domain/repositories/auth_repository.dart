import 'package:dartz/dartz.dart';
import 'package:smart_wallet/shared/failures/app_failure.dart';

abstract class AuthRepository {
  Future<Either<AppFailure, void>> completeOnboarding();
  Future<Either<AppFailure, bool>> hasCompletedOnboarding();
  
  Future<Either<AppFailure, void>> setupPin(String pin);
  Future<Either<AppFailure, bool>> validatePin(String pin);
  Future<Either<AppFailure, void>> disablePin();
  Future<Either<AppFailure, bool>> isPinEnabled();

  Future<Either<AppFailure, void>> enableBiometrics();
  Future<Either<AppFailure, void>> disableBiometrics();
  Future<Either<AppFailure, bool>> isBiometricEnabled();
  Future<Either<AppFailure, bool>> canUseBiometrics();
  Future<Either<AppFailure, bool>> authenticateWithBiometrics();
}
