import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController ripple1;
  late AnimationController ripple2;
  RxBool triggerAnimation = false.obs;

  @override
  void onInit() {
    super.onInit();

    ripple1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    ripple2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Start ripple 2 after delay
    Future.delayed(const Duration(milliseconds: 800), () {
      ripple2.repeat();
    });

  }

  @override
  void onClose() {
    ripple1.dispose();
    ripple2.dispose();

    super.onClose();
  }
}
