import 'dart:math';

import 'package:dio/dio.dart' as dio;
import 'package:flutter_tests/app/models/api_responde.dart';
import 'package:flutter_tests/app/models/order_item_model.dart';
import 'package:flutter_tests/app/models/product_model.dart';
import 'package:get/get.dart';

class HomeRepository {
  Future<ApiResponse<OrderItemModel>> addItem([dio.Dio? httpClient]) async {
    try {
      httpClient = httpClient ?? Get.find<dio.Dio>();
      final dio.Response response = await httpClient.get('todos/1');
    
      final random = Random().nextInt(100);

      return ApiResponse<OrderItemModel>(
          statusCode: 200, // response.statusCode,
          data: OrderItemModel(
              product: ProductModel(
            id: random,
            description: 'Product $random',
            price: random.toDouble(),
          )));
     } on dio.DioError catch (e) {
       return ApiResponse(
         statusCode: e.response?.statusCode ?? 400,
         errorMessage: e.response?.data?.toString() ?? 'Ops, algo deu errado',
       );
     }
  }
}
