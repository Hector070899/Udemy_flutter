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

  List<Widget> _crearItems() {
    //Lista dinamica
    List<Widget> lista = List<Widget>();
    //Tipo de dato, options dentro de la lista opciones
    for (String opt in opciones) {
      //Widget temporal que almacena listtile
      final tempWidget = ListTile(
        //Cada titulo muestra las opciones provenientes de opciones
        //a traves de opt
        title: Text(opt),
      );
      //Anade las opt desde tempWidget hacia lista,
      //operador cascade
      lista..add(tempWidget)..add(Divider());
      //Es igual a tener
      //lista.add(tempWidget);
      //lista.add(Divider());
    }
    //Devuelve la lista que muestra las opciones
    return lista;
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
