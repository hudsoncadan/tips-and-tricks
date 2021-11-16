import 'package:flutter_tests/app/models/product_model.dart';

class OrderItemModel {
  ProductModel product;
  late int quantity;

  double get subtotal => product.price * quantity;

  OrderItemModel({required this.product, this.quantity = 1});
}
