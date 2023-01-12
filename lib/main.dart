import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'price_screen.dart';

Future main() async {
  await dotenv.load(
      fileName:
          "lib/enviroment.env"); // mergeWith optional, you can include Platform.environment for Mobile/Desktop app

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.lightBlue,
          scaffoldBackgroundColor: Colors.white),
      home: PriceScreen(),
    );
  }
}
