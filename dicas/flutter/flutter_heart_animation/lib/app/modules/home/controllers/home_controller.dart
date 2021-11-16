import 'package:flutter_heart_animation/app/models/photo_model.dart';
import 'package:flutter_heart_animation/app/modules/home/repository/home_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  final listPhotos = <PhotoModel>[].obs;

  late HomeRepository _repository;

  @override
  void onInit() {
    super.onInit();

    // We don't handle DI here just for simplicity
    _repository = HomeRepository();
  }

  @override
  void onReady() async {
    super.onReady();

    listPhotos.clear();
    listPhotos.addAll(await _repository.getPhotos());
  }
}
