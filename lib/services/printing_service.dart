import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:panucci_ristorante/utils/printer_settings_utils.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrintingService {
  static Future<void> printReceipt(List<int> bytes) async {
    try {
      await PrintBluetoothThermal.writeBytes(bytes);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> printTest() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    PaperSize paperSize = PaperSizeUtils.getPaperSize(preferences.getInt("paperSize") ?? 1);
    PosTextSize texSize = TextSizeUtils.getTextSize(preferences.getInt("textSize") ?? 1);
    List<int> bytes = [];
    CapabilityProfile profile = await CapabilityProfile.load();
    Generator generator = Generator(paperSize, profile);

    bytes += generator.reset();
    bytes += generator.feed(2);
    bytes += generator.text("Panucci Ristorante", styles: PosStyles(
      align: PosAlign.center,
      height: PosTextSize.size2,
    ));
    bytes += generator.reset();
    bytes += generator.text("Panucci Ristorante 1", styles: PosStyles(
      align: PosAlign.right,
      height: PosTextSize.size1,
    ));
    bytes += generator.reset();
    bytes += generator.text("Panucci Ristorante 1", styles: PosStyles(
      align: PosAlign.right,
      height: PosTextSize.size1,
    ));
    bytes += generator.reset();
    bytes += generator.text("Panucci Ristorante Bold", styles: PosStyles(
      align: PosAlign.left,
      height: texSize,
      bold: true,
    ));
    bytes += generator.reset();
    bytes += generator.feed(3);
    await printReceipt(bytes);
  }
}