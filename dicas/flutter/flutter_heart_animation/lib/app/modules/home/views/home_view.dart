import 'package:flutter/material.dart';
import 'package:flutter_heart_animation/app/models/photo_model.dart';
import 'package:flutter_heart_animation/app/modules/home/widgets/heart/heart_widget.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(
          () => ListView.builder(
            itemCount: controller.listPhotos.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) {
              final PhotoModel model = controller.listPhotos.elementAt(index);
              HeartWidget heartWidget = HeartWidget(key: Key(index.toString()));

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(model.title!),
                    GestureDetector(
                      onDoubleTap: () {
                        heartWidget.controller.animationController.reset();
                        heartWidget.controller.animationController.forward();
                      },
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Image.network(model.url!),
                            ),
                            ScaleTransition(
                              scale: heartWidget.controller.animationScale,
                              child: FadeTransition(
                                opacity: heartWidget.controller.animationFade,
                                child: heartWidget,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
