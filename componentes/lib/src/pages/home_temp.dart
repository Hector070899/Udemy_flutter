import 'package:flutter/material.dart';

class HomePageTemp extends StatelessWidget {
  final opciones = ['Uno', 'Dos', 'Tres', 'Cuatro', 'Cinco'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes Temp'),
        centerTitle: true,
      ),
      body: ListView(
        //children: _crearItems(),
        children: _crearItemsCorta(),
      ),
    );
  }

  List<Widget> _crearItemsCorta() {
    //Regresa una nueva lista iterable
    //donde los elementos pasan por una funcion definida
    //que recibe como argumento el tipo de la lista, en este caso. item
    return opciones.map((item) {
      //Se creo una nueva lista cuyos items
      //Han sido transdormado por este metodo dentro de
      //map
      return Column(
        children: <Widget>[
          ListTile(
            title: Text(item + '!'),
            subtitle: Text('Cualquier cosa'),
            leading: Icon(Icons.ac_unit),
            trailing: Icon(Icons.arrow_right),
            onTap: () {},
          ),
          Divider()
        ],
      );
      //Se convierte a to list para devolver una lista,
      //de otra forma seria lista iterable
    }).toList();
  }
}
