import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  bool getHasCompletedOnboarding();
  Future<void> setHasCompletedOnboarding(bool value);
  bool getIsPinEnabled();
  Future<void> setIsPinEnabled(bool value);
  Future<void> savePinHash(String pin);
  bool validatePin(String pin);
  Future<void> clearPin();
  bool getIsBiometricEnabled();
  Future<void> setIsBiometricEnabled(bool value);
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences _prefs;

  static const String _keyOnboarding = 'has_completed_onboarding';
  static const String _keyPinEnabled = 'is_pin_enabled';
  static const String _keyPinHash = 'pin_hash';
  static const String _keyBiometricEnabled = 'is_biometric_enabled';

  AuthLocalDataSourceImpl(this._prefs);

  @override
  bool getHasCompletedOnboarding() {
    return _prefs.getBool(_keyOnboarding) ?? false;
  }

  @override
  Future<void> setHasCompletedOnboarding(bool value) async {
    await _prefs.setBool(_keyOnboarding, value);
  }

  @override
  bool getIsPinEnabled() {
    return _prefs.getBool(_keyPinEnabled) ?? false;
  }

  @override
  Future<void> setIsPinEnabled(bool value) async {
    await _prefs.setBool(_keyPinEnabled, value);
  }

  String _hashPin(String pin) {
    // Simple hash for demo purposes.
    // TODO: use flutter_secure_storage for real app
    final bytes = utf8.encode(pin);
    return sha256.convert(bytes).toString();
  }

  @override
  Future<void> savePinHash(String pin) async {
    final hash = _hashPin(pin);
    await _prefs.setString(_keyPinHash, hash);
  }

  @override
  bool validatePin(String pin) {
    final hash = _hashPin(pin);
    final savedHash = _prefs.getString(_keyPinHash);
    return hash == savedHash;
  }

  @override
  Future<void> clearPin() async {
    await _prefs.remove(_keyPinHash);
    await _prefs.setBool(_keyPinEnabled, false);
  }

  @override
  bool getIsBiometricEnabled() {
    return _prefs.getBool(_keyBiometricEnabled) ?? false;
  }

  @override
  Future<void> setIsBiometricEnabled(bool value) async {
    await _prefs.setBool(_keyBiometricEnabled, value);
  }
}
