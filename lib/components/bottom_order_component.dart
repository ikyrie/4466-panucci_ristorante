import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:panucci_ristorante/screens/checkout.dart';
import 'package:panucci_ristorante/store/carrinho_store.dart';

class BottomOrderComponent extends StatelessWidget {
  BottomOrderComponent({super.key});

  final CarrinhoStore carrinhoStore = GetIt.instance.get<CarrinhoStore>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Checkout();
        }));
      },
      child: Observer(
        builder: (context) => Container(
            width: double.infinity,
            height: 80,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Color(0xFFB81D27),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10))),
            child: Stack(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        "${carrinhoStore.quantidadeItem}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                    Icon(
                      Icons.list_alt,
                      size: 24,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Ver pedido",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "R\$ ${carrinhoStore.totalDaCompra.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ])),
      ),
    );
  }
}
