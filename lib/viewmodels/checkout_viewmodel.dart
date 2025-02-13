import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:panucci_ristorante/models/item.dart';
import 'package:panucci_ristorante/services/printing_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutViewmodel {

  Future<void> printReceipt(List<Item> items, double total) async {
    await PrintingService.printReceipt(await _prepareReceipt(items, total));
  }

  Future<List<int>> _prepareReceipt(List<Item> items, double total) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    int paperSize = preferences.getInt("paperSize")!;
    int textSize = preferences.getInt("textSize")!;

    print(paperSize);
    print(textSize);

    List<int> bytes =[];
    CapabilityProfile profile = await CapabilityProfile.load();
    Generator generator = Generator(PaperSize.mm58, profile);
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
      bytes += generator.row([PosColumn(text: item.nome, width: 6, styles: PosStyles(align: PosAlign.left)), PosColumn(text: item.preco.toStringAsFixed(2), width: 6, styles: PosStyles(align: PosAlign.right))]);
    }
    bytes += generator.reset();
    bytes += generator.hr();
    bytes += generator.row([PosColumn(text: "Total", width: 6, styles: PosStyles(align: PosAlign.left)),PosColumn(text: total.toStringAsFixed(2), width: 6, styles: PosStyles(align: PosAlign.right))]);
    bytes += generator.feed(3);

    return bytes;
  }
}