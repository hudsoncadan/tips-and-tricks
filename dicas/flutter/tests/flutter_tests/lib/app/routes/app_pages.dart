import 'package:get/get.dart';

import 'package:flutter_tests/app/modules/error/bindings/error_binding.dart';
import 'package:flutter_tests/app/modules/error/views/error_view.dart';
import 'package:flutter_tests/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_tests/app/modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  static const ERROR = Routes.ERROR;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ERROR,
      page: () => ErrorView(),
      binding: ErrorBinding(),
    ),
  ];
}
