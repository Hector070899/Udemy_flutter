import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert Page'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Mostrar Alerta'),
          color: Colors.blue,
          onPressed: () => _mostrarAlert(context),
          textColor: Colors.white,
          shape: StadiumBorder(),
        ),
      ),
      //FAB que sirve para retornar a la pagina principal
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_location),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }

  //Funcion que muestra una alerta
  //Recibe el buildcontext como parametro desde onPressed
  void _mostrarAlert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Titulo'),
            content: Column(
              //Propiedad que permite que la column
              //Se adapate al contenido que tiene sea max o min
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Contenido de la caja de la alerta'),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: FlutterLogo(
                    size: 100.0,
                  ),
                )
              ],
            ),
            //Devuelve una lista de widgets
            actions: <Widget>[
              FlatButton(
                child: Text('Cancelar'),
                //Metodo para regresar al context
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
