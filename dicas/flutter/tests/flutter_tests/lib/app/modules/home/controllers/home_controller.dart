import 'dart:math';

import 'package:dio/dio.dart' as dio;
import 'package:flutter_tests/app/models/api_responde.dart';
import 'package:flutter_tests/app/models/order_item_model.dart';
import 'package:flutter_tests/app/models/order_model.dart';
import 'package:flutter_tests/app/models/product_model.dart';
import 'package:flutter_tests/app/modules/home/repository/home_repository.dart';
import 'package:flutter_tests/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _order = OrderModel(items: <OrderItemModel>[]).obs;
  OrderModel get order => _order.value;
  set order(OrderModel value) => _order.value = value;

  late HomeRepository _homeRepository;

  @override
  void onInit() {
    super.onInit();
    _homeRepository = Get.find<HomeRepository>();
  }

  addOrderItem() async {
    // Simula uma chamada na API
    ApiResponse<OrderItemModel> response = await _homeRepository.addItem();

    if (response.statusCode == 200) {
      _order.update((val) {
        val?.addOrderItem(response.data!);
      });
    } else {
      // Caso dê erro no retorno da API, redirecionar o usuário para a página de erros
      Get.toNamed(AppPages.ERROR);
    }
  }

  removeOrderItem(int indexInList) {
    _order.update((val) {
      val?.items.removeAt(indexInList);
    });
  }
}
