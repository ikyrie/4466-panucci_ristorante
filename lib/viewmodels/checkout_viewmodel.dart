import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:panucci_ristorante/services/paired_devices_service.dart';
import 'package:panucci_ristorante/services/printer_connection_service.dart';
import 'package:panucci_ristorante/services/printing_service.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class CheckoutViewmodel {

  Future<void> printReceipt() async {

    List<BluetoothInfo> devices = await PairedDevicesService.getPairedDevices();
    await PrinterConnectionService.connect(devices[0].macAdress);
    await PrintingService.printReceipt(await _prepareReceipt());
  }

  Future<List<int>> _prepareReceipt() async {
    List<int> bytes =[];
    CapabilityProfile profile = await CapabilityProfile.load();
    Generator generator = Generator(PaperSize.mm58, profile);
    bytes += generator.reset();
    bytes += generator.text("Panucci Ristorante");

    return bytes;
  }
}