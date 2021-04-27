import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/provider.dart';
import 'package:login_bloc/src/pages/home_page.dart';
import 'package:login_bloc/src/pages/login_page.dart';
import 'package:login_bloc/src/pages/producto_page.dart';
import 'package:login_bloc/src/pages/registro_page.dart';
import 'package:login_bloc/src/preferencias_usuario/preferencias_usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Implementacion de Prefencias de usuario
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    print(prefs.token ?? 'No tiene token aun');
    //Ahora el nivel mas alto de la app es Provider y su child es el MaterialApp
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'registro': (BuildContext context) => RegistroPage(),
          'home': (BuildContext context) => HomePage(),
          'producto': (BuildContext context) => ProductoPage()
        },
        theme: ThemeData(primaryColor: Colors.deepPurple),
      ),
    );
  }
}
