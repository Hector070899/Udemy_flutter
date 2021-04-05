import 'package:flutter/material.dart';
import 'package:user_preferences/src/shared_prefs/preferencias_usuario.dart';
import 'package:user_preferences/src/widgets/drawer_widget.dart';

class HomePage extends StatelessWidget {
  //Propiedad estatica para acceder al nombre de la pagina
  static final String routeName = 'home';
  final prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = HomePage.routeName;
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferencias'),
        backgroundColor: (prefs.colorSecundario) ? Colors.teal : Colors.black,
      ),
      drawer: DrawerWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Color secundario : ${prefs.colorSecundario} '),
          Divider(),
          Text('Genero : ${prefs.genero}'),
          Divider(),
          // Text('Nombre de Usuario : ${prefs.nombreUsuario} '),
          Text('Nombre de usuario : ${prefs.nombreUsuario}'),
          Divider(),
        ],
      ),
    );
  }
}
