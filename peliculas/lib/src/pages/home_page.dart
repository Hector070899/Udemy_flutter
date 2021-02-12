import 'package:flutter/material.dart';
import 'package:peliculas/src/Widgets/card_swiper_widget.dart';
import 'package:peliculas/src/Widgets/movie_horizontal.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              }),
        ],
      ),
      //Safe area es un widget que coloca las cosas en lugares donde se pueden colocar
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swipearTarjetas(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  //metodo que regresa un widget
  Widget _swipearTarjetas() {
    return FutureBuilder(
      //Recibe como future el metodo de Peliculas provider
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          //Esto solo se debe retornar cuando hay data en el snapshot
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );

    // //Implementacion de metodo getEnCines
    //
    //
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Populares',
                  style: Theme.of(context).textTheme.subtitle1)),
          SizedBox(
            height: 5.0,
          ),
          //Se ejecuta cada vez que se emita un valor en el stream
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              //Si el snapshot tiene datos se ejecuta moviehorizontal
              if (snapshot.hasData) {
                //recibe como parametro la lista de peliculas a mostrar, y la funcion para
                //cargar la siguiente pagina
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
