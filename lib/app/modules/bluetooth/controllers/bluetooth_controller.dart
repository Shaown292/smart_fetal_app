import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothController extends GetxController {
  final FlutterReactiveBle _ble = FlutterReactiveBle();
  final myServiceUuid = Uuid.parse("12345678-1234-1234-1234-123456789012");
  final characteristicUuid = Uuid.parse("12345678-1234-1234-1234-123456789013");

  // Observables
  var devices = <DiscoveredDevice>[].obs;
  var connectionStatus = "Disconnected".obs;
  var connectedDeviceId = "".obs;
  var receivedData = "".obs;

  Stream<ConnectionStateUpdate>? _connectionStream;

  /// Request runtime permissions for BLE
  Future<void> requestPermissions() async {
    var status = await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetooth,
      Permission.location,
    ].request();

    if (status[Permission.bluetoothScan] != PermissionStatus.granted ||
        status[Permission.bluetoothConnect] != PermissionStatus.granted) {
      throw Exception("BLE permissions not granted");
    }
  }

  /// Scan for BLE devices (optional: filter by service UUID)
  void startScan({String? serviceUuid}) async {
    devices.clear();
    await requestPermissions();

    // List<Uuid> services = [myServiceUuid];
    // if (serviceUuid != null && serviceUuid.isNotEmpty) {
    //   services.add(Uuid.parse(serviceUuid));
    // }

    _ble.scanForDevices(withServices: [myServiceUuid]).listen((device) {
      if (!devices.any((d) => d.id == device.id)) {
        devices.add(device);
      }
      else{
        Text("Device not found");
      }
    }, onError: (e) {
      print("Scan error: $e");
    });
  }

  /// Stop scanning (cleanup)
  void stopScan() {
    _ble.deinitialize(); // clears old BLE connections
  }

  /// Connect to a BLE device
  void connectToDevice(DiscoveredDevice device) {
    connectedDeviceId.value = device.id;
    connectionStatus.value = "Connecting";

    _connectionStream = _ble.connectToDevice(
      id: device.id,
      connectionTimeout: Duration(seconds: 10),
    );

    _connectionStream!.listen((update) {
      connectionStatus.value = update.connectionState.toString();

      print("Device ${device.name} state: ${update.connectionState}");

      if (update.connectionState == DeviceConnectionState.connected) {
        discoverServices(device.id);
      }
    }, onError: (e) {
      print("Connection error: $e");
      connectionStatus.value = "Error";
    });
  }

  /// Disconnect device
  // void disconnectDevice() {
  //   if (connectedDeviceId.value.isNotEmpty) {
  //     _ble.disconnectDevice(id: connectedDeviceId.value);
  //     connectionStatus.value = "Disconnected";
  //     connectedDeviceId.value = "";
  //   }
  // }

  /// Discover services and characteristics
  void discoverServices(String deviceId) async {
    final services = await _ble.discoverServices(deviceId);

    print("=== Services & Characteristics ===");
    for (var service in services) {
      print("Service: ${service.serviceId}");

      for (var char in service.characteristics) {
        print("  Characteristic: ${char.characteristicId} "
            "Read:${char.isReadable} "
            "Notify:${char.isNotifiable} "
            "Write:${char.isWritableWithResponse} / ${char.isWritableWithoutResponse}");
        // Subscribe if notifiable
        if (char.isNotifiable) {
          subscribeToCharacteristic(deviceId, service.serviceId, char.characteristicId);
        }
      }
    }
    print("==================================");
  }


  /// Subscribe to notifications from a characteristic
  void subscribeToCharacteristic(String deviceId, Uuid serviceId, Uuid characteristicId) {
    final characteristic = QualifiedCharacteristic(
      serviceId: serviceId,
      characteristicId: characteristicId,
      deviceId: deviceId,
    );

    _ble.subscribeToCharacteristic(characteristic).listen((data) {
      receivedData.value = data.toString();
      print("Received data: $data");
    }, onError: (e) {
      print("Subscribe error: $e");
    });
  }

  Future<void> readCharacteristic() async {
    if (connectedDeviceId.value.isEmpty) return;

    final characteristic = QualifiedCharacteristic(
      serviceId: myServiceUuid,
      characteristicId: characteristicUuid,
      deviceId: connectedDeviceId.value,
    );

    try {
      final data = await _ble.readCharacteristic(characteristic);
      receivedData.value = data.toString();
      print("Read Data: $data");
    } catch (e) {
      print("Read error: $e");
    }
  }

}