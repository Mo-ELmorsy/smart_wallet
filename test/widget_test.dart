import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_wallet/main.dart';
import 'package:smart_wallet/features/auth/presentation/providers/auth_provider.dart';

// Dummy controller to avoid GetIt dependency in tests
class DummyAuthController extends AuthController {
  @override
  AuthState build() {
    return const AuthState(isLoading: true);
  }
}

void main() {
  testWidgets('App compiles and shows SmartWallet text', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authControllerProvider.overrideWith(() => DummyAuthController()),
        ],
        child: const SmartWalletApp(),
      ),
    );
    await tester.pump(); // Pump initial frame
    expect(find.text('SmartWallet'), findsOneWidget);
  });
}
