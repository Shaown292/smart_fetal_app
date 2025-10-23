import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../model/parental_belt_data.dart';

class CheckingPositionController extends GetxController with GetTickerProviderStateMixin{
  late AnimationController ripple1;
  late AnimationController ripple2;
  RxBool triggerAnimation = false.obs;
  RxBool updateChanges = false.obs;

  RxList<PrenatalBeltData> dataList = <PrenatalBeltData>[].obs;
  RxBool isLoading = false.obs;

  Timer? _timer;

  Future<void> loadLocalJson() async {
    try {
      isLoading.value = true;
      final jsonString =
      await rootBundle.loadString('assets/data/prenatal_belt_dummy_array.json');
      final parsed = PrenatalBeltData.listFromJson(jsonString);
      dataList.assignAll(parsed);
      print('✅ Loaded ${dataList.length} records from local JSON');
    } catch (e) {
      print('❌ Error loading JSON: $e');
    } finally {
      isLoading.value = false;
    }
  }


  // Reactive tilt/rotation
  var imuA = TiltRotation(pitch: 3.2, roll: 2.0, yaw: 0.6).obs;
  var imuB = TiltRotation(pitch: 0.1, roll: 2, yaw: 0).obs;

  // Update function with new values
  void updateImuA(double pitch, double roll, double yaw) {
    imuA.update((val) {
      val!.pitch = pitch;
      val.roll = roll;
      val.yaw = yaw;
    });
  }

  void updateImuB(double pitch, double roll, double yaw) {
    imuB.update((val) {
      val!.pitch = pitch;
      val.roll = roll;
      val.yaw = yaw;
    });
  }


  @override
  void onInit() {
    super.onInit();
    loadLocalJson();
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
    _timer?.cancel();
    ripple1.dispose();
    ripple2.dispose();

    super.onClose();
  }
}

class TiltRotation {
  double pitch;
  double roll;
  double yaw;

  TiltRotation({required this.pitch, required this.roll, required this.yaw});
}

