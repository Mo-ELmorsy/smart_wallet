import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

abstract class BiometricDataSource {
  Future<bool> get isBiometricSupported;
  Future<bool> get isBiometricAvailable;
  Future<bool> authenticate();
}

@LazySingleton(as: BiometricDataSource)
class BiometricDataSourceImpl implements BiometricDataSource {
  final LocalAuthentication auth;

  BiometricDataSourceImpl() : auth = LocalAuthentication();

  @override
  Future<bool> get isBiometricSupported async {
    if (kIsWeb) return false;
    try {
      return await auth.isDeviceSupported();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> get isBiometricAvailable async {
    if (kIsWeb) return false;
    try {
      final supported = await isBiometricSupported;
      if (!supported) return false;
      final canCheck = await auth.canCheckBiometrics;
      return canCheck;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> authenticate() async {
    if (kIsWeb) return false;
    try {
      final available = await isBiometricAvailable;
      if (!available) return false;

      return await auth.authenticate(
        localizedReason: 'Please authenticate to unlock SmartWallet',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );
    } catch (e) {
      return false;
    }
  }
}
