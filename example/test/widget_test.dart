// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth_crypto_example/main.dart';

void main() {
  testWidgets('renders biometric crypto example', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('LOCAL AUTH PLUS'), findsOneWidget);
    expect(find.text('TOKEN'), findsOneWidget);
    expect(find.text('CIPHER TEXT'), findsOneWidget);
    expect(find.text('Decrypt by Biometric'), findsOneWidget);
  });
}
