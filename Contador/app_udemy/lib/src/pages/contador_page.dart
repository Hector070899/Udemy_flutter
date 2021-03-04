import 'package:flutter/material.dart';

class ContadorPage extends StatefulWidget {
  @override //Nueva instancia de la clase
  createState() => _ContadorPageState();
}

//Es el estado de la clase ContadorPage
//Solo le usa en esta clase por lo que es privado
class _ContadorPageState extends State<ContadorPage> {
  //Declaracion del estilo del texto
  final _estilo = TextStyle(fontSize: 25.0);
  int _conteo = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Titulo'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Numero de tabs:',
              style: _estilo,
            ),
            Text('$_conteo', style: _estilo),
          ],
        ),
      ),
      floatingActionButton: _crearBotones(),
    );
  }

  //Creacion de metodo _crearBotones
  Widget _crearBotones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(
          width: 30.0,
        ),
        FloatingActionButton(
          onPressed: _agregar,
          child: Icon(Icons.add),
        ),
        Expanded(
          child: SizedBox(),
        ),
        FloatingActionButton(
          onPressed: _restar,
          child: Icon(Icons.remove),
        ),
        SizedBox(
          width: 10.0,
        ),
        FloatingActionButton(
          onPressed: _cero,
          child: Icon(Icons.exposure_zero),
        ),
      ],
    );
  }

  void _agregar() {
    setState(() => _conteo++);
  }

  void _restar() {
    setState(() => _conteo--);
  }

  void _cero() {
    setState(() => _conteo = 0);
  }
}
