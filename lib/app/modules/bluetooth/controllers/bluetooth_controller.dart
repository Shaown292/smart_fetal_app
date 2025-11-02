import 'dart:async';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';

class BluetoothController extends GetxController {
  final flutterReactiveBle = FlutterReactiveBle();
  final myServiceUuid = Uuid.parse("12345678-1234-1234-1234-123456789013");

  // Observables
  var devices = <DiscoveredDevice>[].obs;
  var connectedDevice = <String, ConnectionStateUpdate>{}.obs;
  var receivedData = ''.obs;

  // Scanning
  void startScan() {
    devices.clear();
    flutterReactiveBle.scanForDevices(withServices: [myServiceUuid]).listen((device) {
      if (!devices.any((d) => d.id == device.id)) {
        devices.add(device);
      }
    }, onError: (e) {
      print('Scan error: $e');
    });
  }


  void scanForMyService() {

    flutterReactiveBle.scanForDevices(withServices: [myServiceUuid]).listen(
          (device) {
        print('Found device: ${device.name}, id: ${device.id}');
        // You can now connect to this device
      },
      onError: (e) => print('Scan error: $e'),
    );
  }

  void stopScan() {
    flutterReactiveBle.deinitialize();
  }

  // Connect to a device
  void connectToDevice(String deviceId) {
    flutterReactiveBle.connectToDevice(id: deviceId).listen((connectionState) {
      connectedDevice[deviceId] = connectionState;
      if (connectionState.connectionState == DeviceConnectionState.connected) {
        print('Connected to $deviceId');
        discoverServices(deviceId);
      }
    }, onError: (e) {
      print('Connection error: $e');
    });
  }

  // Discover services & characteristics
  void discoverServices(String deviceId) async {
    final services = await flutterReactiveBle.discoverServices(deviceId);
    for (var service in services) {
      for (var char in service.characteristics) {
        // Subscribe to notifications if supported
        if (char.isNotifiable) {
          flutterReactiveBle.subscribeToCharacteristic(char as QualifiedCharacteristic).listen((data) {
            receivedData.value = data.toString();
          });
        }
      }
    }
  }

  // Write data to a characteristic
  Future<void> writeData(QualifiedCharacteristic characteristic, List<int> value) async {
    await flutterReactiveBle.writeCharacteristicWithResponse(characteristic, value: value);
  }
}