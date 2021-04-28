import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/provider.dart';
import 'package:login_bloc/src/pages/home_page.dart';
import 'package:login_bloc/src/pages/login_page.dart';
import 'package:login_bloc/src/pages/producto_page.dart';
import 'package:login_bloc/src/pages/registro_page.dart';
import 'package:login_bloc/src/user_preferences/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Ahora el nivel mas alto de la app es Provider y su child es el MaterialApp
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),
          'producto': (BuildContext context) => ProductoPage(),
          'registro': (BuildContext context) => RegistroPage()
        },
        theme: ThemeData(primaryColor: Colors.deepPurple),
      ),
    );
  }
}
