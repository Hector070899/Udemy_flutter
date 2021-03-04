import 'dart:async';
import 'package:flutter/material.dart';

class ListaPage extends StatefulWidget {
  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  //Objeto que permite controlar un scroll
  ScrollController _scrollController = ScrollController();

  List<int> _listan = List();
  int _ultimoN = 0;
  //Propiedad que indica cuando se esta o no cargando
  //las imagenes
  //Se va a cambiar cada vez que se llame fetchData
  bool _isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _agregar10();

    //Listener que detecta cada vez que se hace scroll
    _scrollController.addListener(() {
      //Si la posicion actual de los pixeles es igual al tamano maximo
      //del scroll se implementa el metodo agregar 10
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchData();
      }
    });
  }

  //Manera de desechar el listener de _scrollController
  //se dispara cuando la pagina es destruida
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Listas'),
        ),
        body: Stack(
          children: <Widget>[
            _crearLista(),
            _crearLoading(),
          ],
        ));
  }

  Widget _crearLista() {
    return RefreshIndicator(
      onRefresh: obtenerPag,
      child: ListView.builder(
        controller: _scrollController,
        //La cantidad de elementos en la lista es la cantidad
        //de items que tendra el metodo
        itemCount: _listan.length,
        itemBuilder: (BuildContext context, int index) {
          //Lista que se crea para tener la posicion
          //Esta imagen contiene el valor de la posicion de la lista
          final imagen = _listan[index];
          return FadeInImage(
              placeholder: AssetImage('assets/jar-loading.gif'),
              image:
                  NetworkImage('https://picsum.photos/500/300/?image=$imagen'));
        },
      ),
    );
  }

  //Funcion que sirve para el onRefresh
  Future<void> obtenerPag() async {
    final duration = Duration(seconds: 2);
    Timer(duration, () {
      //Limpia la lista
      //Le suma uno al index de la lista para no iniciar de 0\
      //Suma otras 10 imagenes
      _listan.clear();
      _ultimoN++;
      _agregar10();
    });

    return Future.delayed(duration);
  }

  //Metodo que agrega 10 imagenes a la lista
  void _agregar10() {
    for (var i = 1; i < 10; i++) {
      //variable que detecta cuando se crea el stf widget
      _ultimoN++;
      //Agregar el ultimoN a la lista
      _listan.add(_ultimoN);
    }
    //Setstate que indica que hay que redibujar el widget
    setState(() {});
  }

  Future<Null> _fetchData() async {
    _isloading = true;
    setState(() {});
    final duration = Duration(seconds: 2);
    Timer(duration, respuestaHTTP);
  }

  void respuestaHTTP() {
    _isloading = false;
    //Esta modficicacion del controller permite mover un poco
    //la lista al final para demostrar que hay nuevos elementos
    _scrollController.animateTo(_scrollController.position.pixels + 100,
        curve: Curves.fastOutSlowIn, duration: Duration(milliseconds: 250));
    _agregar10();
  }

  Widget _crearLoading() {
    if (_isloading) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
          SizedBox(
            height: 15.0,
          )
        ],
      );
    } else {
      return Container();
    }
  }
}
