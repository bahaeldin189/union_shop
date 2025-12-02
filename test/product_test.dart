import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/services/cart_provider.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  group('Product Page Tests', () {
    Widget createTestWidget() {
      return ChangeNotifierProvider(
        create: (context) => CartProvider(),
        child: const MaterialApp(home: ProductPage()),
      );
    }

    testWidgets('should display product page with basic elements', (
      tester,
    ) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createTestWidget());
        await tester.pump();

        // Wait for any async operations to settle
        await tester.pumpAndSettle();

        // Check that basic UI elements are present
        expect(
          find.text('FREE DELIVERY ON ORDERS OVER £50'),
          findsOneWidget,
        );
        expect(find.text('£35.00'), findsOneWidget);
      });
    });

    testWidgets('should display student instruction text', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createTestWidget());
        await tester.pump();

        // Wait for any async operations to settle
        await tester.pumpAndSettle();

        // Check that product description is present
        expect(
          find.text(
            'Official University of Portsmouth hoodie made from premium cotton blend. Features embroidered university logo and comfortable kangaroo pocket. Perfect for campus life or casual wear.',
          ),
          findsOneWidget,
        );
      });
    });

    testWidgets('should display header icons', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(createTestWidget());
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
        await tester.pumpWidget(createTestWidget());
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
