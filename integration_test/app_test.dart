import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:faturas/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the option 4 to update invoice value',
            (WidgetTester tester) async {
          app.main();
          await tester.pumpAndSettle();

          expect(find.text('Sistema de Faturas'), findsOneWidget);

          // Finds the floating action button to tap on.
          final Finder fab = find.bySemanticsLabel('Pagar com cartão de crédito');

          // Emulate a tap on the floating action button.
          await tester.tap(fab);

          // Trigger a frame.
          await tester.pumpAndSettle();

          // Verify the counter increments by 1.
          expect(find.text('Escolha o numero de parcelas'), findsOneWidget);

          // Finds the floating action button to tap on.
          final Finder fab1 = find.textContaining('4x');

          // Emulate a tap on the floating action button.
          await tester.tap(fab1);

          // Trigger a frame.
          await tester.pumpAndSettle();

          // Verify the counter increments by 1.
          expect(find.textContaining('3.105,49'), findsOneWidget);
        });
  });
}