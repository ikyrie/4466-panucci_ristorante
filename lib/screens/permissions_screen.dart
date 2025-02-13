import 'package:flutter/material.dart';
import 'package:panucci_ristorante/components/custom_buttons.dart';
import 'package:panucci_ristorante/screens/home.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Permissões"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.bluetooth,
                color: Color(0xFFB81D27),
                size: 48,
              ),
              SizedBox(height: 8),
              Text(
                "Precisamos de acesso ao seu Bluetooth",
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              Text(
                  "Para fazer a impressão, a aplicação precisa de autorização do seu dispositivo para acessar o Bluetooth."),
              SizedBox(height: 32),
              CustomPrimaryButton(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                },
                text: "Autorizar Bluetooth",
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Agora não",
                  style: TextStyle(
                    color: Color(0xFFB81D27),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
