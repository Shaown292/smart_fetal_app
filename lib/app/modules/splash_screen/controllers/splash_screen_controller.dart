import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  // Progress value (0.0 - 1.0)
  final progress = 0.0.obs;

  // Current color of the progress bar
  final Rx<Color> color = Color(0xFFFFFFFF).obs;

  // List of colors to cycle through
  final List<Color> colorStages = [
    Color(0xFF9D476E),
    Color(0xFF9D476E).withOpacity(0.7),
  ];

  // Splash duration in milliseconds
  final int duration = 5000;

  // Timer tick interval
  final int tick = 35;

  @override
  void onInit() {
    super.onInit();
    startSplash();
  }

  void startSplash() async {
    int totalTicks = (duration / tick).round();

    for (int i = 0; i <= totalTicks; i++) {
      await Future.delayed(Duration(milliseconds: tick));

      // Update progress
      progress.value = i / totalTicks;

      // Update color based on progress
      int colorIndex = ((progress.value * colorStages.length).floor())
          .clamp(0, colorStages.length - 1);
      color.value = colorStages[colorIndex];
    }

    // ✅ Navigate to home screen after splash
    // Replace '/home' with your route
    Get.offNamed('/home');
  }
}
