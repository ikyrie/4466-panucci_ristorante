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
                      bytes += generator.text("Panucci Ristorante");
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
