import 'dart:async';
import 'dart:convert';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../model/parental_belt_data.dart';
import '../../../routes/app_pages.dart';

/// Bluetooth Controller for handling BLE communication
class BluetoothController extends GetxController {
  final FlutterReactiveBle _ble = FlutterReactiveBle();

  // Replace these UUIDs with your device's service and characteristic
  final myServiceUuid = Uuid.parse("12345678-1234-1234-1234-123456789012");
  final characteristicUuid = Uuid.parse("12345678-1234-1234-1234-123456789013");

  // Reactive observables
  var devices = <DiscoveredDevice>[].obs;
  var connectionStatus = "Disconnected".obs;
  var connectedDeviceId = "".obs;
  var receivedData = "".obs;
  var beltData = Rxn<PrenatalBeltData>();

  StreamSubscription<DiscoveredDevice>? _scanSubscription;
  Stream<ConnectionStateUpdate>? _connectionStream;

  /// Request runtime BLE permissions
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

  /// Start scanning for devices advertising our target service
  void startScan() async {
    devices.clear();
    await requestPermissions();

    _scanSubscription = _ble.scanForDevices(withServices: [myServiceUuid]).listen(
          (device) {
        if (!devices.any((d) => d.id == device.id)) {
          devices.add(device);
          print("Found device: ${device.name} (${device.id})");
        }
      },
      onError: (e) => print("Scan error: $e"),
    );
  }

  /// Stop scanning
  void stopScan() {
    _scanSubscription?.cancel();
    _scanSubscription = null;
  }

  /// Connect to the selected BLE device
  void connectToDevice(DiscoveredDevice device) {
    connectedDeviceId.value = device.id;
    connectionStatus.value = "Connecting";

    _connectionStream = _ble.connectToDevice(
      id: device.id,
      connectionTimeout: const Duration(seconds: 10),
    );

    _connectionStream!.listen(
          (update) {
        connectionStatus.value = update.connectionState.toString();
        print("Device ${device.name} state: ${update.connectionState}");

        if (update.connectionState == DeviceConnectionState.connected) {
          discoverServices(device.id);
          Get.toNamed(Routes.SPLASH_SCREEN); // Navigate after successful connection
        }
      },
      onError: (e) {
        print("Connection error: $e");
        connectionStatus.value = "Error";
      },
    );
  }

  /// Discover GATT services and subscribe to the target characteristic
  Future<void> discoverServices(String deviceId) async {
    try {
      final services = await _ble.discoverServices(deviceId);

      print("=== Services & Characteristics ===");
      for (var service in services) {
        print("Service: ${service.serviceId}");
        for (var char in service.characteristics) {
          print(
              "  Char: ${char.characteristicId}  Read:${char.isReadable} Notify:${char.isNotifiable}");

          // Only subscribe to our target characteristic
          if (char.characteristicId == characteristicUuid && char.isNotifiable) {
            subscribeToCharacteristic(deviceId, service.serviceId, char.characteristicId);
          }
        }
      }
      print("==================================");
    } catch (e) {
      print("Service discovery error: $e");
    }
  }

  /// Subscribe to the characteristic for streaming data
  void subscribeToCharacteristic(String deviceId, Uuid serviceId, Uuid characteristicId) {
    print("Entered1");
    final characteristic = QualifiedCharacteristic(
      serviceId: serviceId,
      characteristicId: characteristicId,
      deviceId: deviceId,
    );
    print("Entered2");
    final buffer = StringBuffer(); // optional for fragmented packets

    _ble.subscribeToCharacteristic(characteristic).listen((data) {
      try {
        print("Entered3");
        final jsonString = utf8.decode(data);
        print("Raw data: $jsonString");
        final jsonMap = jsonDecode(jsonString);
        beltData.value = PrenatalBeltData.fromJson(jsonMap);
        receivedData.value = jsonString;
      } catch (e) {
        print("Error decoding BLE data: $e");
      }
    }, onError: (e) {
      print("Subscribe error: $e");
    });
  }

  /// Read characteristic (on demand)
  Future<void> readCharacteristic() async {
    if (connectedDeviceId.value.isEmpty) return;

    final characteristic = QualifiedCharacteristic(
      serviceId: myServiceUuid,
      characteristicId: characteristicUuid,
      deviceId: connectedDeviceId.value,
    );

    try {
      final data = await _ble.readCharacteristic(characteristic);
      final jsonString = utf8.decode(data);
      final jsonMap = jsonDecode(jsonString);
      beltData.value = PrenatalBeltData.fromJson(jsonMap);
      receivedData.value = jsonString;
      print("Read data: $jsonString");
    } catch (e) {
      print("Read error: $e");
    }
  }

 // / Disconnect device
 //  void disconnectDevice() {
 //    if (connectedDeviceId.value.isNotEmpty) {
 //      _ble.(id: connectedDeviceId.value);
 //      connectionStatus.value = "Disconnected";
 //      connectedDeviceId.value = "";
 //      beltData.value = null;
 //    }
 //  }

  @override
  void onClose() {
    stopScan();
    // disconnectDevice();
    super.onClose();
  }
}