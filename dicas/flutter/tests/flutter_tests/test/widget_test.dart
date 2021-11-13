import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tests/app/models/api_responde.dart';
import 'package:flutter_tests/app/models/order_item_model.dart';
import 'package:flutter_tests/app/models/product_model.dart';
import 'package:flutter_tests/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_tests/app/modules/home/repository/home_repository.dart';
import 'package:flutter_tests/app/modules/home/views/home_view.dart';
import 'package:flutter_tests/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  group('Lista de Pedidos', () {
    late HomeView homeView;
    late HomeRepository homeRepository;
    late Widget app;

    setUp(() {
      Get.testMode = true;

      homeRepository = MockHomeRepository();
      Get.put(homeRepository);
      Get.put(HomeController());

      homeView = HomeView();
      app = GetMaterialApp(
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      );
    });

    testWidgets('HomeController is available to HomeView ', (WidgetTester tester) async {
      await tester.pumpWidget(app);
      expect(homeView.controller, isNotNull);
    });

    testWidgets('List of Items is empty', (WidgetTester tester) async {
      await tester.pumpWidget(app);

      final keyNoItemWidgetFinder = find.byKey(const Key(HomeView.keyNoItemWidget));
      final keyListOrderFinder = find.byKey(const Key(HomeView.keyListOrder));

      expect(homeView.controller.order.items.isEmpty, true);
      expect(keyNoItemWidgetFinder, findsOneWidget);
      expect(keyListOrderFinder, findsNothing);
    });

    testWidgets('List of Items is not empty', (WidgetTester tester) async {
      await tester.pumpWidget(app);

      final keyNoItemWidgetFinder = find.byKey(const Key(HomeView.keyNoItemWidget));
      final keyListOrderFinder = find.byKey(const Key(HomeView.keyListOrder));
      final keyButtonAddOrderItem = find.byKey(const Key(HomeView.keyButtonAddOrderItem));

      // No items in the list
      expect(homeView.controller.order.items.isEmpty, true);
      expect(keyNoItemWidgetFinder, findsOneWidget);
      expect(keyListOrderFinder, findsNothing);

      // Mock API call
      when(() => homeRepository.addItem()).thenAnswer(
        (realInvocation) async => ApiResponse<OrderItemModel>(
          statusCode: 200,
          data: OrderItemModel(
            product: ProductModel(id: 1, description: 'Product Test', price: 1),
          ),
        ),
      );

      // Add items in the list
      await tester.tap(keyButtonAddOrderItem);
      await tester.pump();

      expect(homeView.controller.order.items.isEmpty, false);
      expect(keyNoItemWidgetFinder, findsNothing);
      expect(keyListOrderFinder, findsOneWidget);
    });

    testWidgets('Test navigation on adding item in the list with error from API', (WidgetTester tester) async {
      await tester.pumpWidget(app);

      final keyNoItemWidgetFinder = find.byKey(const Key(HomeView.keyNoItemWidget));
      final keyListOrderFinder = find.byKey(const Key(HomeView.keyListOrder));
      final keyButtonAddOrderItem = find.byKey(const Key(HomeView.keyButtonAddOrderItem));

      // No items in the list
      expect(homeView.controller.order.items.isEmpty, true);
      expect(keyNoItemWidgetFinder, findsOneWidget);
      expect(keyListOrderFinder, findsNothing);

      // Mock API call
      when(() => homeRepository.addItem()).thenAnswer(
        (realInvocation) async => ApiResponse<OrderItemModel>(
          statusCode: 400,
          errorMessage: 'Something went wrong',
        ),
      );

      // Try to add items in the list
      await tester.tap(keyButtonAddOrderItem);
      await tester.pump();

      // Still no items in the list because there was an error from api
      expect(homeView.controller.order.items.isEmpty, true);
      expect(keyNoItemWidgetFinder, findsOneWidget);
      expect(keyListOrderFinder, findsNothing);

      // User must be on the Error Route
      expect(Get.currentRoute, AppPages.ERROR);
    });

    tearDown(() {
      Get.reset();
    });
  });
}
