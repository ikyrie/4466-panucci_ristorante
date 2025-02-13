import 'package:flutter/material.dart';
import 'package:panucci_ristorante/components/custom_buttons.dart';

class PrinterSettings extends StatelessWidget {
  PrinterSettings({super.key});

  final TextEditingController paperSizeController = TextEditingController();
  final TextEditingController fontSizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Icon(
                  Icons.print,
                  color: Color(0xFFB81D27),
                  size: 48,
                ),
              ),
              SizedBox(height: 8,),
              Text("Configuração de impressão", style: TextStyle(fontSize: 24), textAlign: TextAlign.center,),
              SizedBox(height: 40,),
              Text("Selecione as configurações básicas para a sua impressão:"),
              SizedBox(height: 24,),
              DropdownMenu<dynamic>(
                controller: paperSizeController,
                onSelected: (value) => {},
                inputDecorationTheme: InputDecorationTheme(
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  )
                ),
                width: 200,
                label: Text("Tamanho do papel"),
                initialSelection: 1,
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: 1, label: "58mm"),
                  DropdownMenuEntry(value: 2, label: "72mm"),
                  DropdownMenuEntry(value: 3, label: "80mm"),
                ],
              ),
              SizedBox(height: 24,),
              DropdownMenu<dynamic>(
                controller: fontSizeController,
                onSelected: (value) => {},
                inputDecorationTheme: InputDecorationTheme(
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  )
                ),
                width: 200,
                label: Text("Tamanho da fonte"),
                initialSelection: 1,
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: 1, label: "1"),
                  DropdownMenuEntry(value: 2, label: "2"),
                  DropdownMenuEntry(value: 3, label: "3"),
                  DropdownMenuEntry(value: 4, label: "4"),
                  DropdownMenuEntry(value: 5, label: "5"),
                  DropdownMenuEntry(value: 6, label: "6"),
                  DropdownMenuEntry(value: 7, label: "7"),
                  DropdownMenuEntry(value: 8, label: "8"),
                ],
              ),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    CustomPrimaryButton(
                      onTap: () async {},
                      text: "Salvar configuração",
                    ),
                    SizedBox(height: 16,),
                    CustomSecondaryButton(
                        onTap: () async {}, text: "Imprimir teste"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
