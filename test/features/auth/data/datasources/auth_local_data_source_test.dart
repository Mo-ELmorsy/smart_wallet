import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_wallet/features/auth/data/datasources/auth_local_data_source.dart';

void main() {
  late AuthLocalDataSourceImpl dataSource;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    dataSource = AuthLocalDataSourceImpl(prefs);
  });

  test('should default to false for onboarding status', () {
    final result = dataSource.getHasCompletedOnboarding();
    expect(result, false);
  });

  test('should save and read onboarding status', () async {
    await dataSource.setHasCompletedOnboarding(true);
    final result = dataSource.getHasCompletedOnboarding();
    expect(result, true);
  });

  test('should default to false for pin enabled', () {
    final result = dataSource.getIsPinEnabled();
    expect(result, false);
  });

  test('should save pin hash and validate correctly', () async {
    const pin = '1234';
    await dataSource.savePinHash(pin);

    final isValid = dataSource.validatePin(pin);
    final isInvalid = dataSource.validatePin('4321');

    expect(isValid, true);
    expect(isInvalid, false);
  });

  test('should clear pin properly', () async {
    const pin = '1234';
    await dataSource.savePinHash(pin);
    await dataSource.setIsPinEnabled(true);

    await dataSource.clearPin();

    expect(dataSource.getIsPinEnabled(), false);
    expect(dataSource.validatePin(pin), false);
  });
}
