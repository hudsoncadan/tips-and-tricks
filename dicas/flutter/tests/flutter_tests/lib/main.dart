import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  configHttpClient();

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}

configHttpClient() {
  Get.put(
      Dio(BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com/',
      )),
      permanent: true);
}
