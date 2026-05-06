import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_wallet/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:smart_wallet/features/auth/data/datasources/biometric_data_source.dart';
import 'package:smart_wallet/features/auth/domain/repositories/auth_repository.dart';
import 'package:smart_wallet/shared/failures/app_failure.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;
  final BiometricDataSource biometricDataSource;

  AuthRepositoryImpl(this.localDataSource, this.biometricDataSource);

  @override
  Future<Either<AppFailure, void>> completeOnboarding() async {
    try {
      await localDataSource.setHasCompletedOnboarding(true);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to save onboarding status: $e'));
    }
  }

  @override
  Future<Either<AppFailure, bool>> hasCompletedOnboarding() async {
    try {
      final result = localDataSource.getHasCompletedOnboarding();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure('Failed to get onboarding status: $e'));
    }
  }

  @override
  Future<Either<AppFailure, void>> setupPin(String pin) async {
    try {
      if (pin.length != 4) {
        return const Left(ValidationFailure('PIN must be 4 digits'));
      }
      await localDataSource.savePinHash(pin);
      await localDataSource.setIsPinEnabled(true);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to save PIN: $e'));
    }
  }

  @override
  Future<Either<AppFailure, bool>> validatePin(String pin) async {
    try {
      final isValid = localDataSource.validatePin(pin);
      return Right(isValid);
    } catch (e) {
      return Left(CacheFailure('Failed to validate PIN: $e'));
    }
  }

  @override
  Future<Either<AppFailure, void>> disablePin() async {
    try {
      await localDataSource.clearPin();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to disable PIN: $e'));
    }
  }

  @override
  Future<Either<AppFailure, bool>> isPinEnabled() async {
    try {
      final result = localDataSource.getIsPinEnabled();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure('Failed to get PIN status: $e'));
    }
  }

  @override
  Future<Either<AppFailure, void>> enableBiometrics() async {
    try {
      await localDataSource.setIsBiometricEnabled(true);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to enable biometrics: $e'));
    }
  }

  @override
  Future<Either<AppFailure, void>> disableBiometrics() async {
    try {
      await localDataSource.setIsBiometricEnabled(false);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to disable biometrics: $e'));
    }
  }

  @override
  Future<Either<AppFailure, bool>> isBiometricEnabled() async {
    try {
      final result = localDataSource.getIsBiometricEnabled();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure('Failed to get biometric status: $e'));
    }
  }

  @override
  Future<Either<AppFailure, bool>> canUseBiometrics() async {
    try {
      final result = await biometricDataSource.isBiometricAvailable;
      return Right(result);
    } catch (e) {
      return Left(UnknownFailure('Failed to check biometric availability: $e'));
    }
  }

  @override
  Future<Either<AppFailure, bool>> authenticateWithBiometrics() async {
    try {
      final result = await biometricDataSource.authenticate();
      return Right(result);
    } catch (e) {
      return Left(UnknownFailure('Biometric authentication failed: $e'));
    }
  }
}
