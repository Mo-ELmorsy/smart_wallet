import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_wallet/core/di/injection.dart';
import 'package:smart_wallet/features/auth/domain/usecases/auth_usecases.dart';

part 'auth_provider.freezed.dart';
part 'auth_provider.g.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(true) bool isLoading,
    @Default(false) bool hasCompletedOnboarding,
    @Default(false) bool isPinEnabled,
    @Default(false) bool isBiometricEnabled,
    @Default(false) bool canUseBiometrics,
    @Default(false) bool isAuthenticated,
    String? errorMessage,
  }) = _AuthState;
}

@riverpod
class AuthController extends _$AuthController {
  @override
  AuthState build() {
    Future.microtask(_loadInitialState);
    return const AuthState(
      isLoading: true,
      hasCompletedOnboarding: false,
      isPinEnabled: false,
      isBiometricEnabled: false,
      canUseBiometrics: false,
      isAuthenticated: false,
    );
  }

  Future<void> _loadInitialState() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final checkOnboarding = getIt<CheckOnboardingStatusUseCase>();
    final checkPin = getIt<CheckPinEnabledUseCase>();
    final checkBiometricEnabled = getIt<CheckBiometricEnabledUseCase>();
    final checkBiometricAvail = getIt<CheckBiometricAvailabilityUseCase>();

    final onboardingRes = await checkOnboarding();
    final pinRes = await checkPin();
    final bioEnabledRes = await checkBiometricEnabled();
    final bioAvailRes = await checkBiometricAvail();

    bool hasCompletedOnboarding = false;
    bool isPinEnabled = false;
    bool isBiometricEnabled = false;
    bool canUseBiometrics = false;

    onboardingRes.fold((l) => null, (r) => hasCompletedOnboarding = r);
    pinRes.fold((l) => null, (r) => isPinEnabled = r);
    bioEnabledRes.fold((l) => null, (r) => isBiometricEnabled = r);
    bioAvailRes.fold((l) => null, (r) => canUseBiometrics = r);

    state = state.copyWith(
      isLoading: false,
      hasCompletedOnboarding: hasCompletedOnboarding,
      isPinEnabled: isPinEnabled,
      isBiometricEnabled: isBiometricEnabled,
      canUseBiometrics: canUseBiometrics,
    );
  }

  Future<void> completeOnboarding() async {
    final complete = getIt<CompleteOnboardingUseCase>();
    final res = await complete();
    
    res.fold(
      (l) => state = state.copyWith(errorMessage: l.message),
      (r) => state = state.copyWith(hasCompletedOnboarding: true, errorMessage: null),
    );
  }

  Future<bool> setupPin(String pin) async {
    final setup = getIt<SetupPinUseCase>();
    final res = await setup(pin);
    
    return res.fold(
      (l) {
        state = state.copyWith(errorMessage: l.message);
        return false;
      },
      (r) {
        state = state.copyWith(isPinEnabled: true, errorMessage: null, isAuthenticated: true);
        return true;
      },
    );
  }

  Future<bool> unlockWithPin(String pin) async {
    final validate = getIt<ValidatePinUseCase>();
    final res = await validate(pin);
    
    return res.fold(
      (l) {
        state = state.copyWith(errorMessage: l.message);
        return false;
      },
      (r) {
        if (r) {
          state = state.copyWith(isAuthenticated: true, errorMessage: null);
          return true;
        } else {
          state = state.copyWith(errorMessage: 'Invalid PIN');
          return false;
        }
      },
    );
  }

  Future<bool> unlockWithBiometrics() async {
    final auth = getIt<AuthenticateWithBiometricsUseCase>();
    final res = await auth();
    
    return res.fold(
      (l) {
        state = state.copyWith(errorMessage: l.message);
        return false;
      },
      (r) {
        if (r) {
          state = state.copyWith(isAuthenticated: true, errorMessage: null);
          return true;
        } else {
          state = state.copyWith(errorMessage: 'Biometric authentication failed');
          return false;
        }
      },
    );
  }

  Future<void> enableBiometrics() async {
    final enable = getIt<EnableBiometricsUseCase>();
    final res = await enable();
    
    res.fold(
      (l) => state = state.copyWith(errorMessage: l.message),
      (r) => state = state.copyWith(isBiometricEnabled: true, errorMessage: null),
    );
  }

  Future<void> disableBiometrics() async {
    final disable = getIt<DisableBiometricsUseCase>();
    final res = await disable();
    
    res.fold(
      (l) => state = state.copyWith(errorMessage: l.message),
      (r) => state = state.copyWith(isBiometricEnabled: false, errorMessage: null),
    );
  }
}
