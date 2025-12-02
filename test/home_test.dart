import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  group('Home Page Tests', () {
    testWidgets('should display home page with basic elements', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(const UnionShopApp());
        await tester.pump();

        // Wait for any async operations to settle
        await tester.pumpAndSettle();

        // Check that basic UI elements are present
        expect(
          find.text('FREE DELIVERY ON ORDERS OVER £50'),
          findsOneWidget,
        );
        expect(find.text('Placeholder Hero Title'), findsOneWidget);
        expect(find.text('BROWSE PRODUCTS'), findsOneWidget);
        expect(find.text('PRODUCTS SECTION'), findsOneWidget);
      });
    });

    testWidgets('should display product cards', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(const UnionShopApp());
        await tester.pump();

        // Wait for any async operations to settle
        await tester.pumpAndSettle();

        // Check that actual product cards are displayed
        expect(find.text('Classic Portsmouth Hoodie'), findsOneWidget);
        expect(find.text('Modern Portsmouth Polo'), findsOneWidget);

        // Check prices are displayed (using actual product prices)
        expect(find.text('£35.00'), findsOneWidget);
        expect(find.text('£32.00'), findsOneWidget);
      });
    });

    testWidgets('should display header icons', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(const UnionShopApp());
        await tester.pump();

        // Wait for any async operations to settle
        await tester.pumpAndSettle();

        // Check that header icons are present
        expect(find.byIcon(Icons.search), findsOneWidget);
        expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
        expect(find.byIcon(Icons.menu), findsOneWidget);
      });
    });

    testWidgets('should display footer', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(const UnionShopApp());
        await tester.pump();

        // Wait for any async operations to settle
        await tester.pumpAndSettle();

        // Check that footer is present
        expect(find.text('© 2025 University of Portsmouth Students\' Union'),
            findsOneWidget);
      });
    });
  });
}
