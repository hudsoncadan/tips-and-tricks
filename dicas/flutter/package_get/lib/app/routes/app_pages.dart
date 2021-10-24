import 'package:estrutura_get/app/modules/about/bindings/about_binding.dart';
import 'package:estrutura_get/app/modules/about/views/about_view.dart';
import 'package:estrutura_get/app/modules/home/bindings/home_binding.dart';
import 'package:estrutura_get/app/modules/home/views/home_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Paths.ABOUT,
      page: () => AboutView(),
      binding: AboutBinding(),
    ),
  ];
}
