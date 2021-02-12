import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class BotonesPage extends StatelessWidget {
  const BotonesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _fondoApp(),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _titulos(),
                _botonesRedondeados(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomNavigatioBar(context),
    );
  }

  Widget _fondoApp() {
    //Container que contiene todo el gradiente morado de fondo
    final gradiente = Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(00, 0.6),
          end: FractionalOffset(00, 1.0),
          colors: [
            Color.fromRGBO(52, 54, 101, 1.0),
            Color.fromRGBO(35, 37, 57, 1.0)
          ],
        ),
      ),
    );

    //Container que representa la caja rosada que se agrega como un stack
    //sobre el fondo morado
    final cajaRosada = Transform.rotate(
      angle: -pi / 5.0,
      child: Container(
        height: 340.0,
        width: 340.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.pinkAccent,
            Colors.pink[200],
          ]),
          borderRadius: BorderRadius.circular(80.0),
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        gradiente,
        Positioned(
          child: cajaRosada,
          top: -100.0,
        )
      ],
    );
  }

  Widget _titulos() {
    final estilo1 = TextStyle(
        color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold);

    final estilo2 = TextStyle(
      color: Colors.white,
      fontSize: 18.0,
    );

    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Classify transaction',
              style: estilo1,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Classified transaction into a particular defined category',
              style: estilo2,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavigatioBar(BuildContext context) {
    return Theme(
        //A traves del theme, logramos cambiar el fondo del bottomNavigationbar sin cambiar el tema de
        //toda la app
        data: Theme.of(context).copyWith(
            canvasColor: Color.fromRGBO(55, 57, 84, 1.0),
            primaryColor: Colors.pinkAccent,
            //De esta manera se cambia el color de los items no usados
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: TextStyle(color: Colors.grey))),
        child: BottomNavigationBar(items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
              size: 30.0,
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bubble_chart,
              size: 30.0,
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.supervised_user_circle,
              size: 30.0,
            ),
            title: Container(),
          )
        ]));
  }

  Widget _botonesRedondeados() {
    //Contenido de children van a ser las columnas
    return Table(
      children: [
        //Tablerow representa la fila de cada columna
        TableRow(children: [
          _crearBotonRedondeado(Colors.blue, Icons.border_all, 'General'),
          _crearBotonRedondeado(
              Colors.purpleAccent, Icons.directions_bus, 'Bus'),
        ]),
        TableRow(children: [
          _crearBotonRedondeado(Colors.red, Icons.account_balance, 'House'),
          _crearBotonRedondeado(Colors.greenAccent, Icons.adb, 'Android'),
        ]),
        TableRow(children: [
          _crearBotonRedondeado(
              Colors.yellow, Icons.airplanemode_active, 'Plane'),
          _crearBotonRedondeado(Colors.cyan, Icons.local_car_wash, 'Car'),
        ]),
        TableRow(children: [
          _crearBotonRedondeado(Colors.orange, Icons.work, 'Work'),
          _crearBotonRedondeado(Colors.lime, Icons.directions_boat, 'Boat'),
        ]),
      ],
    );
  }

  Widget _crearBotonRedondeado(Color color, IconData icono, String texto) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          height: 180.0,
          margin: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: Color.fromRGBO(62, 66, 107, 0.7),
              borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              CircleAvatar(
                backgroundColor: color,
                radius: 35.0,
                child: Icon(
                  icono,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
              Text(
                texto,
                style: TextStyle(color: color),
              ),
              SizedBox(
                height: 5.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
