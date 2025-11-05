import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:smart_fetal_app/app/modules/bluetooth/controllers/bluetooth_controller.dart';

import '../../../model/parental_belt_data.dart';

class CheckingPositionController extends GetxController with GetTickerProviderStateMixin{
  late AnimationController ripple1;
  late AnimationController ripple2;
  RxBool triggerAnimation = false.obs;
  RxBool updateChanges = false.obs;
  late final style = getStyleForPosition(parentalData.value!.positionState.toString());
  BluetoothController bluetoothController = BluetoothController();

  // RxList<PrenatalBeltData> dataList = <PrenatalBeltData>[].obs;
  RxBool isLoading = false.obs;

  Timer? _timer;

  final Dio _dio = Dio();
  final Rxn<PrenatalBeltData> parentalData = Rxn<PrenatalBeltData>();
  final error = ''.obs;

  Future<void> fetchData() async {
    isLoading.value = true;
    error.value = '';

    try {
      final response = await _dio.get('http://18.220.38.116:3000/receive');

      if (response.statusCode == 200) {
        final json = response.data['data'];
        parentalData.value = PrenatalBeltData.fromJson(json);
        print('✅ Data fetched: ${parentalData.value?.tempMeanC}');
      } else {
        error.value = 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      error.value = 'Failed to fetch data: $e';
    } finally {
      isLoading.value = false;
    }
  }



  @override
  void onInit() {
    super.onInit();
    fetchData();
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


}

class TiltRotation {
  double pitch;
  double roll;
  double yaw;

  TiltRotation({required this.pitch, required this.roll, required this.yaw});
}





