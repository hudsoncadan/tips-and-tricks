import 'package:flutter/material.dart';
import 'package:flutter_tests/app/models/order_item_model.dart';
import 'package:flutter_tests/app/utils/formatters.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItemModel model;

  const OrderItemWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.shopping_cart_outlined),
        title: Text(model.product.description),
        subtitle: Text(
          model.product.price.toString().formatCurrency(),
          style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
