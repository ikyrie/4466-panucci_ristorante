import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:panucci_ristorante/components/custom_buttons.dart';
import 'package:panucci_ristorante/components/order_item.dart';
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
                      final List<BluetoothInfo> listResult = await PrintBluetoothThermal.pairedBluetooths;
                      await Future.forEach(listResult,
                          (BluetoothInfo bluetooth) {
                        String name = bluetooth.name;
                        String mac = bluetooth.macAdress;
                        print(name);
                        print(mac);
                      }); 
                      String macAddress = "60:6E:41:62:D9:8C";
                      final bool result = await PrintBluetoothThermal.connect(
                          macPrinterAddress: macAddress);
                      bool conexionStatus = await PrintBluetoothThermal.connectionStatus;
                      if (conexionStatus) {
                        String enter = '\n';
                        await PrintBluetoothThermal.writeBytes(enter.codeUnits);
                        //size of 1-5
                        String text = "Hello $enter";
                        await PrintBluetoothThermal.writeString(
                            printText:
                                PrintTextSize(size: 1, text: text + " size 1"));
                        await PrintBluetoothThermal.writeString(
                            printText:
                                PrintTextSize(size: 2, text: text + " size 2"));
                        await PrintBluetoothThermal.writeString(
                            printText:
                                PrintTextSize(size: 3, text: text + " size 3"));
                        await PrintBluetoothThermal.writeString(
                            printText:
                                PrintTextSize(size: 2, text: text + " size 4"));
                        await PrintBluetoothThermal.writeString(
                            printText:
                                PrintTextSize(size: 3, text: text + " size 5"));
                      } else {
                        print("the printer is disconnected ($conexionStatus)");
                      }

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
