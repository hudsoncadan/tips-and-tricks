import 'package:flutter/material.dart';
import 'package:flutter_heart_animation/app/modules/home/widgets/heart/heart_controller.dart';
import 'package:get/get.dart';

class HeartWidget extends GetView<HeartController> {

  HeartWidget({Key? key}) : super(key: key) {
    tag = key.toString();

    // We need to put Controller with different tags,
    // so Flutter is aware that each HeartWidget has its own Controller and Animation
    Get.put(HeartController(), tag: tag);
  }

  // We need to override tag,
  // so Flutter is aware that each HeartWidget has its own Controller and Animation
  @override
  String? tag;

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: Icon(Icons.favorite, size: 150),
    );
  }
}

