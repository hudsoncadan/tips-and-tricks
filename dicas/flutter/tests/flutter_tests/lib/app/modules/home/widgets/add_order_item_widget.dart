import 'package:flutter/material.dart';

class AddOrderItemWidet extends StatelessWidget {
  final VoidCallback callbackAddOrderItem;

  const AddOrderItemWidet({Key? key, required this.callbackAddOrderItem }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: callbackAddOrderItem,
      icon: const Icon(Icons.add),
      label: const Text('Adicionar item'),
    );
  }
}
