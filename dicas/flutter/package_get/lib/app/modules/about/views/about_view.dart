import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AboutView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AboutView is working',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
