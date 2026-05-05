import 'package:flutter_test/flutter_test.dart';
import 'package:smart_wallet/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('App compiles and shows Splash Route', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: SmartWalletApp()));
    await tester.pumpAndSettle();
    expect(find.text('Splash Route'), findsOneWidget);
  });
}
