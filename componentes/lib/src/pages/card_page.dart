import 'package:flutter/material.dart';

//Esta clase card devuelve todas las cards
class CardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
      ),
      //El body es un ListView de cards
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          _cardTipo1(),
          SizedBox(
            height: 30.0,
          ),
          _cardTipo2(),
        ],
      ),
    );
  }

  Widget _cardTipo1() {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Soy el titulo de esta tarjeta'),
            subtitle:
                Text('Esta es la descripcion de la tarjeta que quiero mostrar'),
            leading: Icon(
              Icons.photo_album,
              color: Colors.blue,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                onPressed: () {},
                child: Text('Cancelar'),
              ),
              FlatButton(
                onPressed: () {},
                child: Text('Ok'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cardTipo2() {
    return Card(
      child: Column(
        children: <Widget>[
          //Sirve para usar una imagen o gif mientras se carga la imagen que se quiere mostrar
          FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(
                'https://cdn.cnn.com/cnnnext/dam/assets/190517091026-07-unusual-landscapes-travel-full-169.jpg'),
            fadeInDuration: Duration(milliseconds: 200),
            height: 300.0,
            fit: BoxFit.cover,
          ),
          // Image(
          //   image: NetworkImage(
          //       'https://cdn.cnn.com/cnnnext/dam/assets/190517091026-07-unusual-landscapes-travel-full-169.jpg'),
          // ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('No tengo idea de que poner'),
          )
        ],
      ),
    );
  }
}
