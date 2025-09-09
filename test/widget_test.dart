import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xyz_hotel_booking/main.dart';

void main() {
  testWidgets('App should start and show splash screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const XYZHotelBookingApp());

    // Verify that the splash screen is displayed
    expect(find.text('XYZ Hotel Booking'), findsOneWidget);
    expect(find.text('Your perfect stay awaits'), findsOneWidget);
    expect(find.byIcon(Icons.hotel), findsOneWidget);
  });

  testWidgets('Theme should be applied correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const XYZHotelBookingApp());
    
    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.title, 'XYZ Hotel Booking');
    expect(materialApp.debugShowCheckedModeBanner, false);
  });
}