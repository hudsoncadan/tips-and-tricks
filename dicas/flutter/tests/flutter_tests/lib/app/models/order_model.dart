import 'package:flutter_tests/app/models/order_item_model.dart';

class OrderModel {
  List<OrderItemModel> items;

  double get total => items.fold(0, (previousValue, orderItemModel) => (orderItemModel.subtotal) + previousValue);

  OrderModel({
    required this.items,
  });

  addOrderItem(OrderItemModel model) {
    items.add(model);
  }

  removeOrderItem(int idProduct) {
    items.removeWhere((orderItemModel) => orderItemModel.product.id == idProduct);
  }

  updateQuantityOrderItem({required int idProduct, required int newQuantity}) {
    items.firstWhere((element) => element.product.id == idProduct).quantity = newQuantity;
  }

  int getQuantityOfItems() {
    return items.fold(0, (previousValue, element) => element.quantity + previousValue);
  }
}
