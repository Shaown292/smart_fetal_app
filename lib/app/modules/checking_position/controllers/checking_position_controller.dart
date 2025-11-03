import 'dart:async';
import 'dart:convert';

import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_fetal_app/app/modules/bluetooth/controllers/bluetooth_controller.dart';

import '../../../model/parental_belt_data.dart';

class CheckingPositionController extends GetxController with GetTickerProviderStateMixin{
  late AnimationController ripple1;
  late AnimationController ripple2;
  RxBool triggerAnimation = false.obs;
  RxBool updateChanges = false.obs;
  RxList<PrenatalBeltData> parentalData = <PrenatalBeltData>[].obs;
  late final style = getStyleForPosition(parentalData.last.positionState);
  BluetoothController bluetoothController = BluetoothController();

  // RxList<PrenatalBeltData> dataList = <PrenatalBeltData>[].obs;
  RxBool isLoading = false.obs;

  Timer? _timer;


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
    fetchPrenatalData();
    // loadLocalJson();
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

  Future<List<PrenatalBeltData>> fetchPrenatalData() async {
    final String response =  bluetoothController.receivedData.value;
    final List<dynamic> data = json.decode(response);
    parentalData.value = data.map((e) => PrenatalBeltData.fromJson(e)).toList();
    print(parentalData.last.positionState);
    return data.map((e) => PrenatalBeltData.fromJson(e)).toList();
  }
}

class TiltRotation {
  double pitch;
  double roll;
  double yaw;

  TiltRotation({required this.pitch, required this.roll, required this.yaw});
}





