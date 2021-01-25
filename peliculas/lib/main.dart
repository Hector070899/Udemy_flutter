import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peliculas',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      //mapa de rutas
      //El '/' apunta al BuildContext que retorna HomePage()
      routes: {
        '/': (BuildContext context) => HomePage(),
      },
    );
  }
}
