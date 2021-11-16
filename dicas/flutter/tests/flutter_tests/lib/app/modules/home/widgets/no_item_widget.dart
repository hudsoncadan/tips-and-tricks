import 'package:flutter/material.dart';
import 'package:flutter_tests/app/modules/home/widgets/add_order_item_widget.dart';

class NoItemWidget extends StatelessWidget {
  static const keyNoItemWidget = "NoItemWidget";

  final VoidCallback callbackAddOrderItem;

  const NoItemWidget({Key? key, required this.callbackAddOrderItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key(keyNoItemWidget),
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.info_outline, color: Theme.of(context).textTheme.caption?.color),
        const Text('Nenhum item encontrado'),
        const SizedBox(height: 16.0),
        AddOrderItemWidet(callbackAddOrderItem: callbackAddOrderItem),
      ],
    );
  }
}
