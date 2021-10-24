import 'package:estrutura_get/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Text(
                  controller.count.value.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              ElevatedButton(
                onPressed: controller.increment,
                child: const Text('Increment'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(Paths.ABOUT);
                },
                child: const Text('Go to About Page'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
