import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bluetooth_controller.dart';

class BluetoothView extends GetView<BluetoothController> {
  const BluetoothView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BLE Devices")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => controller.startScan(), // optional
              child: Text("Scan Devices"),
            ),
          ),
          Obx(() => Expanded(
            child: ListView.builder(
              itemCount: controller.devices.length,
              itemBuilder: (context, index) {
                final device = controller.devices[index];
                return ListTile(
                  title: Text(device.name.isEmpty ? "Unknown" : device.name),
                  subtitle: Text(device.id),
                  trailing: Obx(() => controller.connectedDeviceId.value == device.id
                      ? Text(controller.connectionStatus.value)
                      : SizedBox.shrink()),
                  onTap: () => controller.connectToDevice(device),
                );
              },
            ),
          )),
          // ElevatedButton(
          //   onPressed: () {
          //     // final controller = Get.find<BluetoothController>();
          //
          //     controller.readCharacteristic();
          //   },
          //   child: Text("Fetch Data"),
          // )

        ],
      ),
    );

  }
}
