import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:product_arena/main.dart';
import 'package:flutter/material.dart';

Future<void> addDelay(int ms) async {
  await Future<void>.delayed(Duration(milliseconds: ms));
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  if (binding is LiveTestWidgetsFlutterBinding) {
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
  }

  group('end-to-end test', () {
    final timeBasedEmail = DateTime.now().microsecondsSinceEpoch.toString() + '@test.com';

    testWidgets('Authentication Testing', (tester) async {
      await Firebase.initializeApp();
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(TextButton));

      tester.printToConsole('SignUp screen opens');

      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const ValueKey('emailSignUpField')), timeBasedEmail);

      await tester.enterText(
          find.byKey(const ValueKey('passwordSignUpField')), 'test123');

      await tester.tap(find.byType(ElevatedButton));

      await addDelay(24000);

      await tester.pumpAndSettle();

      expect(find.text('Product Arena'), findsOneWidget);
    });

  });
}

Future<void> logout(WidgetTester tester) async {

  await addDelay(8000);

  await tester.tap(find.byKey(
    const ValueKey('LogoutKey'),
  ));

  await addDelay(8000);
  tester.printToConsole('Login screen opens');
  await tester.pumpAndSettle();

  await logout(tester);
}