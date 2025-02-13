import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:panucci_ristorante/components/bottom_order_component.dart';
import 'package:panucci_ristorante/components/item_list.dart';
import 'package:panucci_ristorante/screens/paired_devices.dart';
import 'package:panucci_ristorante/store/carrinho_store.dart';
import '../components/categoria_text.dart';
import '../components/search_input.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final TextEditingController searchTextController = TextEditingController();
  final CarrinhoStore carrinhoStore = GetIt.instance.get<CarrinhoStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cardápio",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PairedDevices()));
            },
            icon: Icon(Icons.print),
          )
        ],
      ),
      body: SafeArea(
        child: Stack(children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                  child:
                      SearchInput(searchTextController: searchTextController)),
              const SliverToBoxAdapter(
                  child: CategoriaText(titulo: "Mais comprados")),
              const SliverToBoxAdapter(
                child: ItemList(categoria: "mais comprados"),
              ),
              const SliverToBoxAdapter(
                  child: CategoriaText(titulo: "Para o almoço")),
              const SliverToBoxAdapter(
                child: ItemList(categoria: "para o almoço"),
              ),
              const SliverToBoxAdapter(
                  child: CategoriaText(titulo: "Para dividir")),
              const SliverToBoxAdapter(
                child: ItemList(categoria: "para dividir"),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 70),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Observer(
              builder: (_) => !carrinhoStore.listaVazia
                  ? BottomOrderComponent()
                  : Container(),
            ),
          )
        ]),
      ),
    );
  }
}


