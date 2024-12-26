import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'main.dart';

void main() {
  testWidgets('Home screen displays converters', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Verify if the HomeScreen is displayed
    expect(find.text('Unit Converter'), findsOneWidget);

    // Verify if all converter titles are present
    expect(find.text('Volume Converter'), findsOneWidget);
    expect(find.text('Length Converter'), findsOneWidget);
    expect(find.text('Area Converter'), findsOneWidget);
    expect(find.text('Mass Converter'), findsOneWidget);
    expect(find.text('Speed Converter'), findsOneWidget);
    expect(find.text('Temperature Converter'), findsOneWidget);
    expect(find.text('Time Converter'), findsOneWidget);
  });

  testWidgets('Navigates to Volume Converter', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Tap on the Volume Converter tile
    await tester.tap(find.text('Volume Converter'));
    await tester.pumpAndSettle();

    // Verify if the Volume Converter screen is displayed
    expect(find.text('Volume Converter'), findsOneWidget);
  });

  testWidgets('Navigates to Length Converter', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Tap on the Length Converter tile
    await tester.tap(find.text('Length Converter'));
    await tester.pumpAndSettle();

    // Verify if the Length Converter screen is displayed
    expect(find.text('Length Converter'), findsOneWidget);
  });

  // You can add similar tests for other converters as needed
}