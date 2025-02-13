import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:panucci_ristorante/models/item.dart';
import 'package:panucci_ristorante/services/printing_service.dart';
import 'package:panucci_ristorante/utils/printer_settings_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutViewmodel {

  Future<void> printReceipt(List<Item> items, double total) async {
    await PrintingService.printReceipt(await _prepareReceipt(items, total));
  }

  Future<List<int>> _prepareReceipt(List<Item> items, double total) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    PaperSize paperSize = PaperSizeUtils.getPaperSize(preferences.getInt("paperSize") ?? 1);
    PosTextSize textSize = TextSizeUtils.getTextSize(preferences.getInt("textSize") ?? 1);

    List<int> bytes =[];
    CapabilityProfile profile = await CapabilityProfile.load();
    Generator generator = Generator(paperSize, profile);
    bytes += generator.reset();
    bytes += generator.feed(2);
    bytes += generator.text("Panucci Ristorante", styles: PosStyles(
      align: PosAlign.center,
      height: PosTextSize.size2,
    ));
    bytes += generator.reset();
    bytes += generator.feed(1);
    bytes += generator.qrcode("https://www.panucci.com.br", size: QRSize.size8);
    bytes += generator.feed(1);
    for (Item item in items) {
      bytes += generator.row([PosColumn(text: item.nome, width: 6, styles: PosStyles(align: PosAlign.left, height: textSize)), PosColumn(text: item.preco.toStringAsFixed(2), width: 6, styles: PosStyles(align: PosAlign.right, height: textSize))]);
    }
    bytes += generator.reset();
    bytes += generator.hr();
    bytes += generator.row([PosColumn(text: "Total", width: 6, styles: PosStyles(align: PosAlign.left, height: textSize)),PosColumn(text: total.toStringAsFixed(2), width: 6, styles: PosStyles(align: PosAlign.right, height: textSize))]);
    bytes += generator.feed(3);

    return bytes;
  }
}