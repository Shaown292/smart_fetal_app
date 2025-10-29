import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bluetooth_controller.dart';

class BluetoothView extends GetView<BluetoothController> {
  const BluetoothView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prenatal BLE Monitor")),
      body: Obx(() {
        if (!controller.connected.value) {
          return const Center(child: Text("Scanning for PrenatalBelt..."));
        }
        final d = controller.data.value;
        if (d == null) {
          return const Center(child: Text("Connected. Waiting for data..."));
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("🌡 ${d.tempMeanC.toStringAsFixed(2)} °C", style: const TextStyle(fontSize: 20)),
              Text("🧍 ${d.positionState}", style: const TextStyle(fontSize: 20)),
              Text("⭐ ${d.positionQuality}", style: const TextStyle(fontSize: 20)),
              Text("💓 ${d.heartRateBpm} bpm", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: controller.disconnect, child: const Text("Disconnect"))
            ],
          ),
        );
      }),
    );

  }
}
