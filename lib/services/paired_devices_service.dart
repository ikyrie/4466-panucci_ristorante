import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class PairedDevicesService {
  static Future<List<BluetoothInfo>> getPairedDevices() async {
    List<BluetoothInfo> devices = [];
    try {
      devices = await PrintBluetoothThermal.pairedBluetooths;
    } catch (e) {
      print(e);
    }
    return devices;
  }
}