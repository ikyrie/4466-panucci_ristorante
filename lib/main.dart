import 'package:flutter/material.dart';
import 'package:panucci_ristorante/injection/injection_container.dart';
import 'package:panucci_ristorante/screens/permissions_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const PanucciDelivery());
}

class PanucciDelivery extends StatelessWidget {
const PanucciDelivery({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 0, 0), ), useMaterial3: true),
      home: PermissionsScreen(),
    );
  }
}
