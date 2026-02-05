// This is a basic Flutter widget test for the M¹ App.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:m1/main.dart';

void main() {
  testWidgets('M1 App launches and displays home screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the home screen appears
    expect(find.text("M¹"), findsWidgets);
    expect(find.text("Welcome to M¹ App"), findsOneWidget);
    expect(find.byIcon(Icons.brightness_6), findsOneWidget);
  });

  testWidgets('Navigation to profile screen works', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    
    // Tap on the profile button (leading image)
    await tester.tap(find.byType(Image).first);
    await tester.pumpAndSettle();

    // Verify profile screen appears
    expect(find.text("Profile"), findsOneWidget);
  });
}
