import 'package:diseno/src/pages/basico_page.dart';
import 'package:diseno/src/pages/botones_page.dart';
import 'package:diseno/src/pages/scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Barra de status transparente
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //Definir la ruta de inicio basico que hace referenci a basicoPage
      initialRoute: 'botones',
      title: 'Disenos',
      routes: {
        'basico': (BuildContext context) => BasicoPage(),
        'scroll': (BuildContext context) => ScrollPage(),
        'botones': (BuildContext context) => BotonesPage()
      },
    );
  }
}
