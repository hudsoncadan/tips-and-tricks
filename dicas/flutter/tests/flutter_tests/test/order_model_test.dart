import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tests/app/models/order_item_model.dart';
import 'package:flutter_tests/app/models/order_model.dart';
import 'package:flutter_tests/app/models/product_model.dart';

void main() {
  group("Total Order", () {
    test(r"An order with 4 products, being 1 x R$ 3,50,  1 x R$ 8,25 and 2 x R$ 18,98  must totalize R$ 49,71", () {
      ProductModel productModel1 = ProductModel(id: 1, description: "Product 1", price: 3.5);
      ProductModel productModel2 = ProductModel(id: 2, description: "Product 2", price: 8.25);
      ProductModel productModel3 = ProductModel(id: 3, description: "Product 3", price: 18.98);

      List<OrderItemModel> items = <OrderItemModel>[
        OrderItemModel(product: productModel1),
        OrderItemModel(product: productModel2),
        OrderItemModel(product: productModel3)..quantity = 2,
      ];

      OrderModel order = OrderModel(items: items);

      expect(order.total, 49.71);
    });

    test(r"An order with 1 product of R$ 9,99 is updated to 5 products and the order must totalize R$ 49,95 ", () {
      ProductModel product1 = ProductModel(id: 1, description: "Product 1", price: 9.99);

      OrderItemModel orderItem = OrderItemModel(product: product1);
      List<OrderItemModel> items = <OrderItemModel>[orderItem];

      // First total
      OrderModel order = OrderModel(items: items);
      expect(order.total, 9.99);

      // Update the quantity of an item in the order's items list
      order.updateQuantityOrderItem(idProduct: 1, newQuantity: 5);
      expect(order.total, 49.95);
    });

    test(r"An item is updated to 5 products and the order must totalize R$ 49,95 ", () {
      ProductModel product1 = ProductModel(id: 1, description: "Product 1", price: 9.99);

      OrderItemModel orderItem = OrderItemModel(product: product1);
      List<OrderItemModel> items = <OrderItemModel>[orderItem];

      // First total
      OrderModel order = OrderModel(items: items);
      expect(order.total, 9.99);

      // Update directly the quantity of the item
      orderItem.quantity = 5;
      expect(order.total, 49.95);
    });

    test(r'Expect a quantity of 5 OrderItem', () {
      OrderModel order = OrderModel(items: <OrderItemModel>[
        OrderItemModel(product: ProductModel(id: 1, description: 'Product 1', price: 1)),
        OrderItemModel(product: ProductModel(id: 2, description: 'Product 2', price: 2))..quantity = 4,
      ]);

      expect(order.getQuantityOfItems(), 5);
    });

    test(r"Expect an Exception when product is not found by calling order.updateQuantityOrderItem()", () {
      ProductModel product1 = ProductModel(id: 1, description: "Product 1", price: 9.99);

      List<OrderItemModel> items = <OrderItemModel>[
        OrderItemModel(product: product1),
      ];

      OrderModel order = OrderModel(items: items);

      expect(() => order.updateQuantityOrderItem(idProduct: 2, newQuantity: 2), throwsA(isA<StateError>()));
    });
  });
}
