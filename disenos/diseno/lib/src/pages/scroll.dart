import 'package:diseno/widgets/bnb.dart';
import 'package:flutter/material.dart';

class ScrollPage extends StatelessWidget {
  final navigationBar = BNB();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragStart: (details) =>
            Navigator.pushNamed(context, 'basico'),
        // onHorizontalDragEnd: (details) =>
        //     Navigator.pushNamed(context, 'botones'),
        child: PageView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            _pagina1(),
            _pagina2(),
          ],
        ),
      ),
      //bottomNavigationBar: navigationBar,
    );
  }

  Widget _pagina1() {
    return Stack(
      children: <Widget>[
        _colorFondo(),
        _imagenFondo(),
        _textos(),
      ],
    );
  }

  Widget _pagina2() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(108, 192, 218, 1.0),
      child: Center(
        child: RaisedButton(
          shape: StadiumBorder(),
          onPressed: () {},
          textColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Text(
              'Bienvenidos',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _colorFondo() {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Color.fromRGBO(108, 192, 218, 1.0),
        ),
      ],
    );
  }

  Widget _imagenFondo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage('assets/scroll.png'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _textos() {
    final estiloTexto = TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 50.0);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Text(
            '11',
            style: estiloTexto,
          ),

          Text(
            'Miercoles',
            style: estiloTexto,
          ),
          //Se usa el expanded para que el container vacio agarre todo el tamano posible de la pantalla
          //Respetando el tamano de los otros widgets
          Expanded(child: Container()),
          Icon(
            Icons.keyboard_arrow_down,
            size: 70.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
