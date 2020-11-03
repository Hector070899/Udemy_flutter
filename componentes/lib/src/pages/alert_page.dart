import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert Page'),
      ),
      //FAB que sirve para retornar a la pagina principal
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.keyboard_return),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}
