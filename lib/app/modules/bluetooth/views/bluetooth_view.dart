import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bluetooth_controller.dart';

class BluetoothView extends GetView<BluetoothController> {
  const BluetoothView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BLE Device Scanner')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: controller.startScan,
            child: Text('Scan Devices'),
          ),
          Obx(() => Expanded(
            child: ListView.builder(
              itemCount: controller.devices.length,
              itemBuilder: (context, index) {
                final device = controller.devices[index];
                return ListTile(
                  title: Text(device.name.isEmpty ? 'Unknown' : device.name),
                  subtitle: Text(device.id),
                  onTap: () => controller.connectToDevice(device.id),
                );
              },
            ),
          )),
          Obx(() => Text('Received Data: ${controller.receivedData.value}')),
        ],
      ),
    );

  }
}
