import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  //Declaracion del estilo del texto
  final estilo = TextStyle(fontSize: 25.0);
  final conteo = 0;

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
              'Numero de tabs',
              style: estilo,
            ),
            Text('$conteo', style: estilo),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print('Hola Mundo!');
        },
      ),
    );
  }
}
