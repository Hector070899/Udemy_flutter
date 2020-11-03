import 'package:componentes/src/pages/alert_page.dart';
import 'package:componentes/src/pages/card_page.dart';
import 'package:componentes/src/routes/routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Componentes App',
        debugShowCheckedModeBanner: false,
        //home: HomePage(),
        initialRoute: '/',
        //Route que define la direccion route
        //a traves de un mapa de String y funciones
        routes: getApplicationRoutes(),
        onGenerateRoute: (RouteSettings settings) {
          print('Ruta llamada: ${settings.name}');

          return MaterialPageRoute(
              builder: (BuildContext context) => AlertPage());
        });
  }
}
