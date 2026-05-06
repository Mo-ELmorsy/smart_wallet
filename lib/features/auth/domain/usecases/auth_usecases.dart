import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_wallet/features/auth/domain/repositories/auth_repository.dart';
import 'package:smart_wallet/shared/failures/app_failure.dart';

@lazySingleton
class CompleteOnboardingUseCase {
  final AuthRepository repository;
  CompleteOnboardingUseCase(this.repository);

  Future<Either<AppFailure, void>> call() => repository.completeOnboarding();
}

@lazySingleton
class CheckOnboardingStatusUseCase {
  final AuthRepository repository;
  CheckOnboardingStatusUseCase(this.repository);

  Future<Either<AppFailure, bool>> call() => repository.hasCompletedOnboarding();
}

@lazySingleton
class SetupPinUseCase {
  final AuthRepository repository;
  SetupPinUseCase(this.repository);

  Future<Either<AppFailure, void>> call(String pin) => repository.setupPin(pin);
}

@lazySingleton
class ValidatePinUseCase {
  final AuthRepository repository;
  ValidatePinUseCase(this.repository);

  Future<Either<AppFailure, bool>> call(String pin) => repository.validatePin(pin);
}

@lazySingleton
class CheckPinEnabledUseCase {
  final AuthRepository repository;
  CheckPinEnabledUseCase(this.repository);

  Future<Either<AppFailure, bool>> call() => repository.isPinEnabled();
}

@lazySingleton
class EnableBiometricsUseCase {
  final AuthRepository repository;
  EnableBiometricsUseCase(this.repository);

  Future<Either<AppFailure, void>> call() => repository.enableBiometrics();
}

@lazySingleton
class DisableBiometricsUseCase {
  final AuthRepository repository;
  DisableBiometricsUseCase(this.repository);

  Future<Either<AppFailure, void>> call() => repository.disableBiometrics();
}

@lazySingleton
class CheckBiometricAvailabilityUseCase {
  final AuthRepository repository;
  CheckBiometricAvailabilityUseCase(this.repository);

  Future<Either<AppFailure, bool>> call() => repository.canUseBiometrics();
}

@lazySingleton
class CheckBiometricEnabledUseCase {
  final AuthRepository repository;
  CheckBiometricEnabledUseCase(this.repository);

  Future<Either<AppFailure, bool>> call() => repository.isBiometricEnabled();
}

@lazySingleton
class AuthenticateWithBiometricsUseCase {
  final AuthRepository repository;
  AuthenticateWithBiometricsUseCase(this.repository);

  Future<Either<AppFailure, bool>> call() => repository.authenticateWithBiometrics();
}
