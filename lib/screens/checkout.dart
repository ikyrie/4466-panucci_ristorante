import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:panucci_ristorante/components/custom_buttons.dart';
import 'package:panucci_ristorante/components/order_item.dart';
import 'package:panucci_ristorante/store/carrinho_store.dart';
import 'package:panucci_ristorante/viewmodels/checkout_viewmodel.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import '../components/payment_method.dart';
import '../components/payment_total.dart';

class Checkout extends StatelessWidget {
  Checkout({Key? key}) : super(key: key);

  final CheckoutViewmodel checkoutViewmodel = CheckoutViewmodel();

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
                      if (await PrintBluetoothThermal.bluetoothEnabled) {
                        if (await PrintBluetoothThermal.connectionStatus) {
                          await checkoutViewmodel.printReceipt(
                              carrinhoStore.listaItem,
                              carrinhoStore.totalDaCompra);
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Nenhum dispositivo conectado"),
                              content: Text(
                                  "É necessário se conectar com uma impressora para imprimir uma comanda"),
                              actions: [
                                TextButton(
                                  child: Text("Ok"),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          );
                        }
                      } else {
                        showModalBottomSheet(context: context, builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 32),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.bluetooth, size: 48, color: Color(0xFFB81D27),),
                                SizedBox(height: 24,),
                                Text("Ativar Bluetooth", style: TextStyle(fontSize: 24),),
                                SizedBox(height: 24,),
                                Text("Para o aplicativo funcionar, precisamos que ligue o Bluetooth."),
                              ],
                            ),
                          );
                        },);
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
