import 'package:flutter/material.dart';
import 'package:flutter_tests/app/modules/home/widgets/add_order_item_widget.dart';
import 'package:flutter_tests/app/modules/home/widgets/card_info_widget.dart';
import 'package:flutter_tests/app/modules/home/widgets/no_item_widget.dart';
import 'package:flutter_tests/app/modules/home/widgets/order_item_widget.dart';
import 'package:flutter_tests/app/utils/formatters.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  static const keyNoItemWidget = "keyNoItemWidget";
  static const keyListOrder = "ListOrder";
  static const keyInfoTotal = "InfoTotal";
  static const keyInfoQuantity = "InfoQuantity";
  static const keyButtonAddOrderItem = "keyButtonAddOrderItem";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                ListTile(
                  title: Text('Lista de Pedidos', style: Theme.of(context).textTheme.headline4),
                  subtitle: const Text('Consulte todos os itens incluídos no seu pedido'),
                ),
                Expanded(
                  flex: 1,
                  child: controller.order.items.isEmpty
                      ? Center(
                          child: NoItemWidget(
                          key: const Key(keyNoItemWidget),
                          callbackAddOrderItem: controller.addOrderItem,
                        ))
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CardInfoWidget(
                                  key: const Key(keyInfoQuantity),
                                  icons: Icons.format_list_numbered,
                                  title: 'Quantidade de Itens',
                                  value: controller.order.getQuantityOfItems().toString(),
                                ),
                                CardInfoWidget(
                                  key: const Key(keyInfoTotal),
                                  icons: Icons.monetization_on_outlined,
                                  title: 'Total',
                                  value: controller.order.total.toString().formatCurrency(),
                                ),
                              ],
                            ),
                            Expanded(
                              flex: 1,
                              child: ListView.builder(
                                key: const Key(keyListOrder),
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.order.items.length,
                                itemBuilder: (_, index) => Dismissible(
                                  key: UniqueKey(),
                                  onDismissed: (direction) {
                                    controller.removeOrderItem(index);
                                  },
                                  child: OrderItemWidget(model: controller.order.items.elementAt(index)),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: AddOrderItemWidet(
                    key: const Key(keyButtonAddOrderItem),
                    callbackAddOrderItem: controller.addOrderItem,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
