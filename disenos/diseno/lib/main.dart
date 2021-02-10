import 'package:diseno/src/pages/basico_page.dart';
import 'package:diseno/src/pages/scroll.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //Definir la ruta de inicio basico que hace referenci a basicoPage
      initialRoute: 'scroll',
      title: 'Disenos',
      routes: {
        'basico': (BuildContext context) => BasicoPage(),
        'scroll': (BuildContext context) => ScrollPage(),
      },
    );
  }
}
