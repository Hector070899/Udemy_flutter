import 'package:diseno/widgets/bnb.dart';
import 'package:flutter/material.dart';

class BasicoPage extends StatelessWidget {
  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiloSubTitulo = TextStyle(fontSize: 18.0, color: Colors.grey);
  final navigationBar = BNB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _crearImagen(),
            _crearTitulo(),
            _crearIconos(),
            _paragraph(),
            _paragraph(),
            _paragraph(),
            _paragraph(),
            _paragraph(),
            _paragraph(),
          ],
        ),
      ),
      bottomNavigationBar: navigationBar,
    );
  }

  Widget _crearImagen() {
    return Container(
      width: double.infinity,
      child: Image(
        image: NetworkImage(
            'https://loadedlandscapes.com/wp-content/uploads/2019/07/lighting.jpg'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _crearTitulo() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Paisaje colorido',
                    style: estiloTitulo,
                  ),
                  SizedBox(height: 7.0),
                  Text(
                    'Un bonito paisaje',
                    style: estiloSubTitulo,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.star,
              color: Colors.red,
              size: 30.0,
            ),
            Text(
              '41',
              style: TextStyle(fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }

  Widget _crearIconos() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _accion(Icons.call, 'Call'),
        _accion(Icons.near_me, 'Route'),
        _accion(Icons.share, 'Share')
      ],
    );
  }

  //Recibe como argumentos el icono y el texto que contiene
  Widget _accion(IconData icon, String texto) {
    return Column(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.blue,
          size: 40.0,
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          texto,
          style: TextStyle(fontSize: 15.0, color: Colors.blue),
        )
      ],
    );
  }

  Widget _paragraph() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      child: Text(
        'Este parrafo tiene el unico proposito de tener mucho texto de relleno aasi que no me juzguen si algo esta mal escrito por favor te lo suplico la concha de la lora me cago en dios todo esta bien esto es suficiente txto creo que yo que con esto puede funcionar',
        textAlign: TextAlign.justify,
      ),
    );
  }
}
