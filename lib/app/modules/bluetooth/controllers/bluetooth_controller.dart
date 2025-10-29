import 'dart:convert';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../model/parental_belt_data.dart';

class BluetoothController extends GetxController {
  // final flutterBlue = FlutterBluePlus.instance;

  var connected = false.obs;
  var data = Rxn<PrenatalBeltData>();
  BluetoothDevice? device;

  @override
  void onInit() {
    super.onInit();
    scanAndConnect();
  }
  Future<void> requestPermissions() async {
    // Request necessary permissions for BLE
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();

    // Check if any permission is denied
    if (statuses.values.any((status) => !status.isGranted)) {
      throw Exception("BLE permissions not granted");
    }
  }


  Future<void> scanAndConnect() async {
    await requestPermissions();
    print("🔍 Scanning for PrenatalBelt...");
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 15)); // longer
    FlutterBluePlus.scanResults.listen((results) async {
      for (var r in results) {
        if (r.device.name == "PrenatalBelt") {
          print("✅ Found PrenatalBelt: ${r.device.id}");

          // Stop scanning once we start connecting
          await FlutterBluePlus.stopScan();

          device = r.device;
          await _connectToDevice(device!);
          return; // stop processing further
        }
      }
    });

  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    await device.connect(autoConnect: false);
    connected.value = true;
    print("Connected to ${device.name}");

    // discover services
    List<BluetoothService> services = await device.discoverServices();

    for (var service in services) {
      for (var characteristic in service.characteristics) {
        // look for a characteristic that supports notify
        if (characteristic.properties.notify) {
          print("📡 Found notify characteristic: ${characteristic.uuid}");
          await characteristic.setNotifyValue(true);

          characteristic.onValueReceived.listen((value) {
            final str = utf8.decode(value);
            for (final line in str.split('\n')) {
              if (line.trim().isEmpty) continue;
              try {
                final jsonData = jsonDecode(line.trim());
                data.value = PrenatalBeltData.fromJson(jsonData);
              } catch (_) {
                print("❌ Invalid JSON: $line");
              }
            }
          });
          return; // stop after first notify characteristic
        }
      }
    }

    print("⚠️ No notify characteristic found!");
  }

  void disconnect() {
    device?.disconnect();
    connected.value = false;
  }
}
