import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insurance_mobile/app/app.dart';

void main() {
  testWidgets('app bootstrap renders MaterialApp', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: InsuranceApp()));

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
