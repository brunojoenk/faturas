// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:faturas/payment-options/view/payment_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('tap on option 4 to test invoice value',
      (WidgetTester tester) async {
    Widget testWidget = const MaterialApp(home: PayWithCreditCard());

    await tester.pumpWidget(testWidget);

    await tester.pumpAndSettle();

    expect(find.textContaining('Escolha o numero de parcelas'), findsOneWidget);

    // Finds the floating action button to tap on.
    final Finder fab1 = find.textContaining('4x');

    // Emulate a tap on the floating action button.
    await tester.tap(fab1);

    // Trigger a frame.
    await tester.pumpAndSettle();

    // Verify the counter increments by 1.
    expect(find.textContaining('3.105,49'), findsOneWidget);
  });
}
