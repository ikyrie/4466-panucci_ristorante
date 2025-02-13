import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/material.dart';
import 'package:panucci_ristorante/components/custom_buttons.dart';

class PrinterSettings extends StatelessWidget {
  PrinterSettings({super.key});

  final TextEditingController paperSizeController = TextEditingController();
  final TextEditingController fontSizeController = TextEditingController();

  PaperSize paperSize = PaperSize.mm58;
  PosTextSize textSize = PosTextSize.size1;

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
              DropdownMenu<PaperSize>(
                controller: paperSizeController,
                onSelected: (value) => {paperSize = value!},
                inputDecorationTheme: InputDecorationTheme(
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  )
                ),
                width: 200,
                label: Text("Tamanho do papel"),
                initialSelection: PaperSize.mm58,
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: PaperSize.mm58, label: "58mm"),
                  DropdownMenuEntry(value: PaperSize.mm72, label: "72mm"),
                  DropdownMenuEntry(value: PaperSize.mm80, label: "80mm"),
                ],
              ),
              SizedBox(height: 24,),
              DropdownMenu<PosTextSize>(
                controller: fontSizeController,
                onSelected: (value) => {textSize = value!},
                inputDecorationTheme: InputDecorationTheme(
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  )
                ),
                width: 200,
                label: Text("Tamanho da fonte"),
                initialSelection: PosTextSize.size1,
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: PosTextSize.size1, label: "1"),
                  DropdownMenuEntry(value: PosTextSize.size2, label: "2"),
                  DropdownMenuEntry(value: PosTextSize.size3, label: "3"),
                  DropdownMenuEntry(value: PosTextSize.size4, label: "4"),
                  DropdownMenuEntry(value: PosTextSize.size5, label: "5"),
                  DropdownMenuEntry(value: PosTextSize.size6, label: "6"),
                  DropdownMenuEntry(value: PosTextSize.size7, label: "7"),
                  DropdownMenuEntry(value: PosTextSize.size8, label: "8"),
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
