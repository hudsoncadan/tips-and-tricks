import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeartController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController _animationController;
  late Animation<double> animationScale;
  late Animation<double> animationFade;

  @override
  void onInit() {
    super.onInit();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    animationScale = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 1),
      ],
    ).animate(_animationController);

    // Just for curiosity
    // It's possible to control when a TweenSequence will happen during the animation
    // by instantiating a CurvedAnimation with Interval in the animate() method
    animationFade = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem(tween: Tween(begin: 0, end: .3), weight: 1),
        TweenSequenceItem(tween: Tween(begin: .3, end: .7), weight: 3),
        TweenSequenceItem(tween: Tween(begin: .7, end: 0), weight: 3),
      ],
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 1, curve: Curves.easeOut),
      ),
    );
  }

  runAnimation() {
    _animationController.reset();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
