import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //De esta forma se reciben los argumentos
    //En este caso el argumento es el producto y se guarda en args que es usado en el body
    final args = ModalRoute.of(context)?.settings.arguments ?? 'no data';

    return Scaffold(
        appBar: AppBar(
          title: Text('Message'),
        ),
        body: Center(
            child: Text(
          '$args',
          style: TextStyle(fontSize: 30),
        )));
  }
}
