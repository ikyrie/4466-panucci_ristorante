import 'package:flutter/material.dart';
import 'package:panucci_ristorante/screens/printer_settings.dart';
import 'package:panucci_ristorante/services/paired_devices_service.dart';
import 'package:panucci_ristorante/services/printer_connection_service.dart';

class PairedDevices extends StatelessWidget {
  PairedDevices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dispositivos Pareados",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PrinterSettings()));
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text("Bluetooth", style: TextStyle(fontSize: 22),),
                ),
              ),
              FutureBuilder(
                  future: PairedDevicesService.getPairedDevices(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SliverList.builder(
                        itemBuilder: (context, index) => ListTile(
                          onTap: () async {
                            await PrinterConnectionService.connect(
                                snapshot.data![index].macAdress);
                          },
                          title: Text(snapshot.data![index].name),
                          subtitle: Text(snapshot.data![index].macAdress),
                          leading: Icon(Icons.print),
                        ),
                        itemCount: snapshot.data!.length,
                      );
                    } else {
                      return SliverToBoxAdapter(
                        child: Container(),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
