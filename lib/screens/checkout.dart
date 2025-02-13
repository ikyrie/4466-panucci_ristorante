import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:panucci_ristorante/components/custom_buttons.dart';
import 'package:panucci_ristorante/components/order_item.dart';
import 'package:panucci_ristorante/screens/paired_devices.dart';
import 'package:panucci_ristorante/services/paired_devices_service.dart';
import 'package:panucci_ristorante/services/printer_connection_service.dart';
import 'package:panucci_ristorante/services/printing_service.dart';
import 'package:panucci_ristorante/store/carrinho_store.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import '../components/payment_method.dart';
import '../components/payment_total.dart';

class Checkout extends StatelessWidget {
  Checkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CarrinhoStore carrinhoStore = GetIt.instance.get<CarrinhoStore>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pedido",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: <Widget>[
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Pedido",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return OrderItem(item: carrinhoStore.listaItem[index]);
                  },
                      childCount: carrinhoStore.listaItem.length)),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Pagamento",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: PaymentMethod(),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Confirmar",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: PaymentTotal(total: carrinhoStore.totalDaCompra),),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                    alignment: Alignment.bottomCenter,
                  child: CheckoutButton(
                    onTap: () async {
                      List<BluetoothInfo> devices = await PairedDevicesService.getPairedDevices();
                      await PrinterConnectionService.connect(devices[0].macAdress);
                      List<int> bytes = [];
                      CapabilityProfile profile = await CapabilityProfile.load();
                      Generator generator = Generator(PaperSize.mm58, profile);

                        // Using default profile
                        //bytes += generator.setGlobalFont(PosFontType.fontA);
                        bytes += generator.reset();
                        bytes += generator.text(
                            'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ',
                            styles: PosStyles());
                        bytes += generator.text(
                            'Special 1: ñÑ àÀ èÈ éÉ üÜ çÇ ôÔ',
                            styles: PosStyles(codeTable: 'CP1252'));
                        bytes += generator.text(
                          'Special 2: blåbærgrød',
                          styles: PosStyles(codeTable: 'CP1252'),
                        );

                        bytes += generator.text('Bold text',
                            styles: PosStyles(bold: true));
                        bytes += generator.text('Reverse text',
                            styles: PosStyles(reverse: true));
                        bytes += generator.text('Underlined text',
                            styles: PosStyles(underline: true), linesAfter: 1);
                        bytes += generator.text('Align left',
                            styles: PosStyles(align: PosAlign.left));
                        bytes += generator.text('Align center',
                            styles: PosStyles(align: PosAlign.center));
                        bytes += generator.text('Align right',
                            styles: PosStyles(align: PosAlign.right),
                            linesAfter: 1);

                        bytes += generator.row([
                          PosColumn(
                            text: 'col3',
                            width: 3,
                            styles: PosStyles(
                                align: PosAlign.center, underline: true),
                          ),
                          PosColumn(
                            text: 'col6',
                            width: 6,
                            styles: PosStyles(
                                align: PosAlign.center, underline: true),
                          ),
                          PosColumn(
                            text: 'col3',
                            width: 3,
                            styles: PosStyles(
                                align: PosAlign.center, underline: true),
                          ),
                        ]);

                        //barcode
                        final List<int> barData = [
                          1,
                          2,
                          3,
                          4,
                          5,
                          6,
                          7,
                          8,
                          9,
                          0,
                          4
                        ];
                        bytes += generator.barcode(Barcode.upcA(barData));

                        //QR code
                        bytes += generator.qrcode('example.com');

                        bytes += generator.text(
                          'Text size 50%',
                          styles: PosStyles(
                            fontType: PosFontType.fontB,
                          ),
                        );
                        bytes += generator.text(
                          'Text size 100%',
                          styles: PosStyles(
                            fontType: PosFontType.fontA,
                          ),
                        );
                        bytes += generator.text(
                          'Text size 200%',
                          styles: PosStyles(
                            height: PosTextSize.size2,
                            width: PosTextSize.size2,
                          ),
                        );

                        bytes += generator.feed(2);
                        //bytes += generator.cut();

                      await PrintingService.printReceipt(bytes);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
